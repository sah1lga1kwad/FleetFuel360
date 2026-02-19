import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar/isar.dart';

import '../models/local/local_log.dart';
import '../models/local/local_location_ping.dart';
import '../models/log_model.dart';
import '../models/location_ping_model.dart';
import 'firestore_service.dart';
import 'storage_service.dart';
import '../utils/constants.dart';

class SyncService {
  final Isar _isar;
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  SyncService(this._isar, this._firestoreService, this._storageService);

  /// Call on app start and whenever connectivity is restored.
  Future<void> syncAll() async {
    await _syncPendingLogs();
    await _syncPendingPings();
  }

  // ─── Logs ─────────────────────────────────────────────────────────────────

  /// Save a new log to Isar (offline-first).
  Future<void> saveLogLocally(LocalLog log) async {
    await _isar.writeTxn(() async {
      await _isar.localLogs.put(log);
    });
  }

  Future<void> _syncPendingLogs() async {
    final pending = await _isar.localLogs
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .findAll();

    for (final localLog in pending) {
      await _syncSingleLog(localLog);
    }
  }

  Future<void> _syncSingleLog(LocalLog localLog) async {
    // Mark as uploading
    await _isar.writeTxn(() async {
      localLog.syncStatus = SyncStatus.uploading;
      localLog.updatedAt = DateTime.now();
      await _isar.localLogs.put(localLog);
    });

    try {
      String? nonFatalSyncError;

      // 1. Upload images
      String? odometerUrl = localLog.odometerImageUrl;
      String? fuelMeterUrl = localLog.fuelMeterImageUrl;
      String? vehicleUrl = localLog.vehicleImageUrl;
      List<String> receiptUrls = List.from(localLog.receiptImageUrls);

      if (localLog.localOdometerImagePath != null &&
          localLog.localOdometerImagePath!.isNotEmpty &&
          odometerUrl == null) {
        try {
          odometerUrl = await _storageService.uploadImage(
            localLog.localOdometerImagePath!,
            StorageService.logImagePath(
                localLog.companyId, localLog.localId, 'odometer'),
          );
        } catch (e) {
          nonFatalSyncError = 'Image upload skipped: $e';
        }
      }

      if (localLog.localFuelMeterImagePath != null &&
          localLog.localFuelMeterImagePath!.isNotEmpty &&
          fuelMeterUrl == null) {
        try {
          fuelMeterUrl = await _storageService.uploadImage(
            localLog.localFuelMeterImagePath!,
            StorageService.logImagePath(
                localLog.companyId, localLog.localId, 'fuel_meter'),
          );
        } catch (e) {
          nonFatalSyncError = 'Image upload skipped: $e';
        }
      }

      if (localLog.localVehicleImagePath != null &&
          localLog.localVehicleImagePath!.isNotEmpty &&
          vehicleUrl == null) {
        try {
          vehicleUrl = await _storageService.uploadImage(
            localLog.localVehicleImagePath!,
            StorageService.logImagePath(
                localLog.companyId, localLog.localId, 'vehicle'),
          );
        } catch (e) {
          nonFatalSyncError = 'Image upload skipped: $e';
        }
      }

      if (localLog.localReceiptImagePaths.isNotEmpty &&
          receiptUrls.isEmpty) {
        try {
          receiptUrls = await _storageService.uploadMultipleImages(
            localLog.localReceiptImagePaths,
            'companies/${localLog.companyId}/logs/${localLog.localId}',
            'receipt',
          );
        } catch (e) {
          nonFatalSyncError = 'Receipt upload skipped: $e';
        }
      }

      // 2. Update local URLs before Firestore write
      await _isar.writeTxn(() async {
        localLog.odometerImageUrl = odometerUrl;
        localLog.fuelMeterImageUrl = fuelMeterUrl;
        localLog.vehicleImageUrl = vehicleUrl;
        localLog.receiptImageUrls = receiptUrls;
        await _isar.localLogs.put(localLog);
      });

      // 3. Build Firestore model and write
      final logModel = _localLogToModel(
        localLog,
        odometerUrl: odometerUrl,
        fuelMeterUrl: fuelMeterUrl,
        vehicleUrl: vehicleUrl,
        receiptUrls: receiptUrls,
      );

      final firestoreId = await _firestoreService.createLog(logModel);

      // 4. Mark synced
      await _isar.writeTxn(() async {
        localLog.firestoreId = firestoreId;
        localLog.syncStatus = SyncStatus.synced;
        localLog.syncAttempts = 0;
        localLog.syncError = nonFatalSyncError;
        localLog.updatedAt = DateTime.now();
        await _isar.localLogs.put(localLog);
      });
    } catch (e) {
      developer.log('Log sync failed', error: e, name: 'SyncService');
      final attempts = localLog.syncAttempts + 1;
      await _isar.writeTxn(() async {
        localLog.syncAttempts = attempts;
        localLog.syncError = e.toString();
        localLog.syncStatus = attempts >= AppConstants.maxSyncAttempts
            ? SyncStatus.failed
            : SyncStatus.pending;
        localLog.updatedAt = DateTime.now();
        await _isar.localLogs.put(localLog);
      });

      if (localLog.syncStatus == SyncStatus.pending) {
        // Exponential backoff
        final delay = Duration(seconds: pow(2, attempts).toInt());
        await Future.delayed(delay);
      }
    }
  }

  // ─── Location Pings ───────────────────────────────────────────────────────

  /// Save a GPS ping locally.
  Future<void> savePingLocally(LocalLocationPing ping) async {
    await _isar.writeTxn(() async {
      await _isar.localLocationPings.put(ping);
    });
  }

  Future<void> _syncPendingPings() async {
    final pending = await _isar.localLocationPings
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .findAll();

    if (pending.isEmpty) return;

    await _hydratePingIdentity(pending);

    final syncable = pending
        .where((ping) => ping.driverId.isNotEmpty && ping.companyId.isNotEmpty)
        .toList();
    if (syncable.isEmpty) return;

    final models = syncable.map(_localPingToModel).toList();

    try {
      await _firestoreService.batchCreateLocationPings(models);

      // Mark all as synced
      final now = DateTime.now();
      await _isar.writeTxn(() async {
        for (final ping in syncable) {
          ping.syncStatus = SyncStatus.synced;
          ping.syncedAt = now;
        }
        await _isar.localLocationPings.putAll(syncable);
      });
    } catch (e) {
      developer.log('Ping batch sync failed', error: e, name: 'SyncService');
      // Leave as pending for next retry
    }
  }

  Future<void> _hydratePingIdentity(List<LocalLocationPing> pings) async {
    final authUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    var driverId = authUid;
    var companyId = '';
    var vehicleId = '';
    var assignmentId = '';

    if (authUid.isNotEmpty) {
      final user = await _firestoreService.getUser(authUid);
      companyId = user?.companyId ?? '';

      final assignment = await _firestoreService.getActiveAssignment(authUid);
      if (assignment != null) {
        vehicleId = assignment.vehicleId;
        assignmentId = assignment.assignmentId;
      }
    }

    if (companyId.isEmpty || vehicleId.isEmpty || assignmentId.isEmpty) {
      final logs = await _isar.localLogs.where().findAll();
      logs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      for (final log in logs) {
        if (driverId.isEmpty && log.driverId.isNotEmpty) {
          driverId = log.driverId;
        }
        if (companyId.isEmpty && log.companyId.isNotEmpty) {
          companyId = log.companyId;
        }
        if (vehicleId.isEmpty && log.vehicleId.isNotEmpty) {
          vehicleId = log.vehicleId;
        }
        if (assignmentId.isEmpty && log.assignmentId.isNotEmpty) {
          assignmentId = log.assignmentId;
        }
        if (driverId.isNotEmpty &&
            companyId.isNotEmpty &&
            vehicleId.isNotEmpty &&
            assignmentId.isNotEmpty) {
          break;
        }
      }
    }

    final toUpdate = <LocalLocationPing>[];
    for (final ping in pings) {
      var changed = false;
      if (ping.driverId.isEmpty && driverId.isNotEmpty) {
        ping.driverId = driverId;
        changed = true;
      }
      if (ping.companyId.isEmpty && companyId.isNotEmpty) {
        ping.companyId = companyId;
        changed = true;
      }
      if (ping.vehicleId.isEmpty && vehicleId.isNotEmpty) {
        ping.vehicleId = vehicleId;
        changed = true;
      }
      if (ping.assignmentId.isEmpty && assignmentId.isNotEmpty) {
        ping.assignmentId = assignmentId;
        changed = true;
      }
      if (changed) {
        toUpdate.add(ping);
      }
    }

    if (toUpdate.isEmpty) return;
    await _isar.writeTxn(() async {
      await _isar.localLocationPings.putAll(toUpdate);
    });
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  LogModel _localLogToModel(
    LocalLog local, {
    String? odometerUrl,
    String? fuelMeterUrl,
    String? vehicleUrl,
    List<String> receiptUrls = const [],
  }) {
    return LogModel(
      logId: local.firestoreId ?? '',
      driverId: local.driverId,
      vehicleId: local.vehicleId,
      companyId: local.companyId,
      assignmentId: local.assignmentId,
      logType: _parseLogType(local.logType),
      category: _parseCategory(local.category),
      amount: local.amount,
      currency: local.currency,
      paidBy: _parsePaidBy(local.paidBy),
      paymentMode: _parsePaymentMode(local.paymentMode),
      description: local.description,
      notes: local.notes,
      receiptImageUrls: receiptUrls,
      odometerImageUrl: odometerUrl,
      fuelMeterImageUrl: fuelMeterUrl,
      vehicleImageUrl: vehicleUrl,
      odometerReading: local.odometerReading,
      fuelQuantityLitres: local.fuelQuantityLitres,
      fuelPricePerLitre: local.fuelPricePerLitre,
      location: LocationData(
        latitude: local.latitude,
        longitude: local.longitude,
        accuracy: local.accuracy,
        address: local.address,
        geohash: local.geohash,
      ),
      deviceContext: DeviceContext(
        speed: local.speed,
        bearing: local.bearing,
        altitude: local.altitude,
        batteryLevel: local.batteryLevel,
        isCharging: local.isCharging,
        networkType: local.networkType,
      ),
      isEdited: local.isEdited,
      createdAt: local.createdAt,
      updatedAt: local.updatedAt,
    );
  }

  LocationPingModel _localPingToModel(LocalLocationPing local) {
    return LocationPingModel(
      pingId: '',
      driverId: local.driverId,
      vehicleId: local.vehicleId,
      companyId: local.companyId,
      assignmentId: local.assignmentId,
      latitude: local.latitude,
      longitude: local.longitude,
      accuracy: local.accuracy,
      altitude: local.altitude,
      speed: local.speed,
      bearing: local.bearing,
      geohash: local.geohash,
      activity: _parseActivity(local.activity),
      isMoving: local.isMoving,
      batteryLevel: local.batteryLevel,
      isCharging: local.isCharging,
      networkType: local.networkType,
      recordedAt: local.recordedAt,
      createdAt: local.recordedAt,
    );
  }

  LogType _parseLogType(String s) =>
      LogType.values.firstWhere((e) => e.name == s, orElse: () => LogType.other);

  LogCategory _parseCategory(String s) =>
      LogCategory.values.firstWhere((e) => e.name == s,
          orElse: () => LogCategory.other);

  PaidBy _parsePaidBy(String s) =>
      PaidBy.values.firstWhere((e) => e.name == s, orElse: () => PaidBy.driver);

  PaymentMode _parsePaymentMode(String s) =>
      PaymentMode.values.firstWhere((e) => e.name == s,
          orElse: () => PaymentMode.cash);

  ActivityType _parseActivity(String s) =>
      ActivityType.values.firstWhere((e) => e.name == s,
          orElse: () => ActivityType.unknown);

  /// Prune synced records older than 30 days.
  Future<void> pruneOldSyncedRecords() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    await _isar.writeTxn(() async {
      await _isar.localLogs
          .filter()
          .syncStatusEqualTo(SyncStatus.synced)
          .createdAtLessThan(cutoff)
          .deleteAll();
      await _isar.localLocationPings
          .filter()
          .syncStatusEqualTo(SyncStatus.synced)
          .recordedAtLessThan(cutoff)
          .deleteAll();
    });
  }
}

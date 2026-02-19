import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'package:fleetfuel_core/fleetfuel_core.dart';

// ─── Infrastructure ───────────────────────────────────────────────────────────

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar must be provided via ProviderScope overrides');
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final isar = ref.watch(isarProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return SyncService(isar, firestoreService, storageService);
});

class TrackingPermissionStatus {
  final bool foregroundLocationGranted;
  final bool backgroundLocationGranted;
  final bool notificationGranted;
  final bool notificationRequired;
  final bool batteryOptimizationIgnored;

  const TrackingPermissionStatus({
    required this.foregroundLocationGranted,
    required this.backgroundLocationGranted,
    required this.notificationGranted,
    required this.notificationRequired,
    required this.batteryOptimizationIgnored,
  });

  bool get allGranted =>
      foregroundLocationGranted &&
      backgroundLocationGranted &&
      (!notificationRequired || notificationGranted) &&
      batteryOptimizationIgnored;
}

final trackingPermissionStatusProvider =
    FutureProvider<TrackingPermissionStatus>((ref) async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return const TrackingPermissionStatus(
      foregroundLocationGranted: true,
      backgroundLocationGranted: true,
      notificationGranted: true,
      notificationRequired: false,
      batteryOptimizationIgnored: true,
    );
  }

  final info = await DeviceInfoPlugin().androidInfo;
  final notificationRequired = info.version.sdkInt >= 33;

  final fgLocationStatus = await Permission.locationWhenInUse.status;
  final bgLocationStatus = await Permission.locationAlways.status;
  final notificationStatus = notificationRequired
      ? await Permission.notification.status
      : PermissionStatus.granted;
  final batteryOptimizationStatus =
      await Permission.ignoreBatteryOptimizations.status;

  return TrackingPermissionStatus(
    foregroundLocationGranted: fgLocationStatus.isGranted,
    backgroundLocationGranted: bgLocationStatus.isGranted,
    notificationGranted: notificationStatus.isGranted,
    notificationRequired: notificationRequired,
    batteryOptimizationIgnored: batteryOptimizationStatus.isGranted,
  );
});

final requiredPermissionsGrantedProvider = Provider<bool>((ref) {
  final status = ref.watch(trackingPermissionStatusProvider).valueOrNull;
  return status?.allGranted ?? false;
});

const _trackingEnabledPrefKey = 'tracking_enabled';

class TrackingEnabledNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_trackingEnabledPrefKey) ?? true;
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_trackingEnabledPrefKey, enabled);
    state = AsyncData(enabled);
  }
}

final trackingEnabledAsyncProvider =
    AsyncNotifierProvider<TrackingEnabledNotifier, bool>(
  TrackingEnabledNotifier.new,
);

final trackingEnabledProvider = Provider<bool>((ref) {
  return ref.watch(trackingEnabledAsyncProvider).valueOrNull ?? true;
});

class TrackingDiagnostics {
  final bool running;
  final int pendingPingCount;
  final int syncedPingCount;
  final DateTime? lastCapturedAt;
  final DateTime? lastSyncedAt;
  final String? lastError;

  const TrackingDiagnostics({
    required this.running,
    required this.pendingPingCount,
    required this.syncedPingCount,
    required this.lastCapturedAt,
    required this.lastSyncedAt,
    required this.lastError,
  });
}

final trackingDiagnosticsProvider = FutureProvider<TrackingDiagnostics>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final isar = ref.read(isarProvider);

  final pending = await isar.localLocationPings
      .filter()
      .syncStatusEqualTo(SyncStatus.pending)
      .count();
  final synced = await isar.localLocationPings
      .filter()
      .syncStatusEqualTo(SyncStatus.synced)
      .count();

  DateTime? parseDate(String key) {
    final raw = prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  var running = prefs.getBool('tracking_running') ?? false;
  try {
    final state = await bg.BackgroundGeolocation.state
        .timeout(const Duration(seconds: 2));
    running = state.enabled;
  } catch (_) {}

  return TrackingDiagnostics(
    running: running,
    pendingPingCount: pending,
    syncedPingCount: synced,
    lastCapturedAt: parseDate('tracking_last_captured_at'),
    lastSyncedAt: parseDate('tracking_last_synced_at'),
    lastError: prefs.getString('tracking_last_error'),
  );
});

LogType _parseLogType(String value) {
  switch (value) {
    case 'fuelFill':
      return LogType.fuelFill;
    case 'cashExpense':
      return LogType.cashExpense;
    case 'paymentReceived':
      return LogType.paymentReceived;
    case 'advance':
      return LogType.advance;
    case 'loan':
      return LogType.loan;
    default:
      return LogType.other;
  }
}

LogCategory _parseCategory(String value) {
  switch (value) {
    case 'fuel':
      return LogCategory.fuel;
    case 'repair':
      return LogCategory.repair;
    case 'food':
      return LogCategory.food;
    case 'toll':
      return LogCategory.toll;
    case 'tyre':
      return LogCategory.tyre;
    case 'oil':
      return LogCategory.oil;
    case 'cleaning':
      return LogCategory.cleaning;
    case 'fine':
      return LogCategory.fine;
    default:
      return LogCategory.other;
  }
}

PaidBy _parsePaidBy(String value) =>
    value == 'company' ? PaidBy.company : PaidBy.driver;

PaymentMode _parsePaymentMode(String value) {
  switch (value) {
    case 'upi':
      return PaymentMode.upi;
    case 'card':
      return PaymentMode.card;
    case 'fuelCard':
      return PaymentMode.fuelCard;
    case 'bankTransfer':
      return PaymentMode.bankTransfer;
    case 'other':
      return PaymentMode.other;
    default:
      return PaymentMode.cash;
  }
}

LogModel _localToLogModel(LocalLog local) {
  return LogModel(
    logId: local.firestoreId ?? local.localId,
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
    receiptImageUrls: local.receiptImageUrls,
    odometerImageUrl: local.odometerImageUrl,
    fuelMeterImageUrl: local.fuelMeterImageUrl,
    vehicleImageUrl: local.vehicleImageUrl,
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
    status: 'active',
    isEdited: local.isEdited,
    createdAt: local.createdAt,
    updatedAt: local.updatedAt,
  );
}

final localUnsyncedLogsStreamProvider = StreamProvider<List<LogModel>>((ref) {
  final isar = ref.watch(isarProvider);
  final user = ref.watch(currentUserProvider);
  final activeCompanyId = user?.companyId;
  final activeDriverId = user?.userId;
  return isar.localLogs.watchLazy(fireImmediately: true).asyncMap((_) async {
    final locals = await isar.localLogs.where().findAll();
    final unsynced = locals.where((log) {
      if (log.syncStatus == SyncStatus.synced) return false;
      if (activeDriverId != null && activeDriverId.isNotEmpty) {
        if (log.driverId != activeDriverId) return false;
      }
      if (activeCompanyId != null && activeCompanyId.isNotEmpty) {
        if (log.companyId != activeCompanyId) return false;
      }
      return true;
    }).toList();
    return unsynced.map(_localToLogModel).toList();
  });
});

// ─── Auth State ───────────────────────────────────────────────────────────────

final authStateStreamProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentFirebaseUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateStreamProvider).valueOrNull;
});

// ─── Current User (Firestore) ─────────────────────────────────────────────────

final currentUserStreamProvider = StreamProvider<UserModel?>((ref) {
  final firebaseUser = ref.watch(currentFirebaseUserProvider);
  if (firebaseUser == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchUser(firebaseUser.uid);
});

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(currentUserStreamProvider).valueOrNull;
});

// ─── Company ─────────────────────────────────────────────────────────────────

final currentCompanyStreamProvider = StreamProvider<CompanyModel?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user?.companyId == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchCompany(user!.companyId!);
});

final currentCompanyProvider = Provider<CompanyModel?>((ref) {
  return ref.watch(currentCompanyStreamProvider).valueOrNull;
});

// ─── Assigned Vehicle ─────────────────────────────────────────────────────────

final assignedVehicleStreamProvider = StreamProvider<VehicleModel?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchAssignedVehicle(
    user.userId,
    companyId: user.companyId,
  );
});

final assignedVehicleProvider = Provider<VehicleModel?>((ref) {
  return ref.watch(assignedVehicleStreamProvider).valueOrNull;
});

// ─── Active Assignment ────────────────────────────────────────────────────────

final activeAssignmentProvider = FutureProvider<VehicleAssignmentModel?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getActiveAssignment(
    user.userId,
    companyId: user.companyId,
  );
});

// ─── Recent Logs (Home Feed) ──────────────────────────────────────────────────

final recentLogsStreamProvider = StreamProvider<List<LogModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchRecentLogs(
    user.userId,
    companyId: user.companyId,
  );
});

// ─── All Assignments ──────────────────────────────────────────────────────────

final allAssignmentsStreamProvider = StreamProvider<List<VehicleAssignmentModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchAllAssignments(
    user.userId,
    companyId: user.companyId,
  );
});

// ─── Ledger Logs ─────────────────────────────────────────────────────────────

final ledgerLogsProvider = StreamProvider<List<LogModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchLedgerLogs(
    user.userId,
    companyId: user.companyId,
  );
});

// ─── All Logs (with optional type filter) ────────────────────────────────────

final allLogsStreamProvider =
    StreamProvider.family<List<LogModel>, LogType?>((ref, logType) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.watchLogs(
    user.userId,
    companyId: user.companyId,
    logTypeFilter: logType == null
        ? null
        : {
            LogType.fuelFill: 'fuel_fill',
            LogType.cashExpense: 'cash_expense',
            LogType.paymentReceived: 'payment_received',
            LogType.advance: 'advance',
            LogType.loan: 'loan',
            LogType.other: 'other',
          }[logType],
  );
});

// ─── Single Log by ID ─────────────────────────────────────────────────────────

final logByIdProvider =
    FutureProvider.family<LogModel?, String>((ref, logId) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getLog(logId);
});

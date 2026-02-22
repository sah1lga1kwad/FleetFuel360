import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show DateTimeRange;

import '../models/company_model.dart';
import '../models/user_model.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_assignment_model.dart';
import '../models/log_model.dart';
import '../models/location_ping_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _isActiveLog(LogModel log) {
    final status = log.status.trim().toLowerCase();
    // Backward compatibility: older logs may not have a status field.
    return status.isEmpty || status == 'active';
  }

  List<LogModel> _filterActiveLogs(List<LogModel> logs) {
    return logs.where(_isActiveLog).toList();
  }

  List<LogModel> _scopeDriverLogsToCompany(
    List<LogModel> logs,
    String? companyId,
  ) {
    if (companyId == null || companyId.isEmpty) return logs;
    return logs
        .where((log) => log.companyId == companyId && log.companyId.isNotEmpty)
        .toList();
  }

  List<LogModel> _mapLogsSafely(List<QueryDocumentSnapshot> docs) {
    final result = <LogModel>[];
    for (final doc in docs) {
      try {
        result.add(LogModel.fromFirestore(doc));
      } catch (e) {
        developer.log(
          'Failed to parse LogModel from Firestore doc ${doc.id}: $e',
          error: e,
          name: 'FirestoreService',
          stackTrace: StackTrace.current,
        );
      }
    }
    return result;
  }

  List<LocationPingModel> _mapPingsSafely(List<QueryDocumentSnapshot> docs) {
    final result = <LocationPingModel>[];
    for (final doc in docs) {
      try {
        result.add(LocationPingModel.fromFirestore(doc));
      } catch (e) {
        developer.log(
          'Failed to parse LocationPingModel from Firestore doc ${doc.id}: $e',
          error: e,
          name: 'FirestoreService',
          stackTrace: StackTrace.current,
        );
      }
    }
    return result;
  }

  // ─── Companies ───────────────────────────────────────────────────────────

  Future<CompanyModel?> getCompanyByCode(String code) async {
    final query = await _db
        .collection('companies')
        .where('companyCode', isEqualTo: code.toUpperCase())
        .where('isActive', isEqualTo: true)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return CompanyModel.fromFirestore(query.docs.first);
  }

  Future<void> addDriverToCompany(String companyId, String driverId) async {
    await _db.collection('companies').doc(companyId).update({
      'memberDriverIds': FieldValue.arrayUnion([driverId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeDriverFromCompany(
      String companyId, String driverId) async {
    await _db.collection('companies').doc(companyId).update({
      'memberDriverIds': FieldValue.arrayRemove([driverId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<CompanyModel?> watchCompany(String companyId) {
    return _db
        .collection('companies')
        .doc(companyId)
        .snapshots()
        .map((doc) => doc.exists ? CompanyModel.fromFirestore(doc) : null);
  }

  Future<CompanyModel?> getCompany(String companyId) async {
    final doc = await _db.collection('companies').doc(companyId).get();
    if (!doc.exists) return null;
    return CompanyModel.fromFirestore(doc);
  }

  // ─── Users ───────────────────────────────────────────────────────────────

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.userId).set(user.toFirestore());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(userId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<UserModel?> watchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
  }

  // ─── Vehicles ─────────────────────────────────────────────────────────────

  Stream<VehicleModel?> watchAssignedVehicle(
    String driverId, {
    String? companyId,
  }) {
    Query query = _db
        .collection('vehicles')
        .where('currentDriverId', isEqualTo: driverId)
        .where('isActive', isEqualTo: true);
    return query.limit(10).snapshots().map((result) {
      final vehicles = result.docs.map(VehicleModel.fromFirestore).toList();
      if (companyId == null || companyId.isEmpty) {
        return vehicles.isEmpty ? null : vehicles.first;
      }
      final scoped = vehicles.where((v) => v.companyId == companyId).toList();
      return scoped.isEmpty ? null : scoped.first;
    });
  }

  Future<VehicleModel?> getVehicle(String vehicleId) async {
    final doc = await _db.collection('vehicles').doc(vehicleId).get();
    if (!doc.exists) return null;
    return VehicleModel.fromFirestore(doc);
  }

  // ─── Vehicle Assignments ─────────────────────────────────────────────────

  Future<VehicleAssignmentModel?> getActiveAssignment(
    String driverId, {
    String? companyId,
  }) async {
    Query query = _db
        .collection('vehicleAssignments')
        .where('driverId', isEqualTo: driverId)
        .where('isActive', isEqualTo: true);
    final result = await query.limit(20).get();
    if (result.docs.isEmpty) return null;
    final assignments =
        result.docs.map(VehicleAssignmentModel.fromFirestore).toList();
    if (companyId == null || companyId.isEmpty) return assignments.first;
    final scoped = assignments.where((a) => a.companyId == companyId).toList();
    return scoped.isEmpty ? null : scoped.first;
  }

  Stream<List<VehicleAssignmentModel>> watchAllAssignments(
    String driverId, {
    String? companyId,
  }) {
    Query query = _db
        .collection('vehicleAssignments')
        .where('driverId', isEqualTo: driverId);
    return query
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((result) {
      final assignments =
          result.docs.map(VehicleAssignmentModel.fromFirestore).toList();
      if (companyId == null || companyId.isEmpty) return assignments;
      return assignments.where((a) => a.companyId == companyId).toList();
    });
  }

  // ─── Logs ─────────────────────────────────────────────────────────────────

  Future<String> createLog(LogModel log) async {
    try {
      final ref = _db.collection('logs').doc();

      developer.log(
        'createLog: Converting LogModel to Firestore format. driverId=${log.driverId}, '
        'companyId=${log.companyId}, logType=${log.logType}, paidBy=${log.paidBy}',
        name: 'FirestoreService',
      );

      // Convert to Firestore format (this can fail if data is malformed)
      late Map<String, dynamic> data;
      try {
        data = log.toFirestore();
        developer.log(
          'createLog: Conversion succeeded. Fields: ${data.keys.join(", ")}',
          name: 'FirestoreService',
        );
      } catch (e) {
        final errorMsg =
            'createLog: CONVERSION ERROR - Failed to convert LogModel.toFirestore(): $e';
        developer.log(
          errorMsg,
          error: e,
          name: 'FirestoreService',
          stackTrace: StackTrace.current,
        );
        throw Exception(errorMsg);
      }

      data['logId'] = ref.id;
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      developer.log(
        'createLog: Writing to Firestore. logId=${ref.id}, driverId=${log.driverId}, '
        'companyId=${log.companyId}, vehicleId=${log.vehicleId}',
        name: 'FirestoreService',
      );

      await ref.set(data);
      developer.log(
        'createLog: Successfully written to Firestore. ${ref.id}',
        name: 'FirestoreService',
      );
      return ref.id;
    } on FirebaseException catch (e) {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
      final errorMsg =
          'createLog FIREBASE ERROR (uid=$uid, driverId=${log.driverId}, '
          'companyId=${log.companyId}): ${e.message ?? e.code}';
      developer.log(
        errorMsg,
        error: e,
        name: 'FirestoreService',
        stackTrace: StackTrace.current,
      );
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: errorMsg,
      );
    } catch (e) {
      // Catch ALL other exceptions (conversion errors, etc.)
      final uid = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
      final errorMsg =
          'createLog GENERAL ERROR (uid=$uid, driverId=${log.driverId}, '
          'companyId=${log.companyId}): $e';
      developer.log(
        errorMsg,
        error: e,
        name: 'FirestoreService',
        stackTrace: StackTrace.current,
      );
      throw Exception(errorMsg);
    }
  }

  Future<void> updateLog(String logId, Map<String, dynamic> data) async {
    await _db.collection('logs').doc(logId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<LogModel>> watchRecentLogs(
    String driverId, {
    String? companyId,
    int limit = 10,
  }) {
    Query query = _db.collection('logs').where('driverId', isEqualTo: driverId);
    return query
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((result) {
      final logs = _filterActiveLogs(_mapLogsSafely(result.docs));
      return _scopeDriverLogsToCompany(logs, companyId);
    });
  }

  Stream<List<LogModel>> watchLogs(
    String driverId, {
    String? companyId,
    String? logTypeFilter,
    int? limit,
  }) {
    Query query = _db.collection('logs').where('driverId', isEqualTo: driverId);
    query = query.orderBy('createdAt', descending: true);
    query = query.limit(limit ?? 200);

    return query.snapshots().map((result) {
      var logs = _filterActiveLogs(_mapLogsSafely(result.docs));
      logs = _scopeDriverLogsToCompany(logs, companyId);
      if (logTypeFilter != null && logTypeFilter.isNotEmpty) {
        final target = _toLogTypeName(logTypeFilter);
        logs = logs.where((l) => l.logType.name == target).toList();
      }
      if (limit != null && logs.length > limit) {
        logs = logs.take(limit).toList();
      }
      return logs;
    });
  }

  Future<List<LogModel>> getLogsPage(
    String driverId, {
    String? companyId,
    DocumentSnapshot? lastDoc,
    int pageSize = 20,
    String? logTypeFilter,
  }) async {
    Query query = _db.collection('logs').where('driverId', isEqualTo: driverId);
    query = query.orderBy('createdAt', descending: true).limit(pageSize);
    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final result = await query.get();
    var logs = _scopeDriverLogsToCompany(
        _filterActiveLogs(_mapLogsSafely(result.docs)), companyId);
    if (logTypeFilter != null && logTypeFilter.isNotEmpty) {
      final target = _toLogTypeName(logTypeFilter);
      logs = logs.where((l) => l.logType.name == target).toList();
    }
    return logs;
  }

  Future<LogModel?> getLog(String logId) async {
    final doc = await _db.collection('logs').doc(logId).get();
    if (!doc.exists) return null;
    return LogModel.fromFirestore(doc);
  }

  Stream<List<LogModel>> watchVehicleLogs(String vehicleId, {int limit = 20}) {
    return _db
        .collection('logs')
        .where('vehicleId', isEqualTo: vehicleId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((query) => _filterActiveLogs(_mapLogsSafely(query.docs)));
  }

  Stream<List<LogModel>> watchLedgerLogs(
    String driverId, {
    String? companyId,
  }) {
    return watchLogs(driverId, companyId: companyId);
  }

  // ─── Location Pings ───────────────────────────────────────────────────────

  Future<String> createLocationPing(LocationPingModel ping) async {
    final ref = _db.collection('locationPings').doc();
    final data = ping.toFirestore();
    data['pingId'] = ref.id;
    await ref.set(data);
    return ref.id;
  }

  Future<void> batchCreateLocationPings(List<LocationPingModel> pings) async {
    const batchSize = 500;
    for (var i = 0; i < pings.length; i += batchSize) {
      final batch = _db.batch();
      final chunk = pings.skip(i).take(batchSize);
      for (final ping in chunk) {
        final ref = _db.collection('locationPings').doc();
        final data = ping.toFirestore();
        data['pingId'] = ref.id;
        batch.set(ref, data);
      }
      await batch.commit();
    }
  }

  // ─── Manager: Company ────────────────────────────────────────────────────

  Future<void> createCompany(CompanyModel company) async {
    await _db.collection('companies').doc(company.companyId).set({
      ...company.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ─── Manager: Drivers & Vehicles ─────────────────────────────────────────

  Stream<List<UserModel>> watchCompanyDrivers(String companyId) {
    return _db
        .collection('users')
        .where('companyId', isEqualTo: companyId)
        .snapshots()
        .map((snap) => snap.docs
            .map(UserModel.fromFirestore)
            .where((u) => u.role == 'driver')
            .toList());
  }

  Stream<List<VehicleModel>> watchCompanyVehicles(String companyId) {
    return _db
        .collection('vehicles')
        .where('companyId', isEqualTo: companyId)
        .snapshots()
        .map((snap) => snap.docs.map(VehicleModel.fromFirestore).toList());
  }

  Stream<List<VehicleAssignmentModel>> watchActiveAssignments(
      String companyId) {
    return _db
        .collection('vehicleAssignments')
        .where('companyId', isEqualTo: companyId)
        .snapshots()
        .map((snap) => snap.docs
            .map(VehicleAssignmentModel.fromFirestore)
            .where((a) => a.isActive)
            .toList());
  }

  // ─── Manager: Logs ───────────────────────────────────────────────────────

  Stream<List<LogModel>> watchCompanyLogs(
    String companyId, {
    String? driverId,
    String? vehicleId,
    String? logType,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  }) {
    Query query =
        _db.collection('logs').where('companyId', isEqualTo: companyId);

    return query.snapshots().map((snap) {
      var logs = _filterActiveLogs(_mapLogsSafely(snap.docs));
      if (driverId != null && driverId.isNotEmpty) {
        logs = logs.where((l) => l.driverId == driverId).toList();
      }
      if (vehicleId != null && vehicleId.isNotEmpty) {
        logs = logs.where((l) => l.vehicleId == vehicleId).toList();
      }
      if (logType != null && logType.isNotEmpty) {
        final target = _toLogTypeName(logType);
        logs = logs.where((l) => l.logType.name == target).toList();
      }
      if (startDate != null) {
        logs = logs.where((l) => !l.createdAt.isBefore(startDate)).toList();
      }
      if (endDate != null) {
        logs = logs.where((l) => !l.createdAt.isAfter(endDate)).toList();
      }
      logs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (logs.length > limit) {
        logs = logs.take(limit).toList();
      }
      return logs;
    });
  }

  Future<List<LogModel>> getDriverLogs(
    String driverId, {
    String? companyId,
    DateTimeRange? range,
  }) async {
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .orderBy('createdAt', descending: true)
        .limit(200);
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    if (range != null) {
      query = query
          .where(
            'createdAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where(
            'createdAt',
            isLessThanOrEqualTo: Timestamp.fromDate(range.end),
          );
    }

    try {
      final snap = await query.get();
      return _filterActiveLogs(_mapLogsSafely(snap.docs));
    } on FirebaseException {
      // Fallback for missing composite indexes on scoped query.
      Query fallback = _db
          .collection('logs')
          .where('driverId', isEqualTo: driverId)
          .orderBy('createdAt', descending: true)
          .limit(200);
      if (range != null) {
        fallback = fallback
            .where(
              'createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
            )
            .where(
              'createdAt',
              isLessThanOrEqualTo: Timestamp.fromDate(range.end),
            );
      }
      final snap = await fallback.get();
      final logs = _filterActiveLogs(_mapLogsSafely(snap.docs));
      if (companyId == null || companyId.isEmpty) return logs;
      return logs.where((l) => l.companyId == companyId).toList();
    }
  }

  Future<List<LogModel>> getVehicleLogs(
    String vehicleId, {
    int limit = 100,
  }) async {
    final snap = await _db
        .collection('logs')
        .where('vehicleId', isEqualTo: vehicleId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return _filterActiveLogs(_mapLogsSafely(snap.docs));
  }

  // ─── Manager: Location ───────────────────────────────────────────────────

  Future<List<LocationPingModel>> getDriverPings(
    String driverId, {
    String? companyId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    Query query = _db
        .collection('locationPings')
        .where('driverId', isEqualTo: driverId)
        .orderBy('recordedAt', descending: false)
        .limit(500);
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    query = query
        .where(
          'recordedAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
        )
        .where('recordedAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate));
    try {
      final snap = await query.get();
      return _mapPingsSafely(snap.docs);
    } on FirebaseException {
      // Fallback for missing composite indexes on scoped query.
      final snap = await _db
          .collection('locationPings')
          .where('driverId', isEqualTo: driverId)
          .where(
            'recordedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          )
          .where('recordedAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('recordedAt', descending: false)
          .limit(500)
          .get();
      final pings = _mapPingsSafely(snap.docs);
      if (companyId == null || companyId.isEmpty) return pings;
      return pings.where((p) => p.companyId == companyId).toList();
    }
  }

  Future<void> updateDriverLastKnownLocation(
    String driverId,
    Map<String, dynamic> locationData,
  ) async {
    await _db.collection('users').doc(driverId).update({
      'lastKnownLocation': locationData,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ─── Manager: Payments & Vehicles ────────────────────────────────────────

  Future<void> managerCreatePayment({
    required String driverId,
    required String vehicleId,
    required String companyId,
    required String assignmentId,
    required int amount,
    required String paymentMode,
    required String notes,
    required String managerId,
  }) async {
    final logId = _db.collection('logs').doc().id;
    await _db.collection('logs').doc(logId).set({
      'logId': logId,
      'driverId': driverId,
      'vehicleId': vehicleId,
      'companyId': companyId,
      'assignmentId': assignmentId,
      'logType': 'payment_received',
      'category': 'other',
      'amount': amount,
      'currency': 'INR',
      'paidBy': 'company',
      'paymentMode': paymentMode,
      'description': 'Payment recorded by manager',
      'notes': notes,
      'receiptImageUrls': [],
      'odometerReading': 0,
      'fuelQuantityLitres': 0.0,
      'fuelPricePerLitre': 0.0,
      'location': {
        'latitude': 0.0,
        'longitude': 0.0,
        'accuracy': 0.0,
        'address': '',
        'geohash': '',
      },
      'deviceContext': {
        'speed': 0.0,
        'bearing': 0.0,
        'altitude': 0.0,
        'batteryLevel': 0,
        'isCharging': false,
        'networkType': 'wifi',
      },
      'odometerReadingExtracted': null,
      'fuelLevelExtracted': null,
      'receiptAmountExtracted': null,
      'extractionConfidence': null,
      'isEdited': false,
      'editHistory': [],
      'status': 'active',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String> addVehicle(
    Map<String, dynamic> vehicleData,
    String companyId,
  ) async {
    final docRef = _db.collection('vehicles').doc();
    await docRef.set({
      ...vehicleData,
      'vehicleId': docRef.id,
      'companyId': companyId,
      'currentDriverId': null,
      'currentAssignmentId': null,
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await _db.collection('companies').doc(companyId).update({
      'vehicleIds': FieldValue.arrayUnion([docRef.id]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  Future<String> assignVehicleToDriver({
    required String vehicleId,
    required String driverId,
    required String companyId,
    required int startOdometerReading,
    required String managerId,
  }) async {
    final batch = _db.batch();
    final assignmentRef = _db.collection('vehicleAssignments').doc();

    batch.set(assignmentRef, {
      'assignmentId': assignmentRef.id,
      'vehicleId': vehicleId,
      'driverId': driverId,
      'companyId': companyId,
      'startDate': FieldValue.serverTimestamp(),
      'endDate': null,
      'isActive': true,
      'assignedByManagerId': managerId,
      'startOdometerReading': startOdometerReading,
      'endOdometerReading': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    batch.update(_db.collection('vehicles').doc(vehicleId), {
      'currentDriverId': driverId,
      'currentAssignmentId': assignmentRef.id,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
    return assignmentRef.id;
  }
}

String _toLogTypeName(String raw) {
  switch (raw) {
    case 'fuel_fill':
      return LogType.fuelFill.name;
    case 'cash_expense':
      return LogType.cashExpense.name;
    case 'payment_received':
      return LogType.paymentReceived.name;
    case 'advance':
      return LogType.advance.name;
    case 'loan':
      return LogType.loan.name;
    case 'other':
      return LogType.other.name;
    default:
      return raw;
  }
}

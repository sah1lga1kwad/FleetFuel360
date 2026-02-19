import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show DateTimeRange;

import '../models/company_model.dart';
import '../models/user_model.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_assignment_model.dart';
import '../models/log_model.dart';
import '../models/location_ping_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    return query.limit(1).snapshots().map(
          (result) => result.docs.isEmpty
              ? null
              : VehicleModel.fromFirestore(result.docs.first),
        );
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
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    final result = await query.limit(1).get();
    if (result.docs.isEmpty) return null;
    return VehicleAssignmentModel.fromFirestore(result.docs.first);
  }

  Stream<List<VehicleAssignmentModel>> watchAllAssignments(
    String driverId, {
    String? companyId,
  }) {
    Query query = _db
        .collection('vehicleAssignments')
        .where('driverId', isEqualTo: driverId);
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    return query
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((result) =>
            result.docs.map(VehicleAssignmentModel.fromFirestore).toList());
  }

  // ─── Logs ─────────────────────────────────────────────────────────────────

  Future<String> createLog(LogModel log) async {
    final ref = _db.collection('logs').doc();
    final data = log.toFirestore();
    data['logId'] = ref.id;
    data['createdAt'] = FieldValue.serverTimestamp();
    data['updatedAt'] = FieldValue.serverTimestamp();
    await ref.set(data);
    return ref.id;
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
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active');
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    return query
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((result) => result.docs.map(LogModel.fromFirestore).toList());
  }

  Stream<List<LogModel>> watchLogs(
    String driverId, {
    String? companyId,
    String? logTypeFilter,
    int? limit,
  }) {
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active');
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    query = query.orderBy('createdAt', descending: true);

    if (logTypeFilter != null) {
      query = query.where('logType', isEqualTo: logTypeFilter);
    }
    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
          (result) => result.docs.map(LogModel.fromFirestore).toList(),
        );
  }

  Future<List<LogModel>> getLogsPage(
    String driverId, {
    String? companyId,
    DocumentSnapshot? lastDoc,
    int pageSize = 20,
    String? logTypeFilter,
  }) async {
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active');
    if (companyId != null && companyId.isNotEmpty) {
      query = query.where('companyId', isEqualTo: companyId);
    }
    query = query.orderBy('createdAt', descending: true).limit(pageSize);

    if (logTypeFilter != null) {
      query = query.where('logType', isEqualTo: logTypeFilter);
    }
    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final result = await query.get();
    return result.docs.map(LogModel.fromFirestore).toList();
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
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((query) => query.docs.map(LogModel.fromFirestore).toList());
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
        .where('role', isEqualTo: 'driver')
        .snapshots()
        .map((snap) => snap.docs.map(UserModel.fromFirestore).toList());
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
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map(VehicleAssignmentModel.fromFirestore).toList());
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
    Query query = _db
        .collection('logs')
        .where('companyId', isEqualTo: companyId)
        .where('status', isEqualTo: 'active');

    if (driverId != null) query = query.where('driverId', isEqualTo: driverId);
    if (vehicleId != null) {
      query = query.where('vehicleId', isEqualTo: vehicleId);
    }
    if (logType != null) query = query.where('logType', isEqualTo: logType);
    if (startDate != null) {
      query = query.where(
        'createdAt',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }
    if (endDate != null) {
      query = query.where(
        'createdAt',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    return query
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map(LogModel.fromFirestore).toList());
  }

  Future<List<LogModel>> getDriverLogs(
    String driverId, {
    DateTimeRange? range,
  }) async {
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active');

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

    final snap =
        await query.orderBy('createdAt', descending: true).limit(200).get();
    return snap.docs.map(LogModel.fromFirestore).toList();
  }

  Future<List<LogModel>> getVehicleLogs(
    String vehicleId, {
    int limit = 100,
  }) async {
    final snap = await _db
        .collection('logs')
        .where('vehicleId', isEqualTo: vehicleId)
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return snap.docs.map(LogModel.fromFirestore).toList();
  }

  // ─── Manager: Location ───────────────────────────────────────────────────

  Future<List<LocationPingModel>> getDriverPings(
    String driverId, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
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
    return snap.docs.map(LocationPingModel.fromFirestore).toList();
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
      'logType': 'paymentReceived',
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

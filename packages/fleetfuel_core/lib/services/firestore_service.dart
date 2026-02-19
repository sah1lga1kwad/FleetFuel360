import 'package:cloud_firestore/cloud_firestore.dart';

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
    await _db
        .collection('users')
        .doc(user.userId)
        .set(user.toFirestore());
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

  Stream<VehicleModel?> watchAssignedVehicle(String driverId) {
    return _db
        .collection('vehicles')
        .where('currentDriverId', isEqualTo: driverId)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((query) =>
            query.docs.isEmpty ? null : VehicleModel.fromFirestore(query.docs.first));
  }

  Future<VehicleModel?> getVehicle(String vehicleId) async {
    final doc = await _db.collection('vehicles').doc(vehicleId).get();
    if (!doc.exists) return null;
    return VehicleModel.fromFirestore(doc);
  }

  // ─── Vehicle Assignments ─────────────────────────────────────────────────

  Future<VehicleAssignmentModel?> getActiveAssignment(String driverId) async {
    final query = await _db
        .collection('vehicleAssignments')
        .where('driverId', isEqualTo: driverId)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return VehicleAssignmentModel.fromFirestore(query.docs.first);
  }

  Stream<List<VehicleAssignmentModel>> watchAllAssignments(String driverId) {
    return _db
        .collection('vehicleAssignments')
        .where('driverId', isEqualTo: driverId)
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((query) =>
            query.docs.map(VehicleAssignmentModel.fromFirestore).toList());
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

  Stream<List<LogModel>> watchRecentLogs(String driverId, {int limit = 10}) {
    return _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((query) => query.docs.map(LogModel.fromFirestore).toList());
  }

  Stream<List<LogModel>> watchLogs(
    String driverId, {
    String? logTypeFilter,
    int? limit,
  }) {
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true);

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
    DocumentSnapshot? lastDoc,
    int pageSize = 20,
    String? logTypeFilter,
  }) async {
    Query query = _db
        .collection('logs')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(pageSize);

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

  Stream<List<LogModel>> watchLedgerLogs(String driverId) {
    return watchLogs(driverId);
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
}

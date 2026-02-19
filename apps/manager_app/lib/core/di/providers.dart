import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());
final storageServiceProvider = Provider((ref) => StorageService());

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final currentManagerProvider = StreamProvider<UserModel?>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;
  if (user == null) return Stream.value(null);
  return ref.read(firestoreServiceProvider).watchUser(user.uid);
});

final managerCompanyProvider = StreamProvider<CompanyModel?>((ref) {
  final manager = ref.watch(currentManagerProvider).valueOrNull;
  if (manager?.companyId == null || manager!.companyId!.isEmpty) {
    return Stream.value(null);
  }
  return ref.read(firestoreServiceProvider).watchCompany(manager.companyId!);
});

final companyDriversProvider = StreamProvider<List<UserModel>>((ref) {
  final company = ref.watch(managerCompanyProvider).valueOrNull;
  if (company == null) return Stream.value([]);
  return ref
      .read(firestoreServiceProvider)
      .watchCompanyDrivers(company.companyId);
});

final companyVehiclesProvider = StreamProvider<List<VehicleModel>>((ref) {
  final company = ref.watch(managerCompanyProvider).valueOrNull;
  if (company == null) return Stream.value([]);
  return ref
      .read(firestoreServiceProvider)
      .watchCompanyVehicles(company.companyId);
});

final activeAssignmentsProvider =
    StreamProvider<List<VehicleAssignmentModel>>((ref) {
  final company = ref.watch(managerCompanyProvider).valueOrNull;
  if (company == null) return Stream.value([]);
  return ref
      .read(firestoreServiceProvider)
      .watchActiveAssignments(company.companyId);
});

final assignmentByVehicleProvider =
    Provider<Map<String, VehicleAssignmentModel>>((ref) {
  final assignments = ref.watch(activeAssignmentsProvider).valueOrNull ?? [];
  return {for (final a in assignments) a.vehicleId: a};
});

final assignmentByDriverProvider =
    Provider<Map<String, VehicleAssignmentModel>>((ref) {
  final assignments = ref.watch(activeAssignmentsProvider).valueOrNull ?? [];
  return {for (final a in assignments) a.driverId: a};
});

final driverByIdProvider = Provider<Map<String, UserModel>>((ref) {
  final drivers = ref.watch(companyDriversProvider).valueOrNull ?? [];
  return {for (final d in drivers) d.userId: d};
});

final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((results) {
    if (results.isEmpty) return ConnectivityResult.none;
    return results.first;
  });
});

final companyLogsProvider =
    StreamProvider.autoDispose.family<List<LogModel>, int>((ref, limit) {
  final company = ref.watch(managerCompanyProvider).valueOrNull;
  if (company == null) return Stream.value([]);
  return ref.read(firestoreServiceProvider).watchCompanyLogs(
        company.companyId,
        limit: limit,
      );
});

import 'package:fleetfuel_core/fleetfuel_core.dart';

enum DriverStatus { active, idle, offline }

DriverStatus statusFromDriver(UserModel? driver) {
  final last = driver?.lastKnownLocation;
  if (last == null) return DriverStatus.offline;
  final age = DateTime.now().difference(last.recordedAt);
  if (age.inMinutes < 5) return DriverStatus.active;
  if (age.inMinutes < 30) return DriverStatus.idle;
  return DriverStatus.offline;
}

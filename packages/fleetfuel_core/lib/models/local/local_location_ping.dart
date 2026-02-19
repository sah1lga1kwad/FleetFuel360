import 'package:isar/isar.dart';

import 'local_log.dart';

part 'local_location_ping.g.dart';

@collection
class LocalLocationPing {
  Id isarId = Isar.autoIncrement;

  String? firestoreId;

  @Index(unique: true)
  late String localId;

  late String driverId;
  late String vehicleId;
  late String companyId;
  late String assignmentId;

  late double latitude;
  late double longitude;
  late double accuracy;
  late double altitude;
  late double speed;
  late double bearing;
  late String geohash;

  late String activity;
  late bool isMoving;
  late int batteryLevel;
  late bool isCharging;
  late String networkType;

  @Enumerated(EnumType.name)
  late SyncStatus syncStatus;

  late DateTime recordedAt;
  DateTime? syncedAt;
}

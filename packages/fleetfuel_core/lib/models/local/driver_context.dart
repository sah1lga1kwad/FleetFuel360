import 'package:isar/isar.dart';

part 'driver_context.g.dart';

@collection
class DriverContext {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String driverId;

  late String companyId;
  late String vehicleId;
  late String assignmentId;
  late DateTime updatedAt;
}

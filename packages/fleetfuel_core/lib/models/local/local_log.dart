import 'package:isar/isar.dart';

part 'local_log.g.dart';

enum SyncStatus { pending, uploading, synced, failed }

@collection
class LocalLog {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String localId;

  String? firestoreId;

  late String driverId;
  late String vehicleId;
  late String companyId;
  late String assignmentId;

  late String logType;
  late String category;
  late int amount;
  late String currency;
  late String paidBy;
  late String paymentMode;
  late String description;
  late String notes;

  // Local image file paths (before upload)
  late List<String> localReceiptImagePaths;
  String? localOdometerImagePath;
  String? localFuelMeterImagePath;
  String? localVehicleImagePath;

  // Firebase Storage URLs (set after upload)
  late List<String> receiptImageUrls;
  String? odometerImageUrl;
  String? fuelMeterImageUrl;
  String? vehicleImageUrl;

  late int odometerReading;
  late double fuelQuantityLitres;
  late double fuelPricePerLitre;

  // Location
  late double latitude;
  late double longitude;
  late double accuracy;
  late String address;
  late String geohash;

  // Device context
  late double speed;
  late double bearing;
  late double altitude;
  late int batteryLevel;
  late bool isCharging;
  late String networkType;

  // Sync state
  @Enumerated(EnumType.name)
  late SyncStatus syncStatus;
  late int syncAttempts;
  String? syncError;

  late bool isEdited;

  late DateTime createdAt;
  late DateTime updatedAt;
}

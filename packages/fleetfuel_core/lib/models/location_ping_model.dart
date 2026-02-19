import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_ping_model.freezed.dart';
part 'location_ping_model.g.dart';

enum ActivityType {
  @JsonValue('driving')
  driving,
  @JsonValue('stationary')
  stationary,
  @JsonValue('walking')
  walking,
  @JsonValue('unknown')
  unknown,
}

@freezed
class LocationPingModel with _$LocationPingModel {
  const factory LocationPingModel({
    required String pingId,
    required String driverId,
    required String vehicleId,
    required String companyId,
    required String assignmentId,
    required double latitude,
    required double longitude,
    @Default(0.0) double accuracy,
    @Default(0.0) double altitude,
    @Default(0.0) double speed,
    @Default(0.0) double bearing,
    @Default('') String geohash,
    @Default(ActivityType.unknown) ActivityType activity,
    @Default(false) bool isMoving,
    @Default(0) int batteryLevel,
    @Default(false) bool isCharging,
    @Default('none') String networkType,
    required DateTime recordedAt,
    DateTime? syncedAt,
    required DateTime createdAt,
  }) = _LocationPingModel;

  factory LocationPingModel.fromJson(Map<String, dynamic> json) =>
      _$LocationPingModelFromJson(json);

  factory LocationPingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LocationPingModel.fromJson({
      ...data,
      'pingId': doc.id,
      'recordedAt':
          (data['recordedAt'] as Timestamp).toDate().toIso8601String(),
      'syncedAt': data['syncedAt'] != null
          ? (data['syncedAt'] as Timestamp).toDate().toIso8601String()
          : null,
      'createdAt':
          (data['createdAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}

extension LocationPingModelX on LocationPingModel {
  Map<String, dynamic> toFirestore() {
    return {
      'driverId': driverId,
      'vehicleId': vehicleId,
      'companyId': companyId,
      'assignmentId': assignmentId,
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy,
        'altitude': altitude,
        'speed': speed,
        'bearing': bearing,
        'geohash': geohash,
      },
      'activity': activity.name,
      'isMoving': isMoving,
      'deviceContext': {
        'batteryLevel': batteryLevel,
        'isCharging': isCharging,
        'networkType': networkType,
      },
      'recordedAt': Timestamp.fromDate(recordedAt),
      'syncedAt': syncedAt != null ? Timestamp.fromDate(syncedAt!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

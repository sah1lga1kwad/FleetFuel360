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
    final location = data['location'] is Map<String, dynamic>
        ? data['location'] as Map<String, dynamic>
        : data['location'] is Map
            ? Map<String, dynamic>.from(data['location'] as Map)
            : const <String, dynamic>{};
    final deviceContext = data['deviceContext'] is Map<String, dynamic>
        ? data['deviceContext'] as Map<String, dynamic>
        : data['deviceContext'] is Map
            ? Map<String, dynamic>.from(data['deviceContext'] as Map)
            : const <String, dynamic>{};

    double asDouble(Object? value) {
      if (value is num) return value.toDouble();
      return 0.0;
    }

    int asInt(Object? value) {
      if (value is num) return value.round();
      return 0;
    }

    return LocationPingModel.fromJson({
      ...data,
      'pingId': doc.id,
      'latitude': asDouble(location['latitude'] ?? data['latitude']),
      'longitude': asDouble(location['longitude'] ?? data['longitude']),
      'accuracy': asDouble(location['accuracy'] ?? data['accuracy']),
      'altitude': asDouble(location['altitude'] ?? data['altitude']),
      'speed': asDouble(location['speed'] ?? data['speed']),
      'bearing': asDouble(location['bearing'] ?? data['bearing']),
      'geohash': (location['geohash'] ?? data['geohash'] ?? '').toString(),
      'batteryLevel':
          asInt(deviceContext['batteryLevel'] ?? data['batteryLevel']),
      'isCharging':
          (deviceContext['isCharging'] ?? data['isCharging'] ?? false) == true,
      'networkType':
          (deviceContext['networkType'] ?? data['networkType'] ?? 'none')
              .toString(),
      'recordedAt':
          (data['recordedAt'] as Timestamp).toDate().toIso8601String(),
      'syncedAt': data['syncedAt'] != null
          ? (data['syncedAt'] as Timestamp).toDate().toIso8601String()
          : null,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
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

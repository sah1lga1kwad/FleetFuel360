// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_ping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationPingModelImpl _$$LocationPingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LocationPingModelImpl(
      pingId: json['pingId'] as String,
      driverId: json['driverId'] as String,
      vehicleId: json['vehicleId'] as String,
      companyId: json['companyId'] as String,
      assignmentId: json['assignmentId'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      altitude: (json['altitude'] as num?)?.toDouble() ?? 0.0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      bearing: (json['bearing'] as num?)?.toDouble() ?? 0.0,
      geohash: json['geohash'] as String? ?? '',
      activity: $enumDecodeNullable(_$ActivityTypeEnumMap, json['activity']) ??
          ActivityType.unknown,
      isMoving: json['isMoving'] as bool? ?? false,
      batteryLevel: (json['batteryLevel'] as num?)?.toInt() ?? 0,
      isCharging: json['isCharging'] as bool? ?? false,
      networkType: json['networkType'] as String? ?? 'none',
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LocationPingModelImplToJson(
        _$LocationPingModelImpl instance) =>
    <String, dynamic>{
      'pingId': instance.pingId,
      'driverId': instance.driverId,
      'vehicleId': instance.vehicleId,
      'companyId': instance.companyId,
      'assignmentId': instance.assignmentId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'speed': instance.speed,
      'bearing': instance.bearing,
      'geohash': instance.geohash,
      'activity': _$ActivityTypeEnumMap[instance.activity]!,
      'isMoving': instance.isMoving,
      'batteryLevel': instance.batteryLevel,
      'isCharging': instance.isCharging,
      'networkType': instance.networkType,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ActivityTypeEnumMap = {
  ActivityType.driving: 'driving',
  ActivityType.stationary: 'stationary',
  ActivityType.walking: 'walking',
  ActivityType.unknown: 'unknown',
};

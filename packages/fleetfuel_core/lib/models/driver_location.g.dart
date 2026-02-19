// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverLocationImpl _$$DriverLocationImplFromJson(Map<String, dynamic> json) =>
    _$DriverLocationImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      activity: json['activity'] as String? ?? 'unknown',
      batteryLevel: (json['batteryLevel'] as num?)?.toInt() ?? 0,
      isCharging: json['isCharging'] as bool? ?? false,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$$DriverLocationImplToJson(
        _$DriverLocationImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed': instance.speed,
      'activity': instance.activity,
      'batteryLevel': instance.batteryLevel,
      'isCharging': instance.isCharging,
      'recordedAt': instance.recordedAt.toIso8601String(),
    };

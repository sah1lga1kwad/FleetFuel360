import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_location.freezed.dart';
part 'driver_location.g.dart';

@freezed
class DriverLocation with _$DriverLocation {
  const factory DriverLocation({
    required double latitude,
    required double longitude,
    @Default(0.0) double speed,
    @Default('unknown') String activity,
    @Default(0) int batteryLevel,
    @Default(false) bool isCharging,
    required DateTime recordedAt,
  }) = _DriverLocation;

  factory DriverLocation.fromJson(Map<String, dynamic> json) =>
      _$DriverLocationFromJson(json);

  factory DriverLocation.fromMap(Map<String, dynamic> data) {
    return DriverLocation.fromJson({
      ...data,
      'recordedAt': data['recordedAt'] is Timestamp
          ? (data['recordedAt'] as Timestamp).toDate().toIso8601String()
          : data['recordedAt'],
    });
  }
}

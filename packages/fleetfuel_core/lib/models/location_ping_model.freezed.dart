// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_ping_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationPingModel _$LocationPingModelFromJson(Map<String, dynamic> json) {
  return _LocationPingModel.fromJson(json);
}

/// @nodoc
mixin _$LocationPingModel {
  String get pingId => throw _privateConstructorUsedError;
  String get driverId => throw _privateConstructorUsedError;
  String get vehicleId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get assignmentId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  double get altitude => throw _privateConstructorUsedError;
  double get speed => throw _privateConstructorUsedError;
  double get bearing => throw _privateConstructorUsedError;
  String get geohash => throw _privateConstructorUsedError;
  ActivityType get activity => throw _privateConstructorUsedError;
  bool get isMoving => throw _privateConstructorUsedError;
  int get batteryLevel => throw _privateConstructorUsedError;
  bool get isCharging => throw _privateConstructorUsedError;
  String get networkType => throw _privateConstructorUsedError;
  DateTime get recordedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationPingModelCopyWith<LocationPingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPingModelCopyWith<$Res> {
  factory $LocationPingModelCopyWith(
          LocationPingModel value, $Res Function(LocationPingModel) then) =
      _$LocationPingModelCopyWithImpl<$Res, LocationPingModel>;
  @useResult
  $Res call(
      {String pingId,
      String driverId,
      String vehicleId,
      String companyId,
      String assignmentId,
      double latitude,
      double longitude,
      double accuracy,
      double altitude,
      double speed,
      double bearing,
      String geohash,
      ActivityType activity,
      bool isMoving,
      int batteryLevel,
      bool isCharging,
      String networkType,
      DateTime recordedAt,
      DateTime? syncedAt,
      DateTime createdAt});
}

/// @nodoc
class _$LocationPingModelCopyWithImpl<$Res, $Val extends LocationPingModel>
    implements $LocationPingModelCopyWith<$Res> {
  _$LocationPingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pingId = null,
    Object? driverId = null,
    Object? vehicleId = null,
    Object? companyId = null,
    Object? assignmentId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? altitude = null,
    Object? speed = null,
    Object? bearing = null,
    Object? geohash = null,
    Object? activity = null,
    Object? isMoving = null,
    Object? batteryLevel = null,
    Object? isCharging = null,
    Object? networkType = null,
    Object? recordedAt = null,
    Object? syncedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      pingId: null == pingId
          ? _value.pingId
          : pingId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      bearing: null == bearing
          ? _value.bearing
          : bearing // ignore: cast_nullable_to_non_nullable
              as double,
      geohash: null == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String,
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      isMoving: null == isMoving
          ? _value.isMoving
          : isMoving // ignore: cast_nullable_to_non_nullable
              as bool,
      batteryLevel: null == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as int,
      isCharging: null == isCharging
          ? _value.isCharging
          : isCharging // ignore: cast_nullable_to_non_nullable
              as bool,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationPingModelImplCopyWith<$Res>
    implements $LocationPingModelCopyWith<$Res> {
  factory _$$LocationPingModelImplCopyWith(_$LocationPingModelImpl value,
          $Res Function(_$LocationPingModelImpl) then) =
      __$$LocationPingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String pingId,
      String driverId,
      String vehicleId,
      String companyId,
      String assignmentId,
      double latitude,
      double longitude,
      double accuracy,
      double altitude,
      double speed,
      double bearing,
      String geohash,
      ActivityType activity,
      bool isMoving,
      int batteryLevel,
      bool isCharging,
      String networkType,
      DateTime recordedAt,
      DateTime? syncedAt,
      DateTime createdAt});
}

/// @nodoc
class __$$LocationPingModelImplCopyWithImpl<$Res>
    extends _$LocationPingModelCopyWithImpl<$Res, _$LocationPingModelImpl>
    implements _$$LocationPingModelImplCopyWith<$Res> {
  __$$LocationPingModelImplCopyWithImpl(_$LocationPingModelImpl _value,
      $Res Function(_$LocationPingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pingId = null,
    Object? driverId = null,
    Object? vehicleId = null,
    Object? companyId = null,
    Object? assignmentId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? altitude = null,
    Object? speed = null,
    Object? bearing = null,
    Object? geohash = null,
    Object? activity = null,
    Object? isMoving = null,
    Object? batteryLevel = null,
    Object? isCharging = null,
    Object? networkType = null,
    Object? recordedAt = null,
    Object? syncedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$LocationPingModelImpl(
      pingId: null == pingId
          ? _value.pingId
          : pingId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      bearing: null == bearing
          ? _value.bearing
          : bearing // ignore: cast_nullable_to_non_nullable
              as double,
      geohash: null == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String,
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      isMoving: null == isMoving
          ? _value.isMoving
          : isMoving // ignore: cast_nullable_to_non_nullable
              as bool,
      batteryLevel: null == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as int,
      isCharging: null == isCharging
          ? _value.isCharging
          : isCharging // ignore: cast_nullable_to_non_nullable
              as bool,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationPingModelImpl implements _LocationPingModel {
  const _$LocationPingModelImpl(
      {required this.pingId,
      required this.driverId,
      required this.vehicleId,
      required this.companyId,
      required this.assignmentId,
      required this.latitude,
      required this.longitude,
      this.accuracy = 0.0,
      this.altitude = 0.0,
      this.speed = 0.0,
      this.bearing = 0.0,
      this.geohash = '',
      this.activity = ActivityType.unknown,
      this.isMoving = false,
      this.batteryLevel = 0,
      this.isCharging = false,
      this.networkType = 'none',
      required this.recordedAt,
      this.syncedAt,
      required this.createdAt});

  factory _$LocationPingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationPingModelImplFromJson(json);

  @override
  final String pingId;
  @override
  final String driverId;
  @override
  final String vehicleId;
  @override
  final String companyId;
  @override
  final String assignmentId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final double accuracy;
  @override
  @JsonKey()
  final double altitude;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final double bearing;
  @override
  @JsonKey()
  final String geohash;
  @override
  @JsonKey()
  final ActivityType activity;
  @override
  @JsonKey()
  final bool isMoving;
  @override
  @JsonKey()
  final int batteryLevel;
  @override
  @JsonKey()
  final bool isCharging;
  @override
  @JsonKey()
  final String networkType;
  @override
  final DateTime recordedAt;
  @override
  final DateTime? syncedAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'LocationPingModel(pingId: $pingId, driverId: $driverId, vehicleId: $vehicleId, companyId: $companyId, assignmentId: $assignmentId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, speed: $speed, bearing: $bearing, geohash: $geohash, activity: $activity, isMoving: $isMoving, batteryLevel: $batteryLevel, isCharging: $isCharging, networkType: $networkType, recordedAt: $recordedAt, syncedAt: $syncedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPingModelImpl &&
            (identical(other.pingId, pingId) || other.pingId == pingId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.bearing, bearing) || other.bearing == bearing) &&
            (identical(other.geohash, geohash) || other.geohash == geohash) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.isMoving, isMoving) ||
                other.isMoving == isMoving) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.isCharging, isCharging) ||
                other.isCharging == isCharging) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        pingId,
        driverId,
        vehicleId,
        companyId,
        assignmentId,
        latitude,
        longitude,
        accuracy,
        altitude,
        speed,
        bearing,
        geohash,
        activity,
        isMoving,
        batteryLevel,
        isCharging,
        networkType,
        recordedAt,
        syncedAt,
        createdAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPingModelImplCopyWith<_$LocationPingModelImpl> get copyWith =>
      __$$LocationPingModelImplCopyWithImpl<_$LocationPingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationPingModelImplToJson(
      this,
    );
  }
}

abstract class _LocationPingModel implements LocationPingModel {
  const factory _LocationPingModel(
      {required final String pingId,
      required final String driverId,
      required final String vehicleId,
      required final String companyId,
      required final String assignmentId,
      required final double latitude,
      required final double longitude,
      final double accuracy,
      final double altitude,
      final double speed,
      final double bearing,
      final String geohash,
      final ActivityType activity,
      final bool isMoving,
      final int batteryLevel,
      final bool isCharging,
      final String networkType,
      required final DateTime recordedAt,
      final DateTime? syncedAt,
      required final DateTime createdAt}) = _$LocationPingModelImpl;

  factory _LocationPingModel.fromJson(Map<String, dynamic> json) =
      _$LocationPingModelImpl.fromJson;

  @override
  String get pingId;
  @override
  String get driverId;
  @override
  String get vehicleId;
  @override
  String get companyId;
  @override
  String get assignmentId;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  double get altitude;
  @override
  double get speed;
  @override
  double get bearing;
  @override
  String get geohash;
  @override
  ActivityType get activity;
  @override
  bool get isMoving;
  @override
  int get batteryLevel;
  @override
  bool get isCharging;
  @override
  String get networkType;
  @override
  DateTime get recordedAt;
  @override
  DateTime? get syncedAt;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$LocationPingModelImplCopyWith<_$LocationPingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

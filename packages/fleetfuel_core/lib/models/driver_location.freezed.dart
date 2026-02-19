// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverLocation _$DriverLocationFromJson(Map<String, dynamic> json) {
  return _DriverLocation.fromJson(json);
}

/// @nodoc
mixin _$DriverLocation {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get speed => throw _privateConstructorUsedError;
  String get activity => throw _privateConstructorUsedError;
  int get batteryLevel => throw _privateConstructorUsedError;
  bool get isCharging => throw _privateConstructorUsedError;
  DateTime get recordedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverLocationCopyWith<DriverLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverLocationCopyWith<$Res> {
  factory $DriverLocationCopyWith(
          DriverLocation value, $Res Function(DriverLocation) then) =
      _$DriverLocationCopyWithImpl<$Res, DriverLocation>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double speed,
      String activity,
      int batteryLevel,
      bool isCharging,
      DateTime recordedAt});
}

/// @nodoc
class _$DriverLocationCopyWithImpl<$Res, $Val extends DriverLocation>
    implements $DriverLocationCopyWith<$Res> {
  _$DriverLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? speed = null,
    Object? activity = null,
    Object? batteryLevel = null,
    Object? isCharging = null,
    Object? recordedAt = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as String,
      batteryLevel: null == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as int,
      isCharging: null == isCharging
          ? _value.isCharging
          : isCharging // ignore: cast_nullable_to_non_nullable
              as bool,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverLocationImplCopyWith<$Res>
    implements $DriverLocationCopyWith<$Res> {
  factory _$$DriverLocationImplCopyWith(_$DriverLocationImpl value,
          $Res Function(_$DriverLocationImpl) then) =
      __$$DriverLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double speed,
      String activity,
      int batteryLevel,
      bool isCharging,
      DateTime recordedAt});
}

/// @nodoc
class __$$DriverLocationImplCopyWithImpl<$Res>
    extends _$DriverLocationCopyWithImpl<$Res, _$DriverLocationImpl>
    implements _$$DriverLocationImplCopyWith<$Res> {
  __$$DriverLocationImplCopyWithImpl(
      _$DriverLocationImpl _value, $Res Function(_$DriverLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? speed = null,
    Object? activity = null,
    Object? batteryLevel = null,
    Object? isCharging = null,
    Object? recordedAt = null,
  }) {
    return _then(_$DriverLocationImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as String,
      batteryLevel: null == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as int,
      isCharging: null == isCharging
          ? _value.isCharging
          : isCharging // ignore: cast_nullable_to_non_nullable
              as bool,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverLocationImpl implements _DriverLocation {
  const _$DriverLocationImpl(
      {required this.latitude,
      required this.longitude,
      this.speed = 0.0,
      this.activity = 'unknown',
      this.batteryLevel = 0,
      this.isCharging = false,
      required this.recordedAt});

  factory _$DriverLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverLocationImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final String activity;
  @override
  @JsonKey()
  final int batteryLevel;
  @override
  @JsonKey()
  final bool isCharging;
  @override
  final DateTime recordedAt;

  @override
  String toString() {
    return 'DriverLocation(latitude: $latitude, longitude: $longitude, speed: $speed, activity: $activity, batteryLevel: $batteryLevel, isCharging: $isCharging, recordedAt: $recordedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverLocationImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.isCharging, isCharging) ||
                other.isCharging == isCharging) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude, speed,
      activity, batteryLevel, isCharging, recordedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverLocationImplCopyWith<_$DriverLocationImpl> get copyWith =>
      __$$DriverLocationImplCopyWithImpl<_$DriverLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverLocationImplToJson(
      this,
    );
  }
}

abstract class _DriverLocation implements DriverLocation {
  const factory _DriverLocation(
      {required final double latitude,
      required final double longitude,
      final double speed,
      final String activity,
      final int batteryLevel,
      final bool isCharging,
      required final DateTime recordedAt}) = _$DriverLocationImpl;

  factory _DriverLocation.fromJson(Map<String, dynamic> json) =
      _$DriverLocationImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get speed;
  @override
  String get activity;
  @override
  int get batteryLevel;
  @override
  bool get isCharging;
  @override
  DateTime get recordedAt;
  @override
  @JsonKey(ignore: true)
  _$$DriverLocationImplCopyWith<_$DriverLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

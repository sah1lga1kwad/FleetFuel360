// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return _LocationData.fromJson(json);
}

/// @nodoc
mixin _$LocationData {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get geohash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationDataCopyWith<LocationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDataCopyWith<$Res> {
  factory $LocationDataCopyWith(
          LocationData value, $Res Function(LocationData) then) =
      _$LocationDataCopyWithImpl<$Res, LocationData>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double accuracy,
      String address,
      String geohash});
}

/// @nodoc
class _$LocationDataCopyWithImpl<$Res, $Val extends LocationData>
    implements $LocationDataCopyWith<$Res> {
  _$LocationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? address = null,
    Object? geohash = null,
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
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      geohash: null == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationDataImplCopyWith<$Res>
    implements $LocationDataCopyWith<$Res> {
  factory _$$LocationDataImplCopyWith(
          _$LocationDataImpl value, $Res Function(_$LocationDataImpl) then) =
      __$$LocationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double accuracy,
      String address,
      String geohash});
}

/// @nodoc
class __$$LocationDataImplCopyWithImpl<$Res>
    extends _$LocationDataCopyWithImpl<$Res, _$LocationDataImpl>
    implements _$$LocationDataImplCopyWith<$Res> {
  __$$LocationDataImplCopyWithImpl(
      _$LocationDataImpl _value, $Res Function(_$LocationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? address = null,
    Object? geohash = null,
  }) {
    return _then(_$LocationDataImpl(
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      geohash: null == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDataImpl implements _LocationData {
  const _$LocationDataImpl(
      {this.latitude = 0.0,
      this.longitude = 0.0,
      this.accuracy = 0.0,
      this.address = '',
      this.geohash = ''});

  factory _$LocationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDataImplFromJson(json);

  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  @JsonKey()
  final double accuracy;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String geohash;

  @override
  String toString() {
    return 'LocationData(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, address: $address, geohash: $geohash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDataImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.geohash, geohash) || other.geohash == geohash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, accuracy, address, geohash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      __$$LocationDataImplCopyWithImpl<_$LocationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDataImplToJson(
      this,
    );
  }
}

abstract class _LocationData implements LocationData {
  const factory _LocationData(
      {final double latitude,
      final double longitude,
      final double accuracy,
      final String address,
      final String geohash}) = _$LocationDataImpl;

  factory _LocationData.fromJson(Map<String, dynamic> json) =
      _$LocationDataImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  String get address;
  @override
  String get geohash;
  @override
  @JsonKey(ignore: true)
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceContext _$DeviceContextFromJson(Map<String, dynamic> json) {
  return _DeviceContext.fromJson(json);
}

/// @nodoc
mixin _$DeviceContext {
  double get speed => throw _privateConstructorUsedError;
  double get bearing => throw _privateConstructorUsedError;
  double get altitude => throw _privateConstructorUsedError;
  int get batteryLevel => throw _privateConstructorUsedError;
  bool get isCharging => throw _privateConstructorUsedError;
  String get networkType => throw _privateConstructorUsedError;
  String get signalStrength => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceContextCopyWith<DeviceContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceContextCopyWith<$Res> {
  factory $DeviceContextCopyWith(
          DeviceContext value, $Res Function(DeviceContext) then) =
      _$DeviceContextCopyWithImpl<$Res, DeviceContext>;
  @useResult
  $Res call(
      {double speed,
      double bearing,
      double altitude,
      int batteryLevel,
      bool isCharging,
      String networkType,
      String signalStrength});
}

/// @nodoc
class _$DeviceContextCopyWithImpl<$Res, $Val extends DeviceContext>
    implements $DeviceContextCopyWith<$Res> {
  _$DeviceContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? bearing = null,
    Object? altitude = null,
    Object? batteryLevel = null,
    Object? isCharging = null,
    Object? networkType = null,
    Object? signalStrength = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      bearing: null == bearing
          ? _value.bearing
          : bearing // ignore: cast_nullable_to_non_nullable
              as double,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as double,
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
      signalStrength: null == signalStrength
          ? _value.signalStrength
          : signalStrength // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceContextImplCopyWith<$Res>
    implements $DeviceContextCopyWith<$Res> {
  factory _$$DeviceContextImplCopyWith(
          _$DeviceContextImpl value, $Res Function(_$DeviceContextImpl) then) =
      __$$DeviceContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double speed,
      double bearing,
      double altitude,
      int batteryLevel,
      bool isCharging,
      String networkType,
      String signalStrength});
}

/// @nodoc
class __$$DeviceContextImplCopyWithImpl<$Res>
    extends _$DeviceContextCopyWithImpl<$Res, _$DeviceContextImpl>
    implements _$$DeviceContextImplCopyWith<$Res> {
  __$$DeviceContextImplCopyWithImpl(
      _$DeviceContextImpl _value, $Res Function(_$DeviceContextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? bearing = null,
    Object? altitude = null,
    Object? batteryLevel = null,
    Object? isCharging = null,
    Object? networkType = null,
    Object? signalStrength = null,
  }) {
    return _then(_$DeviceContextImpl(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      bearing: null == bearing
          ? _value.bearing
          : bearing // ignore: cast_nullable_to_non_nullable
              as double,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as double,
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
      signalStrength: null == signalStrength
          ? _value.signalStrength
          : signalStrength // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceContextImpl implements _DeviceContext {
  const _$DeviceContextImpl(
      {this.speed = 0.0,
      this.bearing = 0.0,
      this.altitude = 0.0,
      this.batteryLevel = 0,
      this.isCharging = false,
      this.networkType = 'none',
      this.signalStrength = ''});

  factory _$DeviceContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceContextImplFromJson(json);

  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final double bearing;
  @override
  @JsonKey()
  final double altitude;
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
  @JsonKey()
  final String signalStrength;

  @override
  String toString() {
    return 'DeviceContext(speed: $speed, bearing: $bearing, altitude: $altitude, batteryLevel: $batteryLevel, isCharging: $isCharging, networkType: $networkType, signalStrength: $signalStrength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceContextImpl &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.bearing, bearing) || other.bearing == bearing) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.isCharging, isCharging) ||
                other.isCharging == isCharging) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.signalStrength, signalStrength) ||
                other.signalStrength == signalStrength));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, speed, bearing, altitude,
      batteryLevel, isCharging, networkType, signalStrength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceContextImplCopyWith<_$DeviceContextImpl> get copyWith =>
      __$$DeviceContextImplCopyWithImpl<_$DeviceContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceContextImplToJson(
      this,
    );
  }
}

abstract class _DeviceContext implements DeviceContext {
  const factory _DeviceContext(
      {final double speed,
      final double bearing,
      final double altitude,
      final int batteryLevel,
      final bool isCharging,
      final String networkType,
      final String signalStrength}) = _$DeviceContextImpl;

  factory _DeviceContext.fromJson(Map<String, dynamic> json) =
      _$DeviceContextImpl.fromJson;

  @override
  double get speed;
  @override
  double get bearing;
  @override
  double get altitude;
  @override
  int get batteryLevel;
  @override
  bool get isCharging;
  @override
  String get networkType;
  @override
  String get signalStrength;
  @override
  @JsonKey(ignore: true)
  _$$DeviceContextImplCopyWith<_$DeviceContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EditHistoryEntry _$EditHistoryEntryFromJson(Map<String, dynamic> json) {
  return _EditHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$EditHistoryEntry {
  DateTime get editedAt => throw _privateConstructorUsedError;
  String get editedByDriverId => throw _privateConstructorUsedError;
  Map<String, dynamic> get previousValues => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EditHistoryEntryCopyWith<EditHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditHistoryEntryCopyWith<$Res> {
  factory $EditHistoryEntryCopyWith(
          EditHistoryEntry value, $Res Function(EditHistoryEntry) then) =
      _$EditHistoryEntryCopyWithImpl<$Res, EditHistoryEntry>;
  @useResult
  $Res call(
      {DateTime editedAt,
      String editedByDriverId,
      Map<String, dynamic> previousValues,
      String reason});
}

/// @nodoc
class _$EditHistoryEntryCopyWithImpl<$Res, $Val extends EditHistoryEntry>
    implements $EditHistoryEntryCopyWith<$Res> {
  _$EditHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editedAt = null,
    Object? editedByDriverId = null,
    Object? previousValues = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      editedAt: null == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      editedByDriverId: null == editedByDriverId
          ? _value.editedByDriverId
          : editedByDriverId // ignore: cast_nullable_to_non_nullable
              as String,
      previousValues: null == previousValues
          ? _value.previousValues
          : previousValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditHistoryEntryImplCopyWith<$Res>
    implements $EditHistoryEntryCopyWith<$Res> {
  factory _$$EditHistoryEntryImplCopyWith(_$EditHistoryEntryImpl value,
          $Res Function(_$EditHistoryEntryImpl) then) =
      __$$EditHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime editedAt,
      String editedByDriverId,
      Map<String, dynamic> previousValues,
      String reason});
}

/// @nodoc
class __$$EditHistoryEntryImplCopyWithImpl<$Res>
    extends _$EditHistoryEntryCopyWithImpl<$Res, _$EditHistoryEntryImpl>
    implements _$$EditHistoryEntryImplCopyWith<$Res> {
  __$$EditHistoryEntryImplCopyWithImpl(_$EditHistoryEntryImpl _value,
      $Res Function(_$EditHistoryEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editedAt = null,
    Object? editedByDriverId = null,
    Object? previousValues = null,
    Object? reason = null,
  }) {
    return _then(_$EditHistoryEntryImpl(
      editedAt: null == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      editedByDriverId: null == editedByDriverId
          ? _value.editedByDriverId
          : editedByDriverId // ignore: cast_nullable_to_non_nullable
              as String,
      previousValues: null == previousValues
          ? _value._previousValues
          : previousValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditHistoryEntryImpl implements _EditHistoryEntry {
  const _$EditHistoryEntryImpl(
      {required this.editedAt,
      required this.editedByDriverId,
      final Map<String, dynamic> previousValues = const {},
      this.reason = ''})
      : _previousValues = previousValues;

  factory _$EditHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditHistoryEntryImplFromJson(json);

  @override
  final DateTime editedAt;
  @override
  final String editedByDriverId;
  final Map<String, dynamic> _previousValues;
  @override
  @JsonKey()
  Map<String, dynamic> get previousValues {
    if (_previousValues is EqualUnmodifiableMapView) return _previousValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_previousValues);
  }

  @override
  @JsonKey()
  final String reason;

  @override
  String toString() {
    return 'EditHistoryEntry(editedAt: $editedAt, editedByDriverId: $editedByDriverId, previousValues: $previousValues, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditHistoryEntryImpl &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.editedByDriverId, editedByDriverId) ||
                other.editedByDriverId == editedByDriverId) &&
            const DeepCollectionEquality()
                .equals(other._previousValues, _previousValues) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, editedAt, editedByDriverId,
      const DeepCollectionEquality().hash(_previousValues), reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditHistoryEntryImplCopyWith<_$EditHistoryEntryImpl> get copyWith =>
      __$$EditHistoryEntryImplCopyWithImpl<_$EditHistoryEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _EditHistoryEntry implements EditHistoryEntry {
  const factory _EditHistoryEntry(
      {required final DateTime editedAt,
      required final String editedByDriverId,
      final Map<String, dynamic> previousValues,
      final String reason}) = _$EditHistoryEntryImpl;

  factory _EditHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$EditHistoryEntryImpl.fromJson;

  @override
  DateTime get editedAt;
  @override
  String get editedByDriverId;
  @override
  Map<String, dynamic> get previousValues;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$EditHistoryEntryImplCopyWith<_$EditHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LogModel _$LogModelFromJson(Map<String, dynamic> json) {
  return _LogModel.fromJson(json);
}

/// @nodoc
mixin _$LogModel {
  String get logId => throw _privateConstructorUsedError;
  String get driverId => throw _privateConstructorUsedError;
  String get vehicleId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get assignmentId =>
      throw _privateConstructorUsedError; // Classification
  LogType get logType => throw _privateConstructorUsedError;
  LogCategory get category =>
      throw _privateConstructorUsedError; // Money — stored in paise/cents
  int get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  PaidBy get paidBy => throw _privateConstructorUsedError;
  PaymentMode get paymentMode =>
      throw _privateConstructorUsedError; // Description
  String get description => throw _privateConstructorUsedError;
  String get notes =>
      throw _privateConstructorUsedError; // Image URLs (Firebase Storage)
  List<String> get receiptImageUrls => throw _privateConstructorUsedError;
  String? get odometerImageUrl => throw _privateConstructorUsedError;
  String? get fuelMeterImageUrl => throw _privateConstructorUsedError;
  String? get vehicleImageUrl => throw _privateConstructorUsedError; // Readings
  int get odometerReading => throw _privateConstructorUsedError;
  double get fuelQuantityLitres => throw _privateConstructorUsedError;
  double get fuelPricePerLitre =>
      throw _privateConstructorUsedError; // Location
  LocationData get location =>
      throw _privateConstructorUsedError; // Device context
  DeviceContext get deviceContext =>
      throw _privateConstructorUsedError; // V2 extraction fields (null in Phase 1)
  int? get odometerReadingExtracted => throw _privateConstructorUsedError;
  double? get fuelLevelExtracted => throw _privateConstructorUsedError;
  int? get receiptAmountExtracted => throw _privateConstructorUsedError;
  double? get extractionConfidence =>
      throw _privateConstructorUsedError; // Edit history
  bool get isEdited => throw _privateConstructorUsedError;
  List<EditHistoryEntry> get editHistory =>
      throw _privateConstructorUsedError; // Status
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogModelCopyWith<LogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogModelCopyWith<$Res> {
  factory $LogModelCopyWith(LogModel value, $Res Function(LogModel) then) =
      _$LogModelCopyWithImpl<$Res, LogModel>;
  @useResult
  $Res call(
      {String logId,
      String driverId,
      String vehicleId,
      String companyId,
      String assignmentId,
      LogType logType,
      LogCategory category,
      int amount,
      String currency,
      PaidBy paidBy,
      PaymentMode paymentMode,
      String description,
      String notes,
      List<String> receiptImageUrls,
      String? odometerImageUrl,
      String? fuelMeterImageUrl,
      String? vehicleImageUrl,
      int odometerReading,
      double fuelQuantityLitres,
      double fuelPricePerLitre,
      LocationData location,
      DeviceContext deviceContext,
      int? odometerReadingExtracted,
      double? fuelLevelExtracted,
      int? receiptAmountExtracted,
      double? extractionConfidence,
      bool isEdited,
      List<EditHistoryEntry> editHistory,
      String status,
      DateTime createdAt,
      DateTime updatedAt});

  $LocationDataCopyWith<$Res> get location;
  $DeviceContextCopyWith<$Res> get deviceContext;
}

/// @nodoc
class _$LogModelCopyWithImpl<$Res, $Val extends LogModel>
    implements $LogModelCopyWith<$Res> {
  _$LogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = null,
    Object? driverId = null,
    Object? vehicleId = null,
    Object? companyId = null,
    Object? assignmentId = null,
    Object? logType = null,
    Object? category = null,
    Object? amount = null,
    Object? currency = null,
    Object? paidBy = null,
    Object? paymentMode = null,
    Object? description = null,
    Object? notes = null,
    Object? receiptImageUrls = null,
    Object? odometerImageUrl = freezed,
    Object? fuelMeterImageUrl = freezed,
    Object? vehicleImageUrl = freezed,
    Object? odometerReading = null,
    Object? fuelQuantityLitres = null,
    Object? fuelPricePerLitre = null,
    Object? location = null,
    Object? deviceContext = null,
    Object? odometerReadingExtracted = freezed,
    Object? fuelLevelExtracted = freezed,
    Object? receiptAmountExtracted = freezed,
    Object? extractionConfidence = freezed,
    Object? isEdited = null,
    Object? editHistory = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      logId: null == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
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
      logType: null == logType
          ? _value.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as LogType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as LogCategory,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paidBy: null == paidBy
          ? _value.paidBy
          : paidBy // ignore: cast_nullable_to_non_nullable
              as PaidBy,
      paymentMode: null == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      receiptImageUrls: null == receiptImageUrls
          ? _value.receiptImageUrls
          : receiptImageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      odometerImageUrl: freezed == odometerImageUrl
          ? _value.odometerImageUrl
          : odometerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fuelMeterImageUrl: freezed == fuelMeterImageUrl
          ? _value.fuelMeterImageUrl
          : fuelMeterImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleImageUrl: freezed == vehicleImageUrl
          ? _value.vehicleImageUrl
          : vehicleImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      odometerReading: null == odometerReading
          ? _value.odometerReading
          : odometerReading // ignore: cast_nullable_to_non_nullable
              as int,
      fuelQuantityLitres: null == fuelQuantityLitres
          ? _value.fuelQuantityLitres
          : fuelQuantityLitres // ignore: cast_nullable_to_non_nullable
              as double,
      fuelPricePerLitre: null == fuelPricePerLitre
          ? _value.fuelPricePerLitre
          : fuelPricePerLitre // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationData,
      deviceContext: null == deviceContext
          ? _value.deviceContext
          : deviceContext // ignore: cast_nullable_to_non_nullable
              as DeviceContext,
      odometerReadingExtracted: freezed == odometerReadingExtracted
          ? _value.odometerReadingExtracted
          : odometerReadingExtracted // ignore: cast_nullable_to_non_nullable
              as int?,
      fuelLevelExtracted: freezed == fuelLevelExtracted
          ? _value.fuelLevelExtracted
          : fuelLevelExtracted // ignore: cast_nullable_to_non_nullable
              as double?,
      receiptAmountExtracted: freezed == receiptAmountExtracted
          ? _value.receiptAmountExtracted
          : receiptAmountExtracted // ignore: cast_nullable_to_non_nullable
              as int?,
      extractionConfidence: freezed == extractionConfidence
          ? _value.extractionConfidence
          : extractionConfidence // ignore: cast_nullable_to_non_nullable
              as double?,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      editHistory: null == editHistory
          ? _value.editHistory
          : editHistory // ignore: cast_nullable_to_non_nullable
              as List<EditHistoryEntry>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res> get location {
    return $LocationDataCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeviceContextCopyWith<$Res> get deviceContext {
    return $DeviceContextCopyWith<$Res>(_value.deviceContext, (value) {
      return _then(_value.copyWith(deviceContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LogModelImplCopyWith<$Res>
    implements $LogModelCopyWith<$Res> {
  factory _$$LogModelImplCopyWith(
          _$LogModelImpl value, $Res Function(_$LogModelImpl) then) =
      __$$LogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String logId,
      String driverId,
      String vehicleId,
      String companyId,
      String assignmentId,
      LogType logType,
      LogCategory category,
      int amount,
      String currency,
      PaidBy paidBy,
      PaymentMode paymentMode,
      String description,
      String notes,
      List<String> receiptImageUrls,
      String? odometerImageUrl,
      String? fuelMeterImageUrl,
      String? vehicleImageUrl,
      int odometerReading,
      double fuelQuantityLitres,
      double fuelPricePerLitre,
      LocationData location,
      DeviceContext deviceContext,
      int? odometerReadingExtracted,
      double? fuelLevelExtracted,
      int? receiptAmountExtracted,
      double? extractionConfidence,
      bool isEdited,
      List<EditHistoryEntry> editHistory,
      String status,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $LocationDataCopyWith<$Res> get location;
  @override
  $DeviceContextCopyWith<$Res> get deviceContext;
}

/// @nodoc
class __$$LogModelImplCopyWithImpl<$Res>
    extends _$LogModelCopyWithImpl<$Res, _$LogModelImpl>
    implements _$$LogModelImplCopyWith<$Res> {
  __$$LogModelImplCopyWithImpl(
      _$LogModelImpl _value, $Res Function(_$LogModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = null,
    Object? driverId = null,
    Object? vehicleId = null,
    Object? companyId = null,
    Object? assignmentId = null,
    Object? logType = null,
    Object? category = null,
    Object? amount = null,
    Object? currency = null,
    Object? paidBy = null,
    Object? paymentMode = null,
    Object? description = null,
    Object? notes = null,
    Object? receiptImageUrls = null,
    Object? odometerImageUrl = freezed,
    Object? fuelMeterImageUrl = freezed,
    Object? vehicleImageUrl = freezed,
    Object? odometerReading = null,
    Object? fuelQuantityLitres = null,
    Object? fuelPricePerLitre = null,
    Object? location = null,
    Object? deviceContext = null,
    Object? odometerReadingExtracted = freezed,
    Object? fuelLevelExtracted = freezed,
    Object? receiptAmountExtracted = freezed,
    Object? extractionConfidence = freezed,
    Object? isEdited = null,
    Object? editHistory = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$LogModelImpl(
      logId: null == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
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
      logType: null == logType
          ? _value.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as LogType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as LogCategory,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paidBy: null == paidBy
          ? _value.paidBy
          : paidBy // ignore: cast_nullable_to_non_nullable
              as PaidBy,
      paymentMode: null == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      receiptImageUrls: null == receiptImageUrls
          ? _value._receiptImageUrls
          : receiptImageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      odometerImageUrl: freezed == odometerImageUrl
          ? _value.odometerImageUrl
          : odometerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fuelMeterImageUrl: freezed == fuelMeterImageUrl
          ? _value.fuelMeterImageUrl
          : fuelMeterImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleImageUrl: freezed == vehicleImageUrl
          ? _value.vehicleImageUrl
          : vehicleImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      odometerReading: null == odometerReading
          ? _value.odometerReading
          : odometerReading // ignore: cast_nullable_to_non_nullable
              as int,
      fuelQuantityLitres: null == fuelQuantityLitres
          ? _value.fuelQuantityLitres
          : fuelQuantityLitres // ignore: cast_nullable_to_non_nullable
              as double,
      fuelPricePerLitre: null == fuelPricePerLitre
          ? _value.fuelPricePerLitre
          : fuelPricePerLitre // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationData,
      deviceContext: null == deviceContext
          ? _value.deviceContext
          : deviceContext // ignore: cast_nullable_to_non_nullable
              as DeviceContext,
      odometerReadingExtracted: freezed == odometerReadingExtracted
          ? _value.odometerReadingExtracted
          : odometerReadingExtracted // ignore: cast_nullable_to_non_nullable
              as int?,
      fuelLevelExtracted: freezed == fuelLevelExtracted
          ? _value.fuelLevelExtracted
          : fuelLevelExtracted // ignore: cast_nullable_to_non_nullable
              as double?,
      receiptAmountExtracted: freezed == receiptAmountExtracted
          ? _value.receiptAmountExtracted
          : receiptAmountExtracted // ignore: cast_nullable_to_non_nullable
              as int?,
      extractionConfidence: freezed == extractionConfidence
          ? _value.extractionConfidence
          : extractionConfidence // ignore: cast_nullable_to_non_nullable
              as double?,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      editHistory: null == editHistory
          ? _value._editHistory
          : editHistory // ignore: cast_nullable_to_non_nullable
              as List<EditHistoryEntry>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogModelImpl implements _LogModel {
  const _$LogModelImpl(
      {required this.logId,
      required this.driverId,
      required this.vehicleId,
      required this.companyId,
      required this.assignmentId,
      required this.logType,
      this.category = LogCategory.other,
      this.amount = 0,
      this.currency = 'INR',
      this.paidBy = PaidBy.driver,
      this.paymentMode = PaymentMode.cash,
      this.description = '',
      this.notes = '',
      final List<String> receiptImageUrls = const [],
      this.odometerImageUrl,
      this.fuelMeterImageUrl,
      this.vehicleImageUrl,
      this.odometerReading = 0,
      this.fuelQuantityLitres = 0.0,
      this.fuelPricePerLitre = 0.0,
      this.location = const LocationData(),
      this.deviceContext = const DeviceContext(),
      this.odometerReadingExtracted,
      this.fuelLevelExtracted,
      this.receiptAmountExtracted,
      this.extractionConfidence,
      this.isEdited = false,
      final List<EditHistoryEntry> editHistory = const [],
      this.status = 'active',
      required this.createdAt,
      required this.updatedAt})
      : _receiptImageUrls = receiptImageUrls,
        _editHistory = editHistory;

  factory _$LogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogModelImplFromJson(json);

  @override
  final String logId;
  @override
  final String driverId;
  @override
  final String vehicleId;
  @override
  final String companyId;
  @override
  final String assignmentId;
// Classification
  @override
  final LogType logType;
  @override
  @JsonKey()
  final LogCategory category;
// Money — stored in paise/cents
  @override
  @JsonKey()
  final int amount;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final PaidBy paidBy;
  @override
  @JsonKey()
  final PaymentMode paymentMode;
// Description
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String notes;
// Image URLs (Firebase Storage)
  final List<String> _receiptImageUrls;
// Image URLs (Firebase Storage)
  @override
  @JsonKey()
  List<String> get receiptImageUrls {
    if (_receiptImageUrls is EqualUnmodifiableListView)
      return _receiptImageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receiptImageUrls);
  }

  @override
  final String? odometerImageUrl;
  @override
  final String? fuelMeterImageUrl;
  @override
  final String? vehicleImageUrl;
// Readings
  @override
  @JsonKey()
  final int odometerReading;
  @override
  @JsonKey()
  final double fuelQuantityLitres;
  @override
  @JsonKey()
  final double fuelPricePerLitre;
// Location
  @override
  @JsonKey()
  final LocationData location;
// Device context
  @override
  @JsonKey()
  final DeviceContext deviceContext;
// V2 extraction fields (null in Phase 1)
  @override
  final int? odometerReadingExtracted;
  @override
  final double? fuelLevelExtracted;
  @override
  final int? receiptAmountExtracted;
  @override
  final double? extractionConfidence;
// Edit history
  @override
  @JsonKey()
  final bool isEdited;
  final List<EditHistoryEntry> _editHistory;
  @override
  @JsonKey()
  List<EditHistoryEntry> get editHistory {
    if (_editHistory is EqualUnmodifiableListView) return _editHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editHistory);
  }

// Status
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'LogModel(logId: $logId, driverId: $driverId, vehicleId: $vehicleId, companyId: $companyId, assignmentId: $assignmentId, logType: $logType, category: $category, amount: $amount, currency: $currency, paidBy: $paidBy, paymentMode: $paymentMode, description: $description, notes: $notes, receiptImageUrls: $receiptImageUrls, odometerImageUrl: $odometerImageUrl, fuelMeterImageUrl: $fuelMeterImageUrl, vehicleImageUrl: $vehicleImageUrl, odometerReading: $odometerReading, fuelQuantityLitres: $fuelQuantityLitres, fuelPricePerLitre: $fuelPricePerLitre, location: $location, deviceContext: $deviceContext, odometerReadingExtracted: $odometerReadingExtracted, fuelLevelExtracted: $fuelLevelExtracted, receiptAmountExtracted: $receiptAmountExtracted, extractionConfidence: $extractionConfidence, isEdited: $isEdited, editHistory: $editHistory, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogModelImpl &&
            (identical(other.logId, logId) || other.logId == logId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.logType, logType) || other.logType == logType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.paidBy, paidBy) || other.paidBy == paidBy) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._receiptImageUrls, _receiptImageUrls) &&
            (identical(other.odometerImageUrl, odometerImageUrl) ||
                other.odometerImageUrl == odometerImageUrl) &&
            (identical(other.fuelMeterImageUrl, fuelMeterImageUrl) ||
                other.fuelMeterImageUrl == fuelMeterImageUrl) &&
            (identical(other.vehicleImageUrl, vehicleImageUrl) ||
                other.vehicleImageUrl == vehicleImageUrl) &&
            (identical(other.odometerReading, odometerReading) ||
                other.odometerReading == odometerReading) &&
            (identical(other.fuelQuantityLitres, fuelQuantityLitres) ||
                other.fuelQuantityLitres == fuelQuantityLitres) &&
            (identical(other.fuelPricePerLitre, fuelPricePerLitre) ||
                other.fuelPricePerLitre == fuelPricePerLitre) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.deviceContext, deviceContext) ||
                other.deviceContext == deviceContext) &&
            (identical(
                    other.odometerReadingExtracted, odometerReadingExtracted) ||
                other.odometerReadingExtracted == odometerReadingExtracted) &&
            (identical(other.fuelLevelExtracted, fuelLevelExtracted) ||
                other.fuelLevelExtracted == fuelLevelExtracted) &&
            (identical(other.receiptAmountExtracted, receiptAmountExtracted) ||
                other.receiptAmountExtracted == receiptAmountExtracted) &&
            (identical(other.extractionConfidence, extractionConfidence) ||
                other.extractionConfidence == extractionConfidence) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            const DeepCollectionEquality()
                .equals(other._editHistory, _editHistory) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        logId,
        driverId,
        vehicleId,
        companyId,
        assignmentId,
        logType,
        category,
        amount,
        currency,
        paidBy,
        paymentMode,
        description,
        notes,
        const DeepCollectionEquality().hash(_receiptImageUrls),
        odometerImageUrl,
        fuelMeterImageUrl,
        vehicleImageUrl,
        odometerReading,
        fuelQuantityLitres,
        fuelPricePerLitre,
        location,
        deviceContext,
        odometerReadingExtracted,
        fuelLevelExtracted,
        receiptAmountExtracted,
        extractionConfidence,
        isEdited,
        const DeepCollectionEquality().hash(_editHistory),
        status,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogModelImplCopyWith<_$LogModelImpl> get copyWith =>
      __$$LogModelImplCopyWithImpl<_$LogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogModelImplToJson(
      this,
    );
  }
}

abstract class _LogModel implements LogModel {
  const factory _LogModel(
      {required final String logId,
      required final String driverId,
      required final String vehicleId,
      required final String companyId,
      required final String assignmentId,
      required final LogType logType,
      final LogCategory category,
      final int amount,
      final String currency,
      final PaidBy paidBy,
      final PaymentMode paymentMode,
      final String description,
      final String notes,
      final List<String> receiptImageUrls,
      final String? odometerImageUrl,
      final String? fuelMeterImageUrl,
      final String? vehicleImageUrl,
      final int odometerReading,
      final double fuelQuantityLitres,
      final double fuelPricePerLitre,
      final LocationData location,
      final DeviceContext deviceContext,
      final int? odometerReadingExtracted,
      final double? fuelLevelExtracted,
      final int? receiptAmountExtracted,
      final double? extractionConfidence,
      final bool isEdited,
      final List<EditHistoryEntry> editHistory,
      final String status,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$LogModelImpl;

  factory _LogModel.fromJson(Map<String, dynamic> json) =
      _$LogModelImpl.fromJson;

  @override
  String get logId;
  @override
  String get driverId;
  @override
  String get vehicleId;
  @override
  String get companyId;
  @override
  String get assignmentId;
  @override // Classification
  LogType get logType;
  @override
  LogCategory get category;
  @override // Money — stored in paise/cents
  int get amount;
  @override
  String get currency;
  @override
  PaidBy get paidBy;
  @override
  PaymentMode get paymentMode;
  @override // Description
  String get description;
  @override
  String get notes;
  @override // Image URLs (Firebase Storage)
  List<String> get receiptImageUrls;
  @override
  String? get odometerImageUrl;
  @override
  String? get fuelMeterImageUrl;
  @override
  String? get vehicleImageUrl;
  @override // Readings
  int get odometerReading;
  @override
  double get fuelQuantityLitres;
  @override
  double get fuelPricePerLitre;
  @override // Location
  LocationData get location;
  @override // Device context
  DeviceContext get deviceContext;
  @override // V2 extraction fields (null in Phase 1)
  int? get odometerReadingExtracted;
  @override
  double? get fuelLevelExtracted;
  @override
  int? get receiptAmountExtracted;
  @override
  double? get extractionConfidence;
  @override // Edit history
  bool get isEdited;
  @override
  List<EditHistoryEntry> get editHistory;
  @override // Status
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$LogModelImplCopyWith<_$LogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) {
  return _VehicleModel.fromJson(json);
}

/// @nodoc
mixin _$VehicleModel {
  String get vehicleId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get registrationNumber => throw _privateConstructorUsedError;
  String get make => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  FuelType get fuelType => throw _privateConstructorUsedError;
  VehicleType get vehicleType => throw _privateConstructorUsedError;
  String get vehicleImageUrl => throw _privateConstructorUsedError;
  String? get currentDriverId => throw _privateConstructorUsedError;
  String? get currentAssignmentId => throw _privateConstructorUsedError;
  double get tankCapacityLitres => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VehicleModelCopyWith<VehicleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleModelCopyWith<$Res> {
  factory $VehicleModelCopyWith(
          VehicleModel value, $Res Function(VehicleModel) then) =
      _$VehicleModelCopyWithImpl<$Res, VehicleModel>;
  @useResult
  $Res call(
      {String vehicleId,
      String companyId,
      String registrationNumber,
      String make,
      String model,
      int year,
      FuelType fuelType,
      VehicleType vehicleType,
      String vehicleImageUrl,
      String? currentDriverId,
      String? currentAssignmentId,
      double tankCapacityLitres,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$VehicleModelCopyWithImpl<$Res, $Val extends VehicleModel>
    implements $VehicleModelCopyWith<$Res> {
  _$VehicleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? companyId = null,
    Object? registrationNumber = null,
    Object? make = null,
    Object? model = null,
    Object? year = null,
    Object? fuelType = null,
    Object? vehicleType = null,
    Object? vehicleImageUrl = null,
    Object? currentDriverId = freezed,
    Object? currentAssignmentId = freezed,
    Object? tankCapacityLitres = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      registrationNumber: null == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      make: null == make
          ? _value.make
          : make // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      fuelType: null == fuelType
          ? _value.fuelType
          : fuelType // ignore: cast_nullable_to_non_nullable
              as FuelType,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as VehicleType,
      vehicleImageUrl: null == vehicleImageUrl
          ? _value.vehicleImageUrl
          : vehicleImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      currentDriverId: freezed == currentDriverId
          ? _value.currentDriverId
          : currentDriverId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentAssignmentId: freezed == currentAssignmentId
          ? _value.currentAssignmentId
          : currentAssignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tankCapacityLitres: null == tankCapacityLitres
          ? _value.tankCapacityLitres
          : tankCapacityLitres // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

/// @nodoc
abstract class _$$VehicleModelImplCopyWith<$Res>
    implements $VehicleModelCopyWith<$Res> {
  factory _$$VehicleModelImplCopyWith(
          _$VehicleModelImpl value, $Res Function(_$VehicleModelImpl) then) =
      __$$VehicleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String vehicleId,
      String companyId,
      String registrationNumber,
      String make,
      String model,
      int year,
      FuelType fuelType,
      VehicleType vehicleType,
      String vehicleImageUrl,
      String? currentDriverId,
      String? currentAssignmentId,
      double tankCapacityLitres,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$VehicleModelImplCopyWithImpl<$Res>
    extends _$VehicleModelCopyWithImpl<$Res, _$VehicleModelImpl>
    implements _$$VehicleModelImplCopyWith<$Res> {
  __$$VehicleModelImplCopyWithImpl(
      _$VehicleModelImpl _value, $Res Function(_$VehicleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? companyId = null,
    Object? registrationNumber = null,
    Object? make = null,
    Object? model = null,
    Object? year = null,
    Object? fuelType = null,
    Object? vehicleType = null,
    Object? vehicleImageUrl = null,
    Object? currentDriverId = freezed,
    Object? currentAssignmentId = freezed,
    Object? tankCapacityLitres = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$VehicleModelImpl(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      registrationNumber: null == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      make: null == make
          ? _value.make
          : make // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      fuelType: null == fuelType
          ? _value.fuelType
          : fuelType // ignore: cast_nullable_to_non_nullable
              as FuelType,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as VehicleType,
      vehicleImageUrl: null == vehicleImageUrl
          ? _value.vehicleImageUrl
          : vehicleImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      currentDriverId: freezed == currentDriverId
          ? _value.currentDriverId
          : currentDriverId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentAssignmentId: freezed == currentAssignmentId
          ? _value.currentAssignmentId
          : currentAssignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tankCapacityLitres: null == tankCapacityLitres
          ? _value.tankCapacityLitres
          : tankCapacityLitres // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$VehicleModelImpl implements _VehicleModel {
  const _$VehicleModelImpl(
      {required this.vehicleId,
      required this.companyId,
      required this.registrationNumber,
      required this.make,
      required this.model,
      required this.year,
      required this.fuelType,
      required this.vehicleType,
      this.vehicleImageUrl = '',
      this.currentDriverId,
      this.currentAssignmentId,
      this.tankCapacityLitres = 0,
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt});

  factory _$VehicleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleModelImplFromJson(json);

  @override
  final String vehicleId;
  @override
  final String companyId;
  @override
  final String registrationNumber;
  @override
  final String make;
  @override
  final String model;
  @override
  final int year;
  @override
  final FuelType fuelType;
  @override
  final VehicleType vehicleType;
  @override
  @JsonKey()
  final String vehicleImageUrl;
  @override
  final String? currentDriverId;
  @override
  final String? currentAssignmentId;
  @override
  @JsonKey()
  final double tankCapacityLitres;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'VehicleModel(vehicleId: $vehicleId, companyId: $companyId, registrationNumber: $registrationNumber, make: $make, model: $model, year: $year, fuelType: $fuelType, vehicleType: $vehicleType, vehicleImageUrl: $vehicleImageUrl, currentDriverId: $currentDriverId, currentAssignmentId: $currentAssignmentId, tankCapacityLitres: $tankCapacityLitres, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleModelImpl &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.make, make) || other.make == make) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.fuelType, fuelType) ||
                other.fuelType == fuelType) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.vehicleImageUrl, vehicleImageUrl) ||
                other.vehicleImageUrl == vehicleImageUrl) &&
            (identical(other.currentDriverId, currentDriverId) ||
                other.currentDriverId == currentDriverId) &&
            (identical(other.currentAssignmentId, currentAssignmentId) ||
                other.currentAssignmentId == currentAssignmentId) &&
            (identical(other.tankCapacityLitres, tankCapacityLitres) ||
                other.tankCapacityLitres == tankCapacityLitres) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      vehicleId,
      companyId,
      registrationNumber,
      make,
      model,
      year,
      fuelType,
      vehicleType,
      vehicleImageUrl,
      currentDriverId,
      currentAssignmentId,
      tankCapacityLitres,
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleModelImplCopyWith<_$VehicleModelImpl> get copyWith =>
      __$$VehicleModelImplCopyWithImpl<_$VehicleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleModelImplToJson(
      this,
    );
  }
}

abstract class _VehicleModel implements VehicleModel {
  const factory _VehicleModel(
      {required final String vehicleId,
      required final String companyId,
      required final String registrationNumber,
      required final String make,
      required final String model,
      required final int year,
      required final FuelType fuelType,
      required final VehicleType vehicleType,
      final String vehicleImageUrl,
      final String? currentDriverId,
      final String? currentAssignmentId,
      final double tankCapacityLitres,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$VehicleModelImpl;

  factory _VehicleModel.fromJson(Map<String, dynamic> json) =
      _$VehicleModelImpl.fromJson;

  @override
  String get vehicleId;
  @override
  String get companyId;
  @override
  String get registrationNumber;
  @override
  String get make;
  @override
  String get model;
  @override
  int get year;
  @override
  FuelType get fuelType;
  @override
  VehicleType get vehicleType;
  @override
  String get vehicleImageUrl;
  @override
  String? get currentDriverId;
  @override
  String? get currentAssignmentId;
  @override
  double get tankCapacityLitres;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$VehicleModelImplCopyWith<_$VehicleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

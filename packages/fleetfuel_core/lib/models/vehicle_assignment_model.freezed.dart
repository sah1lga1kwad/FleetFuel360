// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VehicleAssignmentModel _$VehicleAssignmentModelFromJson(
    Map<String, dynamic> json) {
  return _VehicleAssignmentModel.fromJson(json);
}

/// @nodoc
mixin _$VehicleAssignmentModel {
  String get assignmentId => throw _privateConstructorUsedError;
  String get vehicleId => throw _privateConstructorUsedError;
  String get driverId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String get assignedByManagerId => throw _privateConstructorUsedError;
  int get startOdometerReading => throw _privateConstructorUsedError;
  int? get endOdometerReading => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VehicleAssignmentModelCopyWith<VehicleAssignmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleAssignmentModelCopyWith<$Res> {
  factory $VehicleAssignmentModelCopyWith(VehicleAssignmentModel value,
          $Res Function(VehicleAssignmentModel) then) =
      _$VehicleAssignmentModelCopyWithImpl<$Res, VehicleAssignmentModel>;
  @useResult
  $Res call(
      {String assignmentId,
      String vehicleId,
      String driverId,
      String companyId,
      DateTime startDate,
      DateTime? endDate,
      bool isActive,
      String assignedByManagerId,
      int startOdometerReading,
      int? endOdometerReading,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$VehicleAssignmentModelCopyWithImpl<$Res,
        $Val extends VehicleAssignmentModel>
    implements $VehicleAssignmentModelCopyWith<$Res> {
  _$VehicleAssignmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? vehicleId = null,
    Object? driverId = null,
    Object? companyId = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? assignedByManagerId = null,
    Object? startOdometerReading = null,
    Object? endOdometerReading = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      assignedByManagerId: null == assignedByManagerId
          ? _value.assignedByManagerId
          : assignedByManagerId // ignore: cast_nullable_to_non_nullable
              as String,
      startOdometerReading: null == startOdometerReading
          ? _value.startOdometerReading
          : startOdometerReading // ignore: cast_nullable_to_non_nullable
              as int,
      endOdometerReading: freezed == endOdometerReading
          ? _value.endOdometerReading
          : endOdometerReading // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$VehicleAssignmentModelImplCopyWith<$Res>
    implements $VehicleAssignmentModelCopyWith<$Res> {
  factory _$$VehicleAssignmentModelImplCopyWith(
          _$VehicleAssignmentModelImpl value,
          $Res Function(_$VehicleAssignmentModelImpl) then) =
      __$$VehicleAssignmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String assignmentId,
      String vehicleId,
      String driverId,
      String companyId,
      DateTime startDate,
      DateTime? endDate,
      bool isActive,
      String assignedByManagerId,
      int startOdometerReading,
      int? endOdometerReading,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$VehicleAssignmentModelImplCopyWithImpl<$Res>
    extends _$VehicleAssignmentModelCopyWithImpl<$Res,
        _$VehicleAssignmentModelImpl>
    implements _$$VehicleAssignmentModelImplCopyWith<$Res> {
  __$$VehicleAssignmentModelImplCopyWithImpl(
      _$VehicleAssignmentModelImpl _value,
      $Res Function(_$VehicleAssignmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? vehicleId = null,
    Object? driverId = null,
    Object? companyId = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? assignedByManagerId = null,
    Object? startOdometerReading = null,
    Object? endOdometerReading = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$VehicleAssignmentModelImpl(
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      assignedByManagerId: null == assignedByManagerId
          ? _value.assignedByManagerId
          : assignedByManagerId // ignore: cast_nullable_to_non_nullable
              as String,
      startOdometerReading: null == startOdometerReading
          ? _value.startOdometerReading
          : startOdometerReading // ignore: cast_nullable_to_non_nullable
              as int,
      endOdometerReading: freezed == endOdometerReading
          ? _value.endOdometerReading
          : endOdometerReading // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$VehicleAssignmentModelImpl implements _VehicleAssignmentModel {
  const _$VehicleAssignmentModelImpl(
      {required this.assignmentId,
      required this.vehicleId,
      required this.driverId,
      required this.companyId,
      required this.startDate,
      this.endDate,
      this.isActive = true,
      required this.assignedByManagerId,
      this.startOdometerReading = 0,
      this.endOdometerReading,
      required this.createdAt,
      required this.updatedAt});

  factory _$VehicleAssignmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleAssignmentModelImplFromJson(json);

  @override
  final String assignmentId;
  @override
  final String vehicleId;
  @override
  final String driverId;
  @override
  final String companyId;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String assignedByManagerId;
  @override
  @JsonKey()
  final int startOdometerReading;
  @override
  final int? endOdometerReading;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'VehicleAssignmentModel(assignmentId: $assignmentId, vehicleId: $vehicleId, driverId: $driverId, companyId: $companyId, startDate: $startDate, endDate: $endDate, isActive: $isActive, assignedByManagerId: $assignedByManagerId, startOdometerReading: $startOdometerReading, endOdometerReading: $endOdometerReading, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleAssignmentModelImpl &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.assignedByManagerId, assignedByManagerId) ||
                other.assignedByManagerId == assignedByManagerId) &&
            (identical(other.startOdometerReading, startOdometerReading) ||
                other.startOdometerReading == startOdometerReading) &&
            (identical(other.endOdometerReading, endOdometerReading) ||
                other.endOdometerReading == endOdometerReading) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      assignmentId,
      vehicleId,
      driverId,
      companyId,
      startDate,
      endDate,
      isActive,
      assignedByManagerId,
      startOdometerReading,
      endOdometerReading,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleAssignmentModelImplCopyWith<_$VehicleAssignmentModelImpl>
      get copyWith => __$$VehicleAssignmentModelImplCopyWithImpl<
          _$VehicleAssignmentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleAssignmentModelImplToJson(
      this,
    );
  }
}

abstract class _VehicleAssignmentModel implements VehicleAssignmentModel {
  const factory _VehicleAssignmentModel(
      {required final String assignmentId,
      required final String vehicleId,
      required final String driverId,
      required final String companyId,
      required final DateTime startDate,
      final DateTime? endDate,
      final bool isActive,
      required final String assignedByManagerId,
      final int startOdometerReading,
      final int? endOdometerReading,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$VehicleAssignmentModelImpl;

  factory _VehicleAssignmentModel.fromJson(Map<String, dynamic> json) =
      _$VehicleAssignmentModelImpl.fromJson;

  @override
  String get assignmentId;
  @override
  String get vehicleId;
  @override
  String get driverId;
  @override
  String get companyId;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isActive;
  @override
  String get assignedByManagerId;
  @override
  int get startOdometerReading;
  @override
  int? get endOdometerReading;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$VehicleAssignmentModelImplCopyWith<_$VehicleAssignmentModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

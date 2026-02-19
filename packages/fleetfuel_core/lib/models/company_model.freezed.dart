// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return _CompanyModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyModel {
  String get companyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get companyCode => throw _privateConstructorUsedError;
  String get managerId => throw _privateConstructorUsedError;
  List<String> get memberDriverIds => throw _privateConstructorUsedError;
  List<String> get vehicleIds => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyModelCopyWith<CompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyModelCopyWith<$Res> {
  factory $CompanyModelCopyWith(
          CompanyModel value, $Res Function(CompanyModel) then) =
      _$CompanyModelCopyWithImpl<$Res, CompanyModel>;
  @useResult
  $Res call(
      {String companyId,
      String name,
      String companyCode,
      String managerId,
      List<String> memberDriverIds,
      List<String> vehicleIds,
      String currency,
      String timezone,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CompanyModelCopyWithImpl<$Res, $Val extends CompanyModel>
    implements $CompanyModelCopyWith<$Res> {
  _$CompanyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyId = null,
    Object? name = null,
    Object? companyCode = null,
    Object? managerId = null,
    Object? memberDriverIds = null,
    Object? vehicleIds = null,
    Object? currency = null,
    Object? timezone = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      companyCode: null == companyCode
          ? _value.companyCode
          : companyCode // ignore: cast_nullable_to_non_nullable
              as String,
      managerId: null == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberDriverIds: null == memberDriverIds
          ? _value.memberDriverIds
          : memberDriverIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      vehicleIds: null == vehicleIds
          ? _value.vehicleIds
          : vehicleIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$CompanyModelImplCopyWith<$Res>
    implements $CompanyModelCopyWith<$Res> {
  factory _$$CompanyModelImplCopyWith(
          _$CompanyModelImpl value, $Res Function(_$CompanyModelImpl) then) =
      __$$CompanyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String companyId,
      String name,
      String companyCode,
      String managerId,
      List<String> memberDriverIds,
      List<String> vehicleIds,
      String currency,
      String timezone,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$CompanyModelImplCopyWithImpl<$Res>
    extends _$CompanyModelCopyWithImpl<$Res, _$CompanyModelImpl>
    implements _$$CompanyModelImplCopyWith<$Res> {
  __$$CompanyModelImplCopyWithImpl(
      _$CompanyModelImpl _value, $Res Function(_$CompanyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyId = null,
    Object? name = null,
    Object? companyCode = null,
    Object? managerId = null,
    Object? memberDriverIds = null,
    Object? vehicleIds = null,
    Object? currency = null,
    Object? timezone = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$CompanyModelImpl(
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      companyCode: null == companyCode
          ? _value.companyCode
          : companyCode // ignore: cast_nullable_to_non_nullable
              as String,
      managerId: null == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberDriverIds: null == memberDriverIds
          ? _value._memberDriverIds
          : memberDriverIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      vehicleIds: null == vehicleIds
          ? _value._vehicleIds
          : vehicleIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$CompanyModelImpl implements _CompanyModel {
  const _$CompanyModelImpl(
      {required this.companyId,
      required this.name,
      required this.companyCode,
      required this.managerId,
      final List<String> memberDriverIds = const [],
      final List<String> vehicleIds = const [],
      this.currency = 'INR',
      this.timezone = 'Asia/Kolkata',
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt})
      : _memberDriverIds = memberDriverIds,
        _vehicleIds = vehicleIds;

  factory _$CompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyModelImplFromJson(json);

  @override
  final String companyId;
  @override
  final String name;
  @override
  final String companyCode;
  @override
  final String managerId;
  final List<String> _memberDriverIds;
  @override
  @JsonKey()
  List<String> get memberDriverIds {
    if (_memberDriverIds is EqualUnmodifiableListView) return _memberDriverIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberDriverIds);
  }

  final List<String> _vehicleIds;
  @override
  @JsonKey()
  List<String> get vehicleIds {
    if (_vehicleIds is EqualUnmodifiableListView) return _vehicleIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicleIds);
  }

  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String timezone;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CompanyModel(companyId: $companyId, name: $name, companyCode: $companyCode, managerId: $managerId, memberDriverIds: $memberDriverIds, vehicleIds: $vehicleIds, currency: $currency, timezone: $timezone, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyModelImpl &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.companyCode, companyCode) ||
                other.companyCode == companyCode) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            const DeepCollectionEquality()
                .equals(other._memberDriverIds, _memberDriverIds) &&
            const DeepCollectionEquality()
                .equals(other._vehicleIds, _vehicleIds) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
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
      companyId,
      name,
      companyCode,
      managerId,
      const DeepCollectionEquality().hash(_memberDriverIds),
      const DeepCollectionEquality().hash(_vehicleIds),
      currency,
      timezone,
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      __$$CompanyModelImplCopyWithImpl<_$CompanyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyModel implements CompanyModel {
  const factory _CompanyModel(
      {required final String companyId,
      required final String name,
      required final String companyCode,
      required final String managerId,
      final List<String> memberDriverIds,
      final List<String> vehicleIds,
      final String currency,
      final String timezone,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$CompanyModelImpl;

  factory _CompanyModel.fromJson(Map<String, dynamic> json) =
      _$CompanyModelImpl.fromJson;

  @override
  String get companyId;
  @override
  String get name;
  @override
  String get companyCode;
  @override
  String get managerId;
  @override
  List<String> get memberDriverIds;
  @override
  List<String> get vehicleIds;
  @override
  String get currency;
  @override
  String get timezone;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String get model => throw _privateConstructorUsedError;
  String get os => throw _privateConstructorUsedError;
  String get osVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) then) =
      _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call({String model, String os, String osVersion});
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? os = null,
    Object? osVersion = null,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      os: null == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
          _$DeviceInfoImpl value, $Res Function(_$DeviceInfoImpl) then) =
      __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String model, String os, String osVersion});
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
      _$DeviceInfoImpl _value, $Res Function(_$DeviceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? os = null,
    Object? osVersion = null,
  }) {
    return _then(_$DeviceInfoImpl(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      os: null == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl({this.model = '', this.os = '', this.osVersion = ''});

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  @JsonKey()
  final String model;
  @override
  @JsonKey()
  final String os;
  @override
  @JsonKey()
  final String osVersion;

  @override
  String toString() {
    return 'DeviceInfo(model: $model, os: $os, osVersion: $osVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.os, os) || other.os == os) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, model, os, osVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(
      this,
    );
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo(
      {final String model,
      final String os,
      final String osVersion}) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String get model;
  @override
  String get os;
  @override
  String get osVersion;
  @override
  @JsonKey(ignore: true)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;
  String get companyCode => throw _privateConstructorUsedError;
  String get licenseNumber => throw _privateConstructorUsedError;
  String get licenseImageUrl => throw _privateConstructorUsedError;
  bool get kycCompleted => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;
  DeviceInfo get deviceInfo => throw _privateConstructorUsedError;
  DriverLocation? get lastKnownLocation => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String userId,
      String name,
      String email,
      String phoneNumber,
      String profileImageUrl,
      String role,
      String? companyId,
      String companyCode,
      String licenseNumber,
      String licenseImageUrl,
      bool kycCompleted,
      bool isActive,
      String fcmToken,
      String appVersion,
      DeviceInfo deviceInfo,
      DriverLocation? lastKnownLocation,
      DateTime createdAt,
      DateTime updatedAt});

  $DeviceInfoCopyWith<$Res> get deviceInfo;
  $DriverLocationCopyWith<$Res>? get lastKnownLocation;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? profileImageUrl = null,
    Object? role = null,
    Object? companyId = freezed,
    Object? companyCode = null,
    Object? licenseNumber = null,
    Object? licenseImageUrl = null,
    Object? kycCompleted = null,
    Object? isActive = null,
    Object? fcmToken = null,
    Object? appVersion = null,
    Object? deviceInfo = null,
    Object? lastKnownLocation = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyCode: null == companyCode
          ? _value.companyCode
          : companyCode // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNumber: null == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      licenseImageUrl: null == licenseImageUrl
          ? _value.licenseImageUrl
          : licenseImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      kycCompleted: null == kycCompleted
          ? _value.kycCompleted
          : kycCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
      lastKnownLocation: freezed == lastKnownLocation
          ? _value.lastKnownLocation
          : lastKnownLocation // ignore: cast_nullable_to_non_nullable
              as DriverLocation?,
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
  $DeviceInfoCopyWith<$Res> get deviceInfo {
    return $DeviceInfoCopyWith<$Res>(_value.deviceInfo, (value) {
      return _then(_value.copyWith(deviceInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DriverLocationCopyWith<$Res>? get lastKnownLocation {
    if (_value.lastKnownLocation == null) {
      return null;
    }

    return $DriverLocationCopyWith<$Res>(_value.lastKnownLocation!, (value) {
      return _then(_value.copyWith(lastKnownLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String name,
      String email,
      String phoneNumber,
      String profileImageUrl,
      String role,
      String? companyId,
      String companyCode,
      String licenseNumber,
      String licenseImageUrl,
      bool kycCompleted,
      bool isActive,
      String fcmToken,
      String appVersion,
      DeviceInfo deviceInfo,
      DriverLocation? lastKnownLocation,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $DeviceInfoCopyWith<$Res> get deviceInfo;
  @override
  $DriverLocationCopyWith<$Res>? get lastKnownLocation;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? profileImageUrl = null,
    Object? role = null,
    Object? companyId = freezed,
    Object? companyCode = null,
    Object? licenseNumber = null,
    Object? licenseImageUrl = null,
    Object? kycCompleted = null,
    Object? isActive = null,
    Object? fcmToken = null,
    Object? appVersion = null,
    Object? deviceInfo = null,
    Object? lastKnownLocation = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyCode: null == companyCode
          ? _value.companyCode
          : companyCode // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNumber: null == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      licenseImageUrl: null == licenseImageUrl
          ? _value.licenseImageUrl
          : licenseImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      kycCompleted: null == kycCompleted
          ? _value.kycCompleted
          : kycCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
      lastKnownLocation: freezed == lastKnownLocation
          ? _value.lastKnownLocation
          : lastKnownLocation // ignore: cast_nullable_to_non_nullable
              as DriverLocation?,
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
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.userId,
      required this.name,
      required this.email,
      this.phoneNumber = '',
      this.profileImageUrl = '',
      this.role = 'driver',
      this.companyId,
      this.companyCode = '',
      this.licenseNumber = '',
      this.licenseImageUrl = '',
      this.kycCompleted = false,
      this.isActive = true,
      this.fcmToken = '',
      this.appVersion = '',
      this.deviceInfo = const DeviceInfo(),
      this.lastKnownLocation,
      required this.createdAt,
      required this.updatedAt});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String profileImageUrl;
  @override
  @JsonKey()
  final String role;
  @override
  final String? companyId;
  @override
  @JsonKey()
  final String companyCode;
  @override
  @JsonKey()
  final String licenseNumber;
  @override
  @JsonKey()
  final String licenseImageUrl;
  @override
  @JsonKey()
  final bool kycCompleted;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final String fcmToken;
  @override
  @JsonKey()
  final String appVersion;
  @override
  @JsonKey()
  final DeviceInfo deviceInfo;
  @override
  final DriverLocation? lastKnownLocation;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, email: $email, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, role: $role, companyId: $companyId, companyCode: $companyCode, licenseNumber: $licenseNumber, licenseImageUrl: $licenseImageUrl, kycCompleted: $kycCompleted, isActive: $isActive, fcmToken: $fcmToken, appVersion: $appVersion, deviceInfo: $deviceInfo, lastKnownLocation: $lastKnownLocation, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyCode, companyCode) ||
                other.companyCode == companyCode) &&
            (identical(other.licenseNumber, licenseNumber) ||
                other.licenseNumber == licenseNumber) &&
            (identical(other.licenseImageUrl, licenseImageUrl) ||
                other.licenseImageUrl == licenseImageUrl) &&
            (identical(other.kycCompleted, kycCompleted) ||
                other.kycCompleted == kycCompleted) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo) &&
            (identical(other.lastKnownLocation, lastKnownLocation) ||
                other.lastKnownLocation == lastKnownLocation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      name,
      email,
      phoneNumber,
      profileImageUrl,
      role,
      companyId,
      companyCode,
      licenseNumber,
      licenseImageUrl,
      kycCompleted,
      isActive,
      fcmToken,
      appVersion,
      deviceInfo,
      lastKnownLocation,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String userId,
      required final String name,
      required final String email,
      final String phoneNumber,
      final String profileImageUrl,
      final String role,
      final String? companyId,
      final String companyCode,
      final String licenseNumber,
      final String licenseImageUrl,
      final bool kycCompleted,
      final bool isActive,
      final String fcmToken,
      final String appVersion,
      final DeviceInfo deviceInfo,
      final DriverLocation? lastKnownLocation,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get name;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  String get profileImageUrl;
  @override
  String get role;
  @override
  String? get companyId;
  @override
  String get companyCode;
  @override
  String get licenseNumber;
  @override
  String get licenseImageUrl;
  @override
  bool get kycCompleted;
  @override
  bool get isActive;
  @override
  String get fcmToken;
  @override
  String get appVersion;
  @override
  DeviceInfo get deviceInfo;
  @override
  DriverLocation? get lastKnownLocation;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

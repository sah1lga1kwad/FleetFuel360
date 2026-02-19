// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      model: json['model'] as String? ?? '',
      os: json['os'] as String? ?? '',
      osVersion: json['osVersion'] as String? ?? '',
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'os': instance.os,
      'osVersion': instance.osVersion,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String? ?? '',
      role: json['role'] as String? ?? 'driver',
      companyId: json['companyId'] as String?,
      companyCode: json['companyCode'] as String? ?? '',
      licenseNumber: json['licenseNumber'] as String? ?? '',
      licenseImageUrl: json['licenseImageUrl'] as String? ?? '',
      kycCompleted: json['kycCompleted'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      fcmToken: json['fcmToken'] as String? ?? '',
      appVersion: json['appVersion'] as String? ?? '',
      deviceInfo: json['deviceInfo'] == null
          ? const DeviceInfo()
          : DeviceInfo.fromJson(json['deviceInfo'] as Map<String, dynamic>),
      lastKnownLocation: json['lastKnownLocation'] == null
          ? null
          : DriverLocation.fromJson(
              json['lastKnownLocation'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'role': instance.role,
      'companyId': instance.companyId,
      'companyCode': instance.companyCode,
      'licenseNumber': instance.licenseNumber,
      'licenseImageUrl': instance.licenseImageUrl,
      'kycCompleted': instance.kycCompleted,
      'isActive': instance.isActive,
      'fcmToken': instance.fcmToken,
      'appVersion': instance.appVersion,
      'deviceInfo': instance.deviceInfo,
      'lastKnownLocation': instance.lastKnownLocation,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

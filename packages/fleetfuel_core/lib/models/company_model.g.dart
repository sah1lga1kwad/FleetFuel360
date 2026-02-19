// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      companyCode: json['companyCode'] as String,
      managerId: json['managerId'] as String,
      memberDriverIds: (json['memberDriverIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      vehicleIds: (json['vehicleIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currency: json['currency'] as String? ?? 'INR',
      timezone: json['timezone'] as String? ?? 'Asia/Kolkata',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'name': instance.name,
      'companyCode': instance.companyCode,
      'managerId': instance.managerId,
      'memberDriverIds': instance.memberDriverIds,
      'vehicleIds': instance.vehicleIds,
      'currency': instance.currency,
      'timezone': instance.timezone,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

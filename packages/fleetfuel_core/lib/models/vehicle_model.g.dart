// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleModelImpl _$$VehicleModelImplFromJson(Map<String, dynamic> json) =>
    _$VehicleModelImpl(
      vehicleId: json['vehicleId'] as String,
      companyId: json['companyId'] as String,
      registrationNumber: json['registrationNumber'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      fuelType: $enumDecode(_$FuelTypeEnumMap, json['fuelType']),
      vehicleType: $enumDecode(_$VehicleTypeEnumMap, json['vehicleType']),
      vehicleImageUrl: json['vehicleImageUrl'] as String? ?? '',
      currentDriverId: json['currentDriverId'] as String?,
      currentAssignmentId: json['currentAssignmentId'] as String?,
      tankCapacityLitres: (json['tankCapacityLitres'] as num?)?.toDouble() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VehicleModelImplToJson(_$VehicleModelImpl instance) =>
    <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'companyId': instance.companyId,
      'registrationNumber': instance.registrationNumber,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
      'vehicleType': _$VehicleTypeEnumMap[instance.vehicleType]!,
      'vehicleImageUrl': instance.vehicleImageUrl,
      'currentDriverId': instance.currentDriverId,
      'currentAssignmentId': instance.currentAssignmentId,
      'tankCapacityLitres': instance.tankCapacityLitres,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$FuelTypeEnumMap = {
  FuelType.petrol: 'petrol',
  FuelType.diesel: 'diesel',
  FuelType.cng: 'cng',
  FuelType.electric: 'electric',
};

const _$VehicleTypeEnumMap = {
  VehicleType.truck: 'truck',
  VehicleType.van: 'van',
  VehicleType.car: 'car',
  VehicleType.bike: 'bike',
  VehicleType.other: 'other',
};

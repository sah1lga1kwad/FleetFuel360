// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleAssignmentModelImpl _$$VehicleAssignmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleAssignmentModelImpl(
      assignmentId: json['assignmentId'] as String,
      vehicleId: json['vehicleId'] as String,
      driverId: json['driverId'] as String,
      companyId: json['companyId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      assignedByManagerId: json['assignedByManagerId'] as String,
      startOdometerReading:
          (json['startOdometerReading'] as num?)?.toInt() ?? 0,
      endOdometerReading: (json['endOdometerReading'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VehicleAssignmentModelImplToJson(
        _$VehicleAssignmentModelImpl instance) =>
    <String, dynamic>{
      'assignmentId': instance.assignmentId,
      'vehicleId': instance.vehicleId,
      'driverId': instance.driverId,
      'companyId': instance.companyId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'assignedByManagerId': instance.assignedByManagerId,
      'startOdometerReading': instance.startOdometerReading,
      'endOdometerReading': instance.endOdometerReading,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

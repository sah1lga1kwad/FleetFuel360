import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_model.freezed.dart';
part 'vehicle_model.g.dart';

enum FuelType { petrol, diesel, cng, electric }

enum VehicleType { truck, van, car, bike, other }

@freezed
class VehicleModel with _$VehicleModel {
  const factory VehicleModel({
    required String vehicleId,
    required String companyId,
    required String registrationNumber,
    required String make,
    required String model,
    required int year,
    required FuelType fuelType,
    required VehicleType vehicleType,
    @Default('') String vehicleImageUrl,
    String? currentDriverId,
    String? currentAssignmentId,
    @Default(0) double tankCapacityLitres,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VehicleModel;

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  factory VehicleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VehicleModel.fromJson({
      ...data,
      'vehicleId': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}

extension VehicleModelX on VehicleModel {
  Map<String, dynamic> toFirestore() {
    return {
      'companyId': companyId,
      'registrationNumber': registrationNumber,
      'make': make,
      'model': model,
      'year': year,
      'fuelType': fuelType.name,
      'vehicleType': vehicleType.name,
      'vehicleImageUrl': vehicleImageUrl,
      'currentDriverId': currentDriverId,
      'currentAssignmentId': currentAssignmentId,
      'tankCapacityLitres': tankCapacityLitres,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

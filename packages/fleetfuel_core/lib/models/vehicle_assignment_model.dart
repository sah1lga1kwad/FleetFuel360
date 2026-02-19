import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_assignment_model.freezed.dart';
part 'vehicle_assignment_model.g.dart';

@freezed
class VehicleAssignmentModel with _$VehicleAssignmentModel {
  const factory VehicleAssignmentModel({
    required String assignmentId,
    required String vehicleId,
    required String driverId,
    required String companyId,
    required DateTime startDate,
    DateTime? endDate,
    @Default(true) bool isActive,
    required String assignedByManagerId,
    @Default(0) int startOdometerReading,
    int? endOdometerReading,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VehicleAssignmentModel;

  factory VehicleAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleAssignmentModelFromJson(json);

  factory VehicleAssignmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VehicleAssignmentModel.fromJson({
      ...data,
      'assignmentId': doc.id,
      'startDate':
          (data['startDate'] as Timestamp).toDate().toIso8601String(),
      'endDate': data['endDate'] != null
          ? (data['endDate'] as Timestamp).toDate().toIso8601String()
          : null,
      'createdAt':
          (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt':
          (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}

extension VehicleAssignmentModelX on VehicleAssignmentModel {
  Map<String, dynamic> toFirestore() {
    return {
      'vehicleId': vehicleId,
      'driverId': driverId,
      'companyId': companyId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'isActive': isActive,
      'assignedByManagerId': assignedByManagerId,
      'startOdometerReading': startOdometerReading,
      'endOdometerReading': endOdometerReading,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

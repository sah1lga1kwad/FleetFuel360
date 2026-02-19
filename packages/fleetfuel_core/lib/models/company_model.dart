import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String companyId,
    required String name,
    required String companyCode,
    required String managerId,
    @Default([]) List<String> memberDriverIds,
    @Default([]) List<String> vehicleIds,
    @Default('INR') String currency,
    @Default('Asia/Kolkata') String timezone,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CompanyModel.fromJson({
      ...data,
      'companyId': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}

extension CompanyModelX on CompanyModel {
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'companyCode': companyCode,
      'managerId': managerId,
      'memberDriverIds': memberDriverIds,
      'vehicleIds': vehicleIds,
      'currency': currency,
      'timezone': timezone,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

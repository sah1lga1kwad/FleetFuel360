import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'driver_location.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    @Default('') String model,
    @Default('') String os,
    @Default('') String osVersion,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String name,
    required String email,
    @Default('') String phoneNumber,
    @Default('') String profileImageUrl,
    @Default('driver') String role,
    String? companyId,
    @Default('') String companyCode,
    @Default('') String licenseNumber,
    @Default('') String licenseImageUrl,
    @Default(false) bool kycCompleted,
    @Default(true) bool isActive,
    @Default('') String fcmToken,
    @Default('') String appVersion,
    @Default(DeviceInfo()) DeviceInfo deviceInfo,
    DriverLocation? lastKnownLocation,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final rawLocation = data['lastKnownLocation'];
    return UserModel.fromJson({
      ...data,
      'userId': doc.id,
      'lastKnownLocation': rawLocation is Map<String, dynamic>
          ? DriverLocation.fromMap(rawLocation).toJson()
          : rawLocation is Map
              ? DriverLocation.fromMap(Map<String, dynamic>.from(rawLocation))
                  .toJson()
              : null,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}

extension UserModelX on UserModel {
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'role': role,
      'companyId': companyId,
      'companyCode': companyCode,
      'licenseNumber': licenseNumber,
      'licenseImageUrl': licenseImageUrl,
      'kycCompleted': kycCompleted,
      'isActive': isActive,
      'fcmToken': fcmToken,
      'appVersion': appVersion,
      'deviceInfo': deviceInfo.toJson(),
      'lastKnownLocation': lastKnownLocation?.toJson(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

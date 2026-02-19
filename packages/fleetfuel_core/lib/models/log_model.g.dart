// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationDataImpl _$$LocationDataImplFromJson(Map<String, dynamic> json) =>
    _$LocationDataImpl(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      address: json['address'] as String? ?? '',
      geohash: json['geohash'] as String? ?? '',
    );

Map<String, dynamic> _$$LocationDataImplToJson(_$LocationDataImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'address': instance.address,
      'geohash': instance.geohash,
    };

_$DeviceContextImpl _$$DeviceContextImplFromJson(Map<String, dynamic> json) =>
    _$DeviceContextImpl(
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      bearing: (json['bearing'] as num?)?.toDouble() ?? 0.0,
      altitude: (json['altitude'] as num?)?.toDouble() ?? 0.0,
      batteryLevel: (json['batteryLevel'] as num?)?.toInt() ?? 0,
      isCharging: json['isCharging'] as bool? ?? false,
      networkType: json['networkType'] as String? ?? 'none',
      signalStrength: json['signalStrength'] as String? ?? '',
    );

Map<String, dynamic> _$$DeviceContextImplToJson(_$DeviceContextImpl instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'bearing': instance.bearing,
      'altitude': instance.altitude,
      'batteryLevel': instance.batteryLevel,
      'isCharging': instance.isCharging,
      'networkType': instance.networkType,
      'signalStrength': instance.signalStrength,
    };

_$EditHistoryEntryImpl _$$EditHistoryEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$EditHistoryEntryImpl(
      editedAt: DateTime.parse(json['editedAt'] as String),
      editedByDriverId: json['editedByDriverId'] as String,
      previousValues:
          json['previousValues'] as Map<String, dynamic>? ?? const {},
      reason: json['reason'] as String? ?? '',
    );

Map<String, dynamic> _$$EditHistoryEntryImplToJson(
        _$EditHistoryEntryImpl instance) =>
    <String, dynamic>{
      'editedAt': instance.editedAt.toIso8601String(),
      'editedByDriverId': instance.editedByDriverId,
      'previousValues': instance.previousValues,
      'reason': instance.reason,
    };

_$LogModelImpl _$$LogModelImplFromJson(Map<String, dynamic> json) =>
    _$LogModelImpl(
      logId: json['logId'] as String,
      driverId: json['driverId'] as String,
      vehicleId: json['vehicleId'] as String,
      companyId: json['companyId'] as String,
      assignmentId: json['assignmentId'] as String,
      logType: $enumDecode(_$LogTypeEnumMap, json['logType']),
      category: $enumDecodeNullable(_$LogCategoryEnumMap, json['category']) ??
          LogCategory.other,
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'INR',
      paidBy:
          $enumDecodeNullable(_$PaidByEnumMap, json['paidBy']) ?? PaidBy.driver,
      paymentMode:
          $enumDecodeNullable(_$PaymentModeEnumMap, json['paymentMode']) ??
              PaymentMode.cash,
      description: json['description'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      receiptImageUrls: (json['receiptImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      odometerImageUrl: json['odometerImageUrl'] as String?,
      fuelMeterImageUrl: json['fuelMeterImageUrl'] as String?,
      vehicleImageUrl: json['vehicleImageUrl'] as String?,
      odometerReading: (json['odometerReading'] as num?)?.toInt() ?? 0,
      fuelQuantityLitres:
          (json['fuelQuantityLitres'] as num?)?.toDouble() ?? 0.0,
      fuelPricePerLitre: (json['fuelPricePerLitre'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] == null
          ? const LocationData()
          : LocationData.fromJson(json['location'] as Map<String, dynamic>),
      deviceContext: json['deviceContext'] == null
          ? const DeviceContext()
          : DeviceContext.fromJson(
              json['deviceContext'] as Map<String, dynamic>),
      odometerReadingExtracted:
          (json['odometerReadingExtracted'] as num?)?.toInt(),
      fuelLevelExtracted: (json['fuelLevelExtracted'] as num?)?.toDouble(),
      receiptAmountExtracted: (json['receiptAmountExtracted'] as num?)?.toInt(),
      extractionConfidence: (json['extractionConfidence'] as num?)?.toDouble(),
      isEdited: json['isEdited'] as bool? ?? false,
      editHistory: (json['editHistory'] as List<dynamic>?)
              ?.map((e) => EditHistoryEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LogModelImplToJson(_$LogModelImpl instance) =>
    <String, dynamic>{
      'logId': instance.logId,
      'driverId': instance.driverId,
      'vehicleId': instance.vehicleId,
      'companyId': instance.companyId,
      'assignmentId': instance.assignmentId,
      'logType': _$LogTypeEnumMap[instance.logType]!,
      'category': _$LogCategoryEnumMap[instance.category]!,
      'amount': instance.amount,
      'currency': instance.currency,
      'paidBy': _$PaidByEnumMap[instance.paidBy]!,
      'paymentMode': _$PaymentModeEnumMap[instance.paymentMode]!,
      'description': instance.description,
      'notes': instance.notes,
      'receiptImageUrls': instance.receiptImageUrls,
      'odometerImageUrl': instance.odometerImageUrl,
      'fuelMeterImageUrl': instance.fuelMeterImageUrl,
      'vehicleImageUrl': instance.vehicleImageUrl,
      'odometerReading': instance.odometerReading,
      'fuelQuantityLitres': instance.fuelQuantityLitres,
      'fuelPricePerLitre': instance.fuelPricePerLitre,
      'location': instance.location,
      'deviceContext': instance.deviceContext,
      'odometerReadingExtracted': instance.odometerReadingExtracted,
      'fuelLevelExtracted': instance.fuelLevelExtracted,
      'receiptAmountExtracted': instance.receiptAmountExtracted,
      'extractionConfidence': instance.extractionConfidence,
      'isEdited': instance.isEdited,
      'editHistory': instance.editHistory,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$LogTypeEnumMap = {
  LogType.fuelFill: 'fuel_fill',
  LogType.cashExpense: 'cash_expense',
  LogType.paymentReceived: 'payment_received',
  LogType.advance: 'advance',
  LogType.loan: 'loan',
  LogType.other: 'other',
};

const _$LogCategoryEnumMap = {
  LogCategory.fuel: 'fuel',
  LogCategory.repair: 'repair',
  LogCategory.food: 'food',
  LogCategory.toll: 'toll',
  LogCategory.tyre: 'tyre',
  LogCategory.oil: 'oil',
  LogCategory.cleaning: 'cleaning',
  LogCategory.fine: 'fine',
  LogCategory.other: 'other',
};

const _$PaidByEnumMap = {
  PaidBy.driver: 'driver',
  PaidBy.company: 'company',
};

const _$PaymentModeEnumMap = {
  PaymentMode.cash: 'cash',
  PaymentMode.upi: 'upi',
  PaymentMode.card: 'card',
  PaymentMode.fuelCard: 'fuel_card',
  PaymentMode.bankTransfer: 'bank_transfer',
  PaymentMode.other: 'other',
};

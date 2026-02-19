import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_model.freezed.dart';
part 'log_model.g.dart';

enum LogType {
  @JsonValue('fuel_fill')
  fuelFill,
  @JsonValue('cash_expense')
  cashExpense,
  @JsonValue('payment_received')
  paymentReceived,
  @JsonValue('advance')
  advance,
  @JsonValue('loan')
  loan,
  @JsonValue('other')
  other,
}

enum LogCategory {
  @JsonValue('fuel')
  fuel,
  @JsonValue('repair')
  repair,
  @JsonValue('food')
  food,
  @JsonValue('toll')
  toll,
  @JsonValue('tyre')
  tyre,
  @JsonValue('oil')
  oil,
  @JsonValue('cleaning')
  cleaning,
  @JsonValue('fine')
  fine,
  @JsonValue('other')
  other,
}

enum PaidBy {
  @JsonValue('driver')
  driver,
  @JsonValue('company')
  company,
}

enum PaymentMode {
  @JsonValue('cash')
  cash,
  @JsonValue('upi')
  upi,
  @JsonValue('card')
  card,
  @JsonValue('fuel_card')
  fuelCard,
  @JsonValue('bank_transfer')
  bankTransfer,
  @JsonValue('other')
  other,
}

@freezed
class LocationData with _$LocationData {
  const factory LocationData({
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default(0.0) double accuracy,
    @Default('') String address,
    @Default('') String geohash,
  }) = _LocationData;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);
}

@freezed
class DeviceContext with _$DeviceContext {
  const factory DeviceContext({
    @Default(0.0) double speed,
    @Default(0.0) double bearing,
    @Default(0.0) double altitude,
    @Default(0) int batteryLevel,
    @Default(false) bool isCharging,
    @Default('none') String networkType,
    @Default('') String signalStrength,
  }) = _DeviceContext;

  factory DeviceContext.fromJson(Map<String, dynamic> json) =>
      _$DeviceContextFromJson(json);
}

@freezed
class EditHistoryEntry with _$EditHistoryEntry {
  const factory EditHistoryEntry({
    required DateTime editedAt,
    required String editedByDriverId,
    @Default({}) Map<String, dynamic> previousValues,
    @Default('') String reason,
  }) = _EditHistoryEntry;

  factory EditHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$EditHistoryEntryFromJson(json);
}

@freezed
class LogModel with _$LogModel {
  const factory LogModel({
    required String logId,
    required String driverId,
    required String vehicleId,
    required String companyId,
    required String assignmentId,

    // Classification
    required LogType logType,
    @Default(LogCategory.other) LogCategory category,

    // Money — stored in paise/cents
    @Default(0) int amount,
    @Default('INR') String currency,
    @Default(PaidBy.driver) PaidBy paidBy,
    @Default(PaymentMode.cash) PaymentMode paymentMode,

    // Description
    @Default('') String description,
    @Default('') String notes,

    // Image URLs (Firebase Storage)
    @Default([]) List<String> receiptImageUrls,
    String? odometerImageUrl,
    String? fuelMeterImageUrl,
    String? vehicleImageUrl,

    // Readings
    @Default(0) int odometerReading,
    @Default(0.0) double fuelQuantityLitres,
    @Default(0.0) double fuelPricePerLitre,

    // Location
    @Default(LocationData()) LocationData location,

    // Device context
    @Default(DeviceContext()) DeviceContext deviceContext,

    // V2 extraction fields (null in Phase 1)
    int? odometerReadingExtracted,
    double? fuelLevelExtracted,
    int? receiptAmountExtracted,
    double? extractionConfidence,

    // Edit history
    @Default(false) bool isEdited,
    @Default([]) List<EditHistoryEntry> editHistory,

    // Status
    @Default('active') String status,

    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LogModel;

  factory LogModel.fromJson(Map<String, dynamic> json) =>
      _$LogModelFromJson(json);

  factory LogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Convert nested Timestamps
    final locationData = data['location'] as Map<String, dynamic>? ?? {};
    final deviceCtx = data['deviceContext'] as Map<String, dynamic>? ?? {};

    final editHistoryRaw = data['editHistory'] as List<dynamic>? ?? [];
    final editHistory = editHistoryRaw.map((e) {
      final entry = Map<String, dynamic>.from(e as Map);
      if (entry['editedAt'] is Timestamp) {
        entry['editedAt'] =
            (entry['editedAt'] as Timestamp).toDate().toIso8601String();
      }
      return entry;
    }).toList();

    return LogModel.fromJson({
      ...data,
      'logId': doc.id,
      'logType': _normalizeLogType(data['logType']),
      'category': _normalizeCategory(data['category']),
      'paidBy': _normalizePaidBy(data['paidBy']),
      'paymentMode': _normalizePaymentMode(data['paymentMode']),
      'location': locationData,
      'deviceContext': deviceCtx,
      'editHistory': editHistory,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}

extension LogModelX on LogModel {
  Map<String, dynamic> toFirestore() {
    return {
      'driverId': driverId,
      'vehicleId': vehicleId,
      'companyId': companyId,
      'assignmentId': assignmentId,
      'logType': _logTypeToFirestore(logType),
      'category': _categoryToFirestore(category),
      'amount': amount,
      'currency': currency,
      'paidBy': _paidByToFirestore(paidBy),
      'paymentMode': _paymentModeToFirestore(paymentMode),
      'description': description,
      'notes': notes,
      'receiptImageUrls': receiptImageUrls,
      'odometerImageUrl': odometerImageUrl,
      'fuelMeterImageUrl': fuelMeterImageUrl,
      'vehicleImageUrl': vehicleImageUrl,
      'odometerReading': odometerReading,
      'fuelQuantityLitres': fuelQuantityLitres,
      'fuelPricePerLitre': fuelPricePerLitre,
      'location': location.toJson(),
      'deviceContext': deviceContext.toJson(),
      'odometerReadingExtracted': odometerReadingExtracted,
      'fuelLevelExtracted': fuelLevelExtracted,
      'receiptAmountExtracted': receiptAmountExtracted,
      'extractionConfidence': extractionConfidence,
      'isEdited': isEdited,
      'editHistory': editHistory.map((e) {
        final map = e.toJson();
        map['editedAt'] = Timestamp.fromDate(e.editedAt);
        return map;
      }).toList(),
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Amount owed to driver: cash_expense paid by driver minus received payments
  bool get isExpenseByDriver =>
      logType == LogType.cashExpense && paidBy == PaidBy.driver;

  bool get isIncome =>
      logType == LogType.paymentReceived || logType == LogType.advance;
}

String _logTypeToFirestore(LogType value) => switch (value) {
      LogType.fuelFill => 'fuel_fill',
      LogType.cashExpense => 'cash_expense',
      LogType.paymentReceived => 'payment_received',
      LogType.advance => 'advance',
      LogType.loan => 'loan',
      LogType.other => 'other',
    };

String _categoryToFirestore(LogCategory value) => switch (value) {
      LogCategory.fuel => 'fuel',
      LogCategory.repair => 'repair',
      LogCategory.food => 'food',
      LogCategory.toll => 'toll',
      LogCategory.tyre => 'tyre',
      LogCategory.oil => 'oil',
      LogCategory.cleaning => 'cleaning',
      LogCategory.fine => 'fine',
      LogCategory.other => 'other',
    };

String _paidByToFirestore(PaidBy value) => switch (value) {
      PaidBy.driver => 'driver',
      PaidBy.company => 'company',
    };

String _paymentModeToFirestore(PaymentMode value) => switch (value) {
      PaymentMode.cash => 'cash',
      PaymentMode.upi => 'upi',
      PaymentMode.card => 'card',
      PaymentMode.fuelCard => 'fuel_card',
      PaymentMode.bankTransfer => 'bank_transfer',
      PaymentMode.other => 'other',
    };

String _normalizeLogType(Object? raw) {
  final value = (raw ?? '').toString();
  switch (value) {
    case 'fuel_fill':
    case 'fuelFill':
    case 'duel_fill':
      return 'fuel_fill';
    case 'cash_expense':
    case 'cashExpense':
      return 'cash_expense';
    case 'payment_received':
    case 'paymentReceived':
    case 'payment_recieved':
      return 'payment_received';
    case 'advance':
      return 'advance';
    case 'loan':
      return 'loan';
    default:
      return 'other';
  }
}

String _normalizeCategory(Object? raw) {
  final value = (raw ?? '').toString();
  switch (value) {
    case 'fuel':
    case 'repair':
    case 'food':
    case 'toll':
    case 'tyre':
    case 'oil':
    case 'cleaning':
    case 'fine':
      return value;
    default:
      return 'other';
  }
}

String _normalizePaidBy(Object? raw) {
  final value = (raw ?? '').toString();
  switch (value) {
    case 'company':
    case 'Company':
      return 'company';
    default:
      return 'driver';
  }
}

String _normalizePaymentMode(Object? raw) {
  final value = (raw ?? '').toString();
  switch (value) {
    case 'cash':
    case 'upi':
    case 'card':
    case 'fuel_card':
    case 'fuelCard':
      return value == 'fuelCard' ? 'fuel_card' : value;
    case 'bank_transfer':
    case 'bankTransfer':
      return 'bank_transfer';
    default:
      return 'other';
  }
}

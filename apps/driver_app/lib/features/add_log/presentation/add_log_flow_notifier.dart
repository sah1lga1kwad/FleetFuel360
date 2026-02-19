import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fleetfuel_core/fleetfuel_core.dart';

/// Holds state shared across the 4-step Add Log flow.
class AddLogFlowState {
  final LogType? logType;
  final String? odometerImagePath;
  final String? fuelMeterImagePath;
  final String? vehicleImagePath;
  final List<String> receiptImagePaths;

  // Step 3 details
  final int odometerReading;
  final LogCategory category;
  final int amount; // in paise
  final PaymentMode paymentMode;
  final PaidBy paidBy;
  final double fuelQuantityLitres;
  final double fuelPricePerLitre;
  final String description;
  final String notes;

  const AddLogFlowState({
    this.logType,
    this.odometerImagePath,
    this.fuelMeterImagePath,
    this.vehicleImagePath,
    this.receiptImagePaths = const [],
    this.odometerReading = 0,
    this.category = LogCategory.other,
    this.amount = 0,
    this.paymentMode = PaymentMode.cash,
    this.paidBy = PaidBy.driver,
    this.fuelQuantityLitres = 0,
    this.fuelPricePerLitre = 0,
    this.description = '',
    this.notes = '',
  });

  AddLogFlowState copyWith({
    LogType? logType,
    String? odometerImagePath,
    String? fuelMeterImagePath,
    String? vehicleImagePath,
    List<String>? receiptImagePaths,
    int? odometerReading,
    LogCategory? category,
    int? amount,
    PaymentMode? paymentMode,
    PaidBy? paidBy,
    double? fuelQuantityLitres,
    double? fuelPricePerLitre,
    String? description,
    String? notes,
  }) {
    return AddLogFlowState(
      logType: logType ?? this.logType,
      odometerImagePath: odometerImagePath ?? this.odometerImagePath,
      fuelMeterImagePath: fuelMeterImagePath ?? this.fuelMeterImagePath,
      vehicleImagePath: vehicleImagePath ?? this.vehicleImagePath,
      receiptImagePaths: receiptImagePaths ?? this.receiptImagePaths,
      odometerReading: odometerReading ?? this.odometerReading,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      paidBy: paidBy ?? this.paidBy,
      fuelQuantityLitres: fuelQuantityLitres ?? this.fuelQuantityLitres,
      fuelPricePerLitre: fuelPricePerLitre ?? this.fuelPricePerLitre,
      description: description ?? this.description,
      notes: notes ?? this.notes,
    );
  }
}

class AddLogFlowNotifier extends StateNotifier<AddLogFlowState> {
  AddLogFlowNotifier() : super(const AddLogFlowState());

  void setLogType(LogType type) => state = state.copyWith(logType: type);

  void setOdometerImage(String path) =>
      state = state.copyWith(odometerImagePath: path);

  void setFuelMeterImage(String path) =>
      state = state.copyWith(fuelMeterImagePath: path);

  void setVehicleImage(String path) =>
      state = state.copyWith(vehicleImagePath: path);

  void addReceiptImage(String path) => state = state.copyWith(
        receiptImagePaths: [...state.receiptImagePaths, path],
      );

  void removeReceiptImage(int index) {
    final updated = List<String>.from(state.receiptImagePaths)..removeAt(index);
    state = state.copyWith(receiptImagePaths: updated);
  }

  void updateDetails({
    int? odometerReading,
    LogCategory? category,
    int? amount,
    PaymentMode? paymentMode,
    PaidBy? paidBy,
    double? fuelQuantityLitres,
    double? fuelPricePerLitre,
    String? description,
    String? notes,
  }) {
    state = state.copyWith(
      odometerReading: odometerReading,
      category: category,
      amount: amount,
      paymentMode: paymentMode,
      paidBy: paidBy,
      fuelQuantityLitres: fuelQuantityLitres,
      fuelPricePerLitre: fuelPricePerLitre,
      description: description,
      notes: notes,
    );
  }

  void reset() => state = const AddLogFlowState();

  /// Cleans up local temp images from disk (call after successful submission).
  void cleanupImages() {
    for (final path in [
      state.odometerImagePath,
      state.fuelMeterImagePath,
      state.vehicleImagePath,
      ...state.receiptImagePaths,
    ]) {
      if (path != null) {
        try {
          File(path).deleteSync();
        } catch (_) {}
      }
    }
  }
}

final addLogFlowProvider =
    StateNotifierProvider<AddLogFlowNotifier, AddLogFlowState>(
  (ref) => AddLogFlowNotifier(),
);

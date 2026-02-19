import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import 'add_log_flow_notifier.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class ReviewSubmitScreen extends ConsumerStatefulWidget {
  const ReviewSubmitScreen({super.key});

  @override
  ConsumerState<ReviewSubmitScreen> createState() => _ReviewSubmitScreenState();
}

class _ReviewSubmitScreenState extends ConsumerState<ReviewSubmitScreen> {
  bool _isSubmitting = false;
  String _statusMessage = '';

  Future<bg.Location?> _getLocation() async {
    try {
      return await bg.BackgroundGeolocation.getCurrentPosition(
        samples: 1,
        persist: false,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        timeout: 30,
        maximumAge: 10000,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _submit() async {
    setState(() {
      _isSubmitting = true;
      _statusMessage = 'Getting location...';
    });

    try {
      final flow = ref.read(addLogFlowProvider);
      final user = ref.read(currentUserProvider);
      final vehicle = ref.read(assignedVehicleProvider);
      final isar = ref.read(isarProvider);

      if (user == null) {
        _showError('User not found. Please log in again.');
        return;
      }

      // Capture GPS — extract to flat non-nullable locals
      final position = await _getLocation();
      final lat = position?.coords.latitude ?? 0.0;
      final lng = position?.coords.longitude ?? 0.0;
      final acc = position?.coords.accuracy ?? 0.0;
      final geo =
          position != null ? Geohash.encode(lat, lng) : '';

      setState(() => _statusMessage = 'Saving log...');

      // Build local log
      final logId = const Uuid().v4();
      final now = DateTime.now();

      final localLog = LocalLog()
        ..localId = logId
        ..companyId = user.companyId ?? ''
        ..driverId = user.userId
        ..vehicleId = vehicle?.vehicleId ?? ''
        ..assignmentId = ''
        ..logType = flow.logType?.name ?? LogType.other.name
        ..category = flow.category.name
        ..amount = flow.amount
        ..currency = AppConstants.defaultCurrency
        ..paymentMode = flow.paymentMode.name
        ..paidBy = flow.paidBy.name
        ..odometerReading = flow.odometerReading
        ..fuelQuantityLitres = flow.fuelQuantityLitres
        ..fuelPricePerLitre = flow.fuelPricePerLitre
        ..description = flow.description
        ..notes = flow.notes
        ..localOdometerImagePath = flow.odometerImagePath?.isNotEmpty == true
            ? flow.odometerImagePath
            : null
        ..localFuelMeterImagePath = flow.fuelMeterImagePath?.isNotEmpty == true
            ? flow.fuelMeterImagePath
            : null
        ..localVehicleImagePath = flow.vehicleImagePath?.isNotEmpty == true
            ? flow.vehicleImagePath
            : null
        ..localReceiptImagePaths = flow.receiptImagePaths
        ..receiptImageUrls = []
        ..latitude = lat
        ..longitude = lng
        ..accuracy = acc
        ..address = ''
        ..geohash = geo
        ..speed = position?.coords.speed ?? 0.0
        ..bearing = position?.coords.heading ?? 0.0
        ..altitude = position?.coords.altitude ?? 0.0
        ..batteryLevel = 0
        ..isCharging = false
        ..networkType = ''
        ..syncStatus = SyncStatus.pending
        ..syncAttempts = 0
        ..isEdited = false
        ..createdAt = now
        ..updatedAt = now;

      // Save to Isar
      await isar.writeTxn(() async {
        await isar.localLogs.put(localLog);
      });

      setState(() => _statusMessage = 'Syncing...');

      // Attempt immediate sync
      try {
        final syncService = ref.read(syncServiceProvider);
        await syncService.syncAll();
      } catch (_) {
        // Sync failed — will retry in background; local save succeeded
      }

      // Cleanup and reset
      ref.read(addLogFlowProvider.notifier).reset();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Log saved successfully'),
            backgroundColor: AppColors.income,
          ),
        );
        context.go('/home');
      }
    } catch (e) {
      _showError('Failed to save log: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    setState(() {
      _isSubmitting = false;
      _statusMessage = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.expense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(addLogFlowProvider);
    final logType = flow.logType ?? LogType.other;
    final isFuel = logType == LogType.fuelFill;
    final isMoneyIn = logType == LogType.paymentReceived ||
        logType == LogType.advance ||
        logType == LogType.loan;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 4 of 4 — Review')),
      body: _isSubmitting
          ? _SubmittingView(message: _statusMessage)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Review & Submit',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 4),
                  const Text(
                    'Confirm all details before submitting.',
                    style: TextStyle(color: AppColors.neutral),
                  ),
                  const SizedBox(height: 24),

                  // Log type banner
                  _TypeBanner(logType: logType),
                  const SizedBox(height: 16),

                  // Photo thumbnails
                  _PhotoRow(flow: flow),
                  const SizedBox(height: 16),

                  // Details card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          if (!isMoneyIn && flow.odometerReading > 0)
                            _DetailRow(
                              label: 'Odometer',
                              value: AppFormatters.formatOdometer(
                                  flow.odometerReading),
                            ),
                          if (isFuel && flow.fuelQuantityLitres > 0) ...[
                            _DetailRow(
                              label: 'Fuel Quantity',
                              value: AppFormatters.formatLitres(
                                  flow.fuelQuantityLitres),
                            ),
                            _DetailRow(
                              label: 'Price/Litre',
                              value:
                                  '₹${flow.fuelPricePerLitre.toStringAsFixed(2)}',
                            ),
                          ],
                          if (logType == LogType.cashExpense) ...[
                            _DetailRow(
                              label: 'Category',
                              value: _categoryLabel(flow.category),
                            ),
                            if (flow.description.isNotEmpty)
                              _DetailRow(
                                label: 'Description',
                                value: flow.description,
                              ),
                          ],
                          _DetailRow(
                            label: 'Amount',
                            value: AppFormatters.formatAmount(flow.amount),
                            valueStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          _DetailRow(
                            label: 'Payment Mode',
                            value: _paymentModeLabel(flow.paymentMode),
                          ),
                          if (!isMoneyIn)
                            _DetailRow(
                              label: 'Paid By',
                              value: flow.paidBy == PaidBy.driver
                                  ? 'Me (Driver)'
                                  : 'Company',
                            ),
                          if (flow.notes.isNotEmpty)
                            _DetailRow(
                              label: 'Notes',
                              value: flow.notes,
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: AppColors.primary, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Location will be captured automatically on submit.',
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.income,
                    ),
                    child: const Text('Submit Log'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  String _categoryLabel(LogCategory c) {
    switch (c) {
      case LogCategory.fuel:
        return 'Fuel';
      case LogCategory.repair:
        return 'Repair';
      case LogCategory.food:
        return 'Food / Allowance';
      case LogCategory.toll:
        return 'Toll / Tax';
      case LogCategory.tyre:
        return 'Tyre';
      case LogCategory.oil:
        return 'Oil / Lubricants';
      case LogCategory.cleaning:
        return 'Cleaning';
      case LogCategory.fine:
        return 'Traffic Fine';
      case LogCategory.other:
        return 'Other';
    }
  }

  String _paymentModeLabel(PaymentMode m) {
    switch (m) {
      case PaymentMode.cash:
        return 'Cash';
      case PaymentMode.upi:
        return 'UPI';
      case PaymentMode.card:
        return 'Card';
      case PaymentMode.fuelCard:
        return 'Fuel Card';
      case PaymentMode.bankTransfer:
        return 'Bank Transfer';
      case PaymentMode.other:
        return 'Other';
    }
  }
}

class _SubmittingView extends StatelessWidget {
  final String message;
  const _SubmittingView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(message,
              style: const TextStyle(color: AppColors.neutral, fontSize: 15)),
        ],
      ),
    );
  }
}

class _TypeBanner extends StatelessWidget {
  final LogType logType;
  const _TypeBanner({required this.logType});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (logType) {
      LogType.fuelFill => ('Fuel Fill', AppColors.fuel, Icons.local_gas_station),
      LogType.cashExpense =>
        ('Cash Expense', AppColors.expense, Icons.receipt_long),
      LogType.paymentReceived =>
        ('Payment Received', AppColors.income, Icons.payments),
      LogType.advance => ('Advance', AppColors.primary, Icons.account_balance_wallet),
      LogType.loan => ('Loan / Credit', AppColors.warning, Icons.handshake_outlined),
      _ => ('Other', AppColors.neutral, Icons.notes),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
        ],
      ),
    );
  }
}

class _PhotoRow extends StatelessWidget {
  final AddLogFlowState flow;
  const _PhotoRow({required this.flow});

  @override
  Widget build(BuildContext context) {
    final paths = <String>[
      if (flow.odometerImagePath?.isNotEmpty == true) flow.odometerImagePath!,
      if (flow.fuelMeterImagePath?.isNotEmpty == true) flow.fuelMeterImagePath!,
      if (flow.vehicleImagePath?.isNotEmpty == true) flow.vehicleImagePath!,
      ...flow.receiptImagePaths,
    ];

    if (paths.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Photos',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: paths.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(paths[i]),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(
                    color: AppColors.neutral, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle ??
                  const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/static_map_thumbnail.dart';

class LogDetailScreen extends ConsumerWidget {
  final String logId;
  const LogDetailScreen({super.key, required this.logId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logAsync = ref.watch(logByIdProvider(logId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Detail'),
        actions: [
          logAsync.whenOrNull(
                data: (log) => log != null
                    ? IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => context.push('/log/$logId/edit'),
                      )
                    : null,
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: logAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (log) => log == null
            ? const Center(child: Text('Log not found'))
            : _LogDetailBody(log: log),
      ),
    );
  }
}

class _LogDetailBody extends StatelessWidget {
  final LogModel log;
  const _LogDetailBody({required this.log});

  @override
  Widget build(BuildContext context) {
    final isExpense =
        log.logType == LogType.cashExpense || log.logType == LogType.fuelFill;
    final isFuel = log.logType == LogType.fuelFill;
    final amountColor = isExpense ? AppColors.expense : AppColors.income;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type banner + amount
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: amountColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_logTypeIcon(log.logType),
                      color: amountColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_logTypeLabel(log.logType),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16)),
                      Text(
                        AppFormatters.formatRelative(log.createdAt),
                        style: const TextStyle(
                            color: AppColors.neutral, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppFormatters.formatAmount(log.amount),
                  style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Photos carousel
          if (_hasPhotos(log)) ...[
            _PhotoCarousel(log: log),
            const SizedBox(height: 16),
          ],

          // Details card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 12),
                  if (log.odometerReading > 0)
                    _DetailRow(
                      icon: Icons.speed,
                      label: 'Odometer',
                      value: AppFormatters.formatOdometer(log.odometerReading),
                    ),
                  if (isFuel && log.fuelQuantityLitres > 0) ...[
                    _DetailRow(
                      icon: Icons.water_drop_outlined,
                      label: 'Fuel Quantity',
                      value: AppFormatters.formatLitres(log.fuelQuantityLitres),
                    ),
                    _DetailRow(
                      icon: Icons.currency_rupee,
                      label: 'Price/Litre',
                      value:
                          '₹${log.fuelPricePerLitre.toStringAsFixed(2)}',
                    ),
                  ],
                  if (log.description.isNotEmpty)
                    _DetailRow(
                      icon: Icons.notes,
                      label: 'Description',
                      value: log.description,
                    ),
                  _DetailRow(
                    icon: Icons.payment,
                    label: 'Payment Mode',
                    value: _paymentModeLabel(log.paymentMode),
                  ),
                  _DetailRow(
                    icon: Icons.person_outline,
                    label: 'Paid By',
                    value: log.paidBy == PaidBy.driver ? 'Driver' : 'Company',
                  ),
                  if (log.notes.isNotEmpty)
                    _DetailRow(
                      icon: Icons.comment_outlined,
                      label: 'Notes',
                      value: log.notes,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Location card (always visible to make map section explicit)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Location',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 12),
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Coordinates',
                    value: (log.location.latitude != 0.0 ||
                            log.location.longitude != 0.0)
                        ? '${log.location.latitude.toStringAsFixed(6)}, ${log.location.longitude.toStringAsFixed(6)}'
                        : 'Not captured',
                  ),
                  _DetailRow(
                    icon: Icons.gps_fixed,
                    label: 'Accuracy',
                    value: log.location.accuracy > 0
                        ? '±${log.location.accuracy.toStringAsFixed(0)}m'
                        : 'N/A',
                  ),
                  const SizedBox(height: 8),
                  StaticMapThumbnail(
                    latitude: log.location.latitude,
                    longitude: log.location.longitude,
                    width: double.infinity,
                    height: 170,
                    borderRadius: 10,
                    zoom: 16,
                    noLocationLabel: 'Location not captured',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Sync status badge
          _SyncStatusBadge(log: log),
          const SizedBox(height: 12),

          // Edit history
          if (log.editHistory.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Edit History',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 8),
                    ...log.editHistory.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.history,
                                  size: 14, color: AppColors.neutral),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${AppFormatters.formatRelative(e.editedAt)} — ${e.reason}',
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.neutral),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  bool _hasPhotos(LogModel log) =>
      (log.odometerImageUrl?.isNotEmpty ?? false) ||
      (log.fuelMeterImageUrl?.isNotEmpty ?? false) ||
      (log.vehicleImageUrl?.isNotEmpty ?? false) ||
      log.receiptImageUrls.isNotEmpty;

  IconData _logTypeIcon(LogType type) {
    switch (type) {
      case LogType.fuelFill:
        return Icons.local_gas_station;
      case LogType.cashExpense:
        return Icons.receipt_long;
      case LogType.paymentReceived:
        return Icons.payments;
      case LogType.advance:
        return Icons.account_balance_wallet;
      case LogType.loan:
        return Icons.handshake_outlined;
      case LogType.other:
        return Icons.notes;
    }
  }

  String _logTypeLabel(LogType type) {
    switch (type) {
      case LogType.fuelFill:
        return 'Fuel Fill';
      case LogType.cashExpense:
        return 'Cash Expense';
      case LogType.paymentReceived:
        return 'Payment Received';
      case LogType.advance:
        return 'Advance';
      case LogType.loan:
        return 'Loan / Credit';
      case LogType.other:
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

class _PhotoCarousel extends StatelessWidget {
  final LogModel log;
  const _PhotoCarousel({required this.log});

  @override
  Widget build(BuildContext context) {
    final urls = <String>[
      if (log.odometerImageUrl?.isNotEmpty ?? false) log.odometerImageUrl!,
      if (log.fuelMeterImageUrl?.isNotEmpty ?? false) log.fuelMeterImageUrl!,
      if (log.vehicleImageUrl?.isNotEmpty ?? false) log.vehicleImageUrl!,
      ...log.receiptImageUrls,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Photos',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: urls.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => _showFullImage(context, urls[i]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  urls[i],
                  width: 180,
                  height: 160,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : Container(
                          width: 180,
                          height: 160,
                          color: AppColors.backgroundLight,
                          child: const Center(
                              child: CircularProgressIndicator()),
                        ),
                  errorBuilder: (_, __, ___) => Container(
                    width: 180,
                    height: 160,
                    color: AppColors.backgroundLight,
                    child: const Icon(Icons.broken_image,
                        color: AppColors.neutral),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFullImage(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.network(url, fit: BoxFit.contain),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.neutral),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    color: AppColors.neutral, fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _SyncStatusBadge extends StatelessWidget {
  final LogModel log;
  const _SyncStatusBadge({required this.log});

  @override
  Widget build(BuildContext context) {
    // Logs fetched from Firestore are always synced
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.income.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_done_outlined,
              color: AppColors.income, size: 16),
          SizedBox(width: 6),
          Text('Synced to cloud',
              style: TextStyle(color: AppColors.income, fontSize: 13)),
        ],
      ),
    );
  }
}

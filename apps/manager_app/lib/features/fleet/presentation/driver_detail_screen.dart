import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/analytics/fleet_analytics.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class DriverDetailScreen extends ConsumerWidget {
  const DriverDetailScreen({super.key, required this.driverId});

  final String driverId;

  bool _isToday(DateTime dt) {
    final now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drivers = ref.watch(companyDriversProvider).valueOrNull ?? [];
    final manager = ref.watch(currentManagerProvider).valueOrNull;
    final companyId = manager?.companyId;
    final activeAssignment = ref.watch(assignmentByDriverProvider)[driverId];
    final driver = drivers.where((d) => d.userId == driverId).firstOrNull;

    if (driver == null) {
      return const Scaffold(body: Center(child: Text('Driver not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(driver.name)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: manager == null || companyId == null
          ? null
          : Builder(
              builder: (context) {
                final isAssigned = activeAssignment != null;

                Future<void> onActionPressed() async {
                  if (activeAssignment == null) {
                    _showAssignVehicleSheet(context, driver);
                    return;
                  }

                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Unassign Vehicle'),
                      content: Text(
                        'Unassign ${driver.name} from vehicle ${activeAssignment.vehicleId}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          child: const Text('Unassign'),
                        ),
                      ],
                    ),
                  );

                  if (confirm != true) return;
                  try {
                    await ref
                        .read(firestoreServiceProvider)
                        .unassignVehicleFromDriver(
                          vehicleId: activeAssignment.vehicleId,
                          assignmentId: activeAssignment.assignmentId,
                        );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${driver.name} unassigned successfully'),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to unassign: $e')),
                    );
                  }
                }

                return FloatingActionButton.extended(
                  onPressed: onActionPressed,
                  shape: const StadiumBorder(),
                  icon: Icon(
                    isAssigned
                        ? Icons.link_off
                        : Icons.assignment_ind_outlined,
                  ),
                  label: Text(isAssigned ? 'Unassign' : 'Assign'),
                );
              },
            ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          ref.read(firestoreServiceProvider).getDriverLogs(
                driverId,
                companyId: companyId,
              ),
          ref.read(firestoreServiceProvider).getDriverPings(
                driverId,
                companyId: companyId,
                startDate: DateTime.now().subtract(const Duration(hours: 1)),
                endDate: DateTime.now(),
              ),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load driver data: ${snapshot.error}'),
            );
          }

          final logs = (snapshot.data?[0] as List<LogModel>?) ?? [];
          final pings = (snapshot.data?[1] as List<LocationPingModel>?) ?? [];
          final todayLogs = logs.where((l) => _isToday(l.createdAt)).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          final balance = FleetAnalytics.driverBalance(logs);
          final owedLabel = balance >= 0
              ? 'Owed ${AppFormatters.formatAmount(balance)}'
              : 'Advance ${AppFormatters.formatAmount(balance.abs())}';
          final owedColor = balance >= 0 ? AppColors.income : AppColors.warning;

          final trail =
              pings.map((p) => LatLng(p.latitude, p.longitude)).toList();
          final lastLoc = driver.lastKnownLocation;
          final hasMapPoint = trail.isNotEmpty || lastLoc != null;
          final mapCenter = trail.isNotEmpty
              ? trail.last
              : (lastLoc != null
                  ? LatLng(lastLoc.latitude, lastLoc.longitude)
                  : null);
          final mapMarkers = hasMapPoint
              ? {
                  Marker(
                    markerId: MarkerId(driver.userId),
                    position: mapCenter!,
                    infoWindow: InfoWindow(title: driver.name),
                  ),
                }
              : <Marker>{};

          final expenseToday = todayLogs
              .where((l) => l.logType == LogType.cashExpense)
              .fold<int>(0, (s, l) => s + l.amount);

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            AppColors.primary.withValues(alpha: 0.12),
                        child: driver.profileImageUrl.isNotEmpty
                            ? ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: driver.profileImageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Text(
                                    driver.name.isNotEmpty
                                        ? driver.name[0].toUpperCase()
                                        : 'D',
                                  ),
                                ),
                              )
                            : Text(
                                driver.name.isNotEmpty
                                    ? driver.name[0].toUpperCase()
                                    : 'D',
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(driver.name,
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            Text(driver.phoneNumber.isEmpty
                                ? driver.userId
                                : driver.phoneNumber),
                            Text(
                                'License: ${driver.licenseNumber.isEmpty ? '-' : driver.licenseNumber}'),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: owedColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          owedLabel,
                          style: TextStyle(
                              color: owedColor, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () => _showRecordPayment(context, ref, driver),
                child: const Text('Record Payment'),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Live Location'),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: !hasMapPoint
                            ? const Center(
                                child: Text('Location not available'))
                            : GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: mapCenter!,
                                  zoom: 14,
                                ),
                                markers: mapMarkers,
                                polylines: trail.isEmpty
                                    ? const <Polyline>{}
                                    : {
                                        Polyline(
                                          polylineId: PolylineId(driver.userId),
                                          points: trail,
                                          color: AppColors.primary,
                                          width: 4,
                                        ),
                                      },
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                              ),
                      ),
                      if (lastLoc != null && trail.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            'Live position is available; trail data not available for the selected range.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral,
                            ),
                          ),
                        ),
                      if (driver.lastKnownLocation != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Last seen ${AppFormatters.formatRelative(driver.lastKnownLocation!.recordedAt)} '
                          '· ${(driver.lastKnownLocation!.speed).toStringAsFixed(1)} km/h',
                        ),
                      ],
                      TextButton(
                        onPressed: () =>
                            context.go('/map?driverId=${driver.userId}'),
                        child: const Text('Open Full Map'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _SummaryChip(label: 'Logs', value: '${todayLogs.length}'),
                  _SummaryChip(
                    label: 'Km',
                    value: '${FleetAnalytics.kmDriven(todayLogs)} km',
                  ),
                  _SummaryChip(
                    label: 'Expenses',
                    value: AppFormatters.formatAmount(expenseToday),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Today Timeline'),
              const SizedBox(height: 8),
              if (todayLogs.isEmpty)
                const Card(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No logs today'))),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todayLogs.length,
                itemBuilder: (context, index) {
                  final log = todayLogs[index];

                  // Proper color coding for each log type
                  Color getLogColor(LogType type) {
                    switch (type) {
                      case LogType.fuelFill:
                        return AppColors.fuel;
                      case LogType.cashExpense:
                        return AppColors.expense;
                      case LogType.paymentReceived:
                        return AppColors.income;
                      case LogType.advance:
                        return AppColors.primary;
                      case LogType.loan:
                        return AppColors.warning;
                      default:
                        return AppColors.neutral;
                    }
                  }

                  final logColor = getLogColor(log.logType);

                  return TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.12,
                    isFirst: index == 0,
                    isLast: index == todayLogs.length - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 36,
                      height: 36,
                      indicator: Container(
                        decoration: BoxDecoration(
                          color: logColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_logTypeIcon(log.logType),
                            color: Colors.white, size: 18),
                      ),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppFormatters.formatDateTime(log.createdAt),
                            style: const TextStyle(color: AppColors.neutral),
                          ),
                          Text(log.description.isEmpty
                              ? log.category.name
                              : log.description),
                          Text(
                            AppFormatters.formatAmount(log.amount),
                            style: TextStyle(
                              color: logColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _FinancialSummary(logs: logs),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => _showRecordPayment(context, ref, driver),
                child: const Text('Record Payment'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showRecordPayment(
      BuildContext context, WidgetRef ref, UserModel driver) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _RecordPaymentSheet(driver: driver),
    );
  }

  void _showAssignVehicleSheet(BuildContext context, UserModel driver) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AssignVehicleSheet(driver: driver),
    );
  }

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
        return Icons.handshake;
      case LogType.other:
        return Icons.notes;
    }
  }

}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(
          alpha: colorScheme.brightness == Brightness.light ? 0.85 : 0.45,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.neutral)),
        ],
      ),
    );
  }
}

class _FinancialSummary extends StatelessWidget {
  const _FinancialSummary({required this.logs});

  final List<LogModel> logs;

  @override
  Widget build(BuildContext context) {
    final expenses = logs
        .where((l) =>
            l.logType == LogType.cashExpense && l.paidBy == PaidBy.driver)
        .fold<int>(0, (s, l) => s + l.amount);
    final payments = logs
        .where((l) =>
            l.logType == LogType.paymentReceived ||
            l.logType == LogType.advance)
        .fold<int>(0, (s, l) => s + l.amount);
    final net = FleetAnalytics.driverBalance(logs);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Financial Summary'),
            const SizedBox(height: 8),
            _ledgerRow('DR (Expenses by Driver)',
                AppFormatters.formatAmount(expenses)),
            _ledgerRow('CR (Payments to Driver)',
                AppFormatters.formatAmount(payments)),
            const Divider(),
            _ledgerRow(
              'Net Balance',
              AppFormatters.formatAmount(net.abs()),
              valueStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: net >= 0 ? AppColors.expense : AppColors.income,
              ),
            ),
            Text(net >= 0 ? 'Company owes driver' : 'Driver has advance'),
          ],
        ),
      ),
    );
  }

  Widget _ledgerRow(String label, String value, {TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

class _RecordPaymentSheet extends ConsumerStatefulWidget {
  const _RecordPaymentSheet({required this.driver});

  final UserModel driver;

  @override
  ConsumerState<_RecordPaymentSheet> createState() =>
      _RecordPaymentSheetState();
}

class _RecordPaymentSheetState extends ConsumerState<_RecordPaymentSheet> {
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  String _mode = 'cash';
  bool _loading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(currentManagerProvider).valueOrNull;
    final companyId = manager?.companyId;
    final assignment =
        ref.watch(assignmentByDriverProvider)[widget.driver.userId];

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Record Payment for ${widget.driver.name}'),
          const SizedBox(height: 10),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount (INR)'),
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            selected: {_mode},
            onSelectionChanged: (value) => setState(() => _mode = value.first),
            segments: const [
              ButtonSegment(value: 'cash', label: Text('Cash')),
              ButtonSegment(value: 'upi', label: Text('UPI')),
              ButtonSegment(
                  value: 'bank_transfer', label: Text('Bank Transfer')),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notes'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _loading ||
                    manager == null ||
                    companyId == null ||
                    assignment == null
                ? null
                : () async {
                    final amountMajor =
                        double.tryParse(_amountController.text.trim());
                    if (amountMajor == null || amountMajor <= 0) return;

                    setState(() => _loading = true);
                    try {
                      await ref
                          .read(firestoreServiceProvider)
                          .managerCreatePayment(
                            driverId: widget.driver.userId,
                            vehicleId: assignment.vehicleId,
                            companyId: companyId,
                            assignmentId: assignment.assignmentId,
                            amount: AppFormatters.currencyToPaise(amountMajor),
                            paymentMode: _mode,
                            notes: _notesController.text.trim(),
                            managerId: manager.userId,
                          );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Payment of ${AppFormatters.formatAmount(AppFormatters.currencyToPaise(amountMajor))} recorded for ${widget.driver.name}',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }
                  },
            child: _loading
                ? const SizedBox(
                    height: 16, width: 16, child: CircularProgressIndicator())
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _AssignVehicleSheet extends ConsumerStatefulWidget {
  const _AssignVehicleSheet({required this.driver});

  final UserModel driver;

  @override
  ConsumerState<_AssignVehicleSheet> createState() => _AssignVehicleSheetState();
}

class _AssignVehicleSheetState extends ConsumerState<_AssignVehicleSheet> {
  String? _vehicleId;
  final _startOdoCtrl = TextEditingController(text: '0');
  bool _submitting = false;

  @override
  void dispose() {
    _startOdoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(currentManagerProvider).valueOrNull;
    final companyId = manager?.companyId;
    final vehicles = ref.watch(companyVehiclesProvider).valueOrNull ?? [];
    final assignmentByVehicle = ref.watch(assignmentByVehicleProvider);

    final unassignedVehicles = vehicles.where((vehicle) {
      final hasActiveAssignment = assignmentByVehicle[vehicle.vehicleId] != null;
      final linkedDriver = vehicle.currentDriverId;
      return !hasActiveAssignment && (linkedDriver == null || linkedDriver.isEmpty);
    }).toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Assign Vehicle to ${widget.driver.name}',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _vehicleId,
            decoration: const InputDecoration(labelText: 'Unassigned vehicle'),
            items: unassignedVehicles
                .map(
                  (vehicle) => DropdownMenuItem(
                    value: vehicle.vehicleId,
                    child: Text(vehicle.registrationNumber),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _vehicleId = value),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _startOdoCtrl,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Start odometer reading'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _submitting ||
                    _vehicleId == null ||
                    companyId == null ||
                    manager == null
                ? null
                : () async {
                    setState(() => _submitting = true);
                    try {
                      await ref
                          .read(firestoreServiceProvider)
                          .assignVehicleToDriver(
                            vehicleId: _vehicleId!,
                            driverId: widget.driver.userId,
                            companyId: companyId,
                            startOdometerReading:
                                int.tryParse(_startOdoCtrl.text) ?? 0,
                            managerId: manager.userId,
                          );
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Vehicle assigned to ${widget.driver.name}',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to assign vehicle: $e')),
                      );
                    } finally {
                      if (mounted) setState(() => _submitting = false);
                    }
                  },
            child: _submitting
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Assign Vehicle'),
          ),
        ],
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

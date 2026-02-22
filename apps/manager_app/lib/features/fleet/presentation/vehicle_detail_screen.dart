import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/analytics/fleet_analytics.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

enum _VehicleMenuAction { unassignDriver, deleteVehicle }

class VehicleDetailScreen extends ConsumerStatefulWidget {
  const VehicleDetailScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  ConsumerState<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends ConsumerState<VehicleDetailScreen> {
  static const int _pageSize = 25;
  int _visibleCount = _pageSize;
  bool _isProcessingAction = false;

  Future<bool> _confirmAction({
    required String title,
    required String message,
    required String confirmText,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: isDestructive
                ? TextButton.styleFrom(foregroundColor: AppColors.expense)
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> _unassignDriver({
    required VehicleModel vehicle,
    required VehicleAssignmentModel assignment,
  }) async {
    final confirmed = await _confirmAction(
      title: 'Unassign Driver',
      message:
          'This will end the current assignment and mark it inactive in history. Continue?',
      confirmText: 'Unassign',
    );
    if (!confirmed || !mounted) return;

    setState(() => _isProcessingAction = true);
    try {
      await ref.read(firestoreServiceProvider).unassignVehicleFromDriver(
            vehicleId: vehicle.vehicleId,
            assignmentId: assignment.assignmentId,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Driver unassigned successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to unassign driver: $e')),
      );
    } finally {
      if (mounted) setState(() => _isProcessingAction = false);
    }
  }

  Future<void> _deleteVehicle({
    required VehicleModel vehicle,
    required String companyId,
    required bool hasActiveAssignment,
  }) async {
    if (hasActiveAssignment) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unassign the current driver before deleting vehicle'),
        ),
      );
      return;
    }

    final confirmed = await _confirmAction(
      title: 'Delete Vehicle',
      message:
          'This removes the vehicle from active fleet views but preserves existing logs and assignment history.',
      confirmText: 'Delete',
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _isProcessingAction = true);
    try {
      await ref.read(firestoreServiceProvider).deleteVehicle(
            vehicleId: vehicle.vehicleId,
            companyId: companyId,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vehicle deleted')),
      );
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete vehicle: $e')),
      );
    } finally {
      if (mounted) setState(() => _isProcessingAction = false);
    }
  }

  Future<void> _handleMenuAction({
    required _VehicleMenuAction action,
    required VehicleModel vehicle,
    required VehicleAssignmentModel? assignment,
    required String? companyId,
  }) async {
    if (_isProcessingAction) return;
    if (companyId == null || companyId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Company context not found')),
      );
      return;
    }

    switch (action) {
      case _VehicleMenuAction.unassignDriver:
        if (assignment == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No active assignment found')),
          );
          return;
        }
        await _unassignDriver(vehicle: vehicle, assignment: assignment);
        return;
      case _VehicleMenuAction.deleteVehicle:
        await _deleteVehicle(
          vehicle: vehicle,
          companyId: companyId,
          hasActiveAssignment: assignment != null,
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final manager = ref.watch(currentManagerProvider).valueOrNull;
    final vehicles = ref.watch(companyVehiclesProvider).valueOrNull ?? [];
    final vehicle = vehicles
        .where((v) => v.vehicleId == widget.vehicleId)
        .firstOrNull;

    if (vehicle == null) {
      return const Scaffold(
        body: Center(child: Text('Vehicle not found')),
      );
    }

    final assignmentByVehicle = ref.watch(assignmentByVehicleProvider);
    final driverById = ref.watch(driverByIdProvider);
    final assignment = assignmentByVehicle[widget.vehicleId];
    final driver = assignment != null ? driverById[assignment.driverId] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.registrationNumber),
        actions: [
          if (_isProcessingAction)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            PopupMenuButton<_VehicleMenuAction>(
              onSelected: (action) => _handleMenuAction(
                action: action,
                vehicle: vehicle,
                assignment: assignment,
                companyId: manager?.companyId,
              ),
              itemBuilder: (_) => [
                PopupMenuItem<_VehicleMenuAction>(
                  value: _VehicleMenuAction.unassignDriver,
                  enabled: assignment != null,
                  child: const Text('Unassign Driver'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<_VehicleMenuAction>(
                  value: _VehicleMenuAction.deleteVehicle,
                  child: Text('Delete Vehicle'),
                ),
              ],
            ),
        ],
      ),
      body: FutureBuilder<List<LogModel>>(
        future: ref.read(firestoreServiceProvider).getVehicleLogs(widget.vehicleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final logs = snapshot.data ?? [];

          final fuelCost = logs
              .where((l) => l.logType == LogType.fuelFill)
              .fold<int>(0, (sum, l) => sum + l.amount);
          final fuelLitres = logs
              .where((l) => l.logType == LogType.fuelFill)
              .fold<double>(0.0, (sum, l) => sum + l.fuelQuantityLitres);
          final monthStart =
              DateTime(DateTime.now().year, DateTime.now().month, 1);
          final thisMonth = logs
              .where((l) => l.createdAt
                  .isAfter(monthStart.subtract(const Duration(seconds: 1))))
              .toList();
          final kmDriven = FleetAnalytics.kmDriven(thisMonth);
          final visible = logs.take(_visibleCount).toList();
          final canLoadMore = logs.length > visible.length;

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                          radius: 28, child: Icon(Icons.directions_car)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vehicle.registrationNumber,
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            Text(
                                '${vehicle.make} ${vehicle.model} • ${vehicle.year}'),
                            Text(
                                'Fuel: ${vehicle.fuelType.name.toUpperCase()}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _StatChip(
                      label: 'Total Spend',
                      value: AppFormatters.formatAmount(
                          FleetAnalytics.totalSpend(logs))),
                  _StatChip(
                      label: 'Fuel Cost',
                      value: AppFormatters.formatAmount(fuelCost)),
                  _StatChip(
                      label: 'Fuel Litres',
                      value: '${fuelLitres.toStringAsFixed(1)} L'),
                  _StatChip(label: 'Km (Month)', value: '$kmDriven km'),
                ],
              ),
              const SizedBox(height: 10),
              if (driver != null)
                Card(
                  child: ListTile(
                    title: const Text('Current Driver'),
                    subtitle: Text(driver.name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () =>
                        context.push('/fleet/drivers/${driver.userId}'),
                  ),
                ),
              const SizedBox(height: 10),
              _FuelEfficiencyChart(logs: logs),
              const SizedBox(height: 10),
              _ExpenseBreakdown(logs: logs),
              const SizedBox(height: 10),
              const Text('Log History'),
              const SizedBox(height: 8),
              ...visible.map(
                (log) => Card(
                  child: ListTile(
                    onTap: () => context.push('/log/${log.logId}'),
                    title: Text(log.logType.name),
                    subtitle: Text(AppFormatters.formatDateTime(log.createdAt)),
                    trailing: Text(AppFormatters.formatAmount(log.amount)),
                  ),
                ),
              ),
              if (canLoadMore)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _visibleCount += _pageSize;
                      });
                    },
                    child: Text('Load More (${logs.length - visible.length} left)'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _FuelEfficiencyChart extends StatelessWidget {
  const _FuelEfficiencyChart({required this.logs});

  final List<LogModel> logs;

  @override
  Widget build(BuildContext context) {
    final fuelLogs = logs
        .where((l) =>
            l.logType == LogType.fuelFill &&
            l.odometerReading > 0 &&
            l.fuelQuantityLitres > 0)
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    if (fuelLogs.length < 2) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Need at least 2 fuel logs to show efficiency'),
        ),
      );
    }

    final spots = <FlSpot>[];
    for (var i = 1; i < fuelLogs.length; i++) {
      final efficiency =
          FleetAnalytics.kmPerLitre(fuelLogs[i - 1], fuelLogs[i]);
      spots.add(FlSpot(i.toDouble(), efficiency));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fuel Efficiency (km/L)'),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      color: AppColors.fuel,
                      barWidth: 2,
                      isCurved: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.fuel.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, _) => Text(v.toStringAsFixed(1)),
                      ),
                    ),
                    bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData:
                      const FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseBreakdown extends StatelessWidget {
  const _ExpenseBreakdown({required this.logs});

  final List<LogModel> logs;

  @override
  Widget build(BuildContext context) {
    final breakdown = FleetAnalytics.expenseByCategory(logs);
    final nonZero = breakdown.entries.where((e) => e.value > 0).toList();

    if (nonZero.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No expenses yet'),
        ),
      );
    }

    Color categoryColor(LogCategory category) {
      switch (category) {
        case LogCategory.fuel:
          return AppColors.fuel;
        case LogCategory.repair:
          return AppColors.expense;
        case LogCategory.food:
          return AppColors.warning;
        case LogCategory.toll:
          return AppColors.primary;
        case LogCategory.tyre:
          return AppColors.income;
        case LogCategory.oil:
          return AppColors.fuel.withValues(alpha: 0.75);
        case LogCategory.cleaning:
          return AppColors.primary.withValues(alpha: 0.75);
        case LogCategory.fine:
          return AppColors.expense.withValues(alpha: 0.75);
        case LogCategory.other:
          return AppColors.neutral;
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Expense Breakdown'),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child: PieChart(
                PieChartData(
                  sections: nonZero
                      .map(
                        (e) => PieChartSectionData(
                          value: e.value.toDouble(),
                          title:
                              '${e.key.name}\n${AppFormatters.formatAmount(e.value)}',
                          color: categoryColor(e.key),
                          radius: 80,
                          titleStyle: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      )
                      .toList(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final secondaryText = Theme.of(context)
        .textTheme
        .bodySmall
        ?.color
        ?.withValues(alpha: 0.8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(
          alpha: colorScheme.brightness == Brightness.light ? 0.85 : 0.45,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: secondaryText ?? AppColors.neutral,
            ),
          ),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

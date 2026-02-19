import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/analytics/fleet_analytics.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class VehicleDetailScreen extends ConsumerWidget {
  const VehicleDetailScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(companyVehiclesProvider).valueOrNull ?? [];
    final vehicle = vehicles.where((v) => v.vehicleId == vehicleId).firstOrNull;

    if (vehicle == null) {
      return const Scaffold(
        body: Center(child: Text('Vehicle not found')),
      );
    }

    final assignmentByVehicle = ref.watch(assignmentByVehicleProvider);
    final driverById = ref.watch(driverByIdProvider);
    final assignment = assignmentByVehicle[vehicleId];
    final driver = assignment != null ? driverById[assignment.driverId] : null;

    return Scaffold(
      appBar: AppBar(title: Text(vehicle.registrationNumber)),
      body: FutureBuilder<List<LogModel>>(
        future: ref.read(firestoreServiceProvider).getVehicleLogs(vehicleId),
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
              ...logs.map(
                (log) => Card(
                  child: ListTile(
                    onTap: () => context.push('/log/${log.logId}'),
                    title: Text(log.logType.name),
                    subtitle: Text(AppFormatters.formatDateTime(log.createdAt)),
                    trailing: Text(AppFormatters.formatAmount(log.amount)),
                  ),
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
          return Colors.redAccent;
        case LogCategory.food:
          return Colors.orange;
        case LogCategory.toll:
          return Colors.indigo;
        case LogCategory.tyre:
          return Colors.teal;
        case LogCategory.oil:
          return Colors.blueGrey;
        case LogCategory.cleaning:
          return Colors.lightBlue;
        case LogCategory.fine:
          return Colors.deepOrange;
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: AppColors.neutral)),
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

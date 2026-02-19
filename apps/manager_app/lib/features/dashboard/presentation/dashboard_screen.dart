import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/analytics/fleet_analytics.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/driver_status.dart';

enum AlertType { driverOffline, highExpense }

class AlertItem {
  AlertItem({
    required this.type,
    this.driverId,
    this.logId,
    required this.message,
  });

  final AlertType type;
  final String? driverId;
  final String? logId;
  final String message;
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<AlertItem> _buildAlerts(
      List<UserModel> drivers, List<LogModel> todayLogs) {
    final alerts = <AlertItem>[];

    for (final driver in drivers) {
      final loc = driver.lastKnownLocation;
      if (loc != null) {
        final age = DateTime.now().difference(loc.recordedAt);
        if (age.inHours >= 2) {
          alerts.add(
            AlertItem(
              type: AlertType.driverOffline,
              driverId: driver.userId,
              message: '${driver.name} offline for ${age.inHours}h',
            ),
          );
        }
      }
    }

    for (final log in todayLogs) {
      if (log.amount > 500000) {
        alerts.add(
          AlertItem(
            type: AlertType.highExpense,
            logId: log.logId,
            message: 'High expense ${AppFormatters.formatAmount(log.amount)}',
          ),
        );
      }
    }

    return alerts;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driversAsync = ref.watch(companyDriversProvider);
    final vehiclesAsync = ref.watch(companyVehiclesProvider);
    final logsAsync = ref.watch(companyLogsProvider(150));
    final assignmentByVehicle = ref.watch(assignmentByVehicleProvider);
    final connectivityAsync = ref.watch(connectivityProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Dashboard'),
              actions: [
                IconButton(
                  onPressed: () => context.push('/settings'),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    connectivityAsync.when(
                      data: (value) {
                        if (value == ConnectivityResult.none) {
                          return Container(
                            color: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.wifi_off,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'You are offline — showing last available data',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 12),
                    driversAsync.when(
                      data: (drivers) {
                        final vehicles =
                            vehiclesAsync.valueOrNull ?? const <VehicleModel>[];
                        final logs =
                            logsAsync.valueOrNull ?? const <LogModel>[];
                        final now = DateTime.now();
                        final activeToday = drivers.where((d) {
                          final loc = d.lastKnownLocation;
                          if (loc == null) return false;
                          return _isSameDay(loc.recordedAt, now);
                        }).length;

                        final todayLogs = logs
                            .where((log) => _isSameDay(log.createdAt, now))
                            .toList();
                        final totalSpendToday =
                            todayLogs.fold<int>(0, (sum, l) => sum + l.amount);

                        final weekStart =
                            now.subtract(Duration(days: now.weekday - 1));
                        final fuelThisWeek = logs.where((l) {
                          return l.logType == LogType.fuelFill &&
                              l.createdAt.isAfter(weekStart
                                  .subtract(const Duration(seconds: 1)));
                        }).toList();
                        final fuelWeekAmount = fuelThisWeek.fold<int>(
                            0, (sum, l) => sum + l.amount);

                        int pendingBalance = 0;
                        for (final driver in drivers) {
                          final driverLogs = logs
                              .where((l) => l.driverId == driver.userId)
                              .toList();
                          final bal = FleetAnalytics.driverBalance(driverLogs);
                          if (bal > 0) pendingBalance += bal;
                        }

                        final markers = <Marker>{};
                        for (final driver in drivers) {
                          final loc = driver.lastKnownLocation;
                          if (loc == null) continue;
                          markers.add(
                            Marker(
                              markerId: MarkerId(driver.userId),
                              position: LatLng(loc.latitude, loc.longitude),
                              infoWindow: InfoWindow(title: driver.name),
                            ),
                          );
                        }

                        final alerts = _buildAlerts(drivers, todayLogs);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _StatusCard(
                                    title: 'Active Today',
                                    value: '$activeToday / ${drivers.length}',
                                    subtitle:
                                        '${drivers.length - activeToday} not started',
                                    icon: Icons.people,
                                    color: activeToday == drivers.length
                                        ? AppColors.income
                                        : Colors.amber,
                                    onTap: () => context.go('/fleet'),
                                  ),
                                  _StatusCard(
                                    title: 'Spend Today',
                                    value: AppFormatters.formatAmount(
                                        totalSpendToday),
                                    subtitle: '${todayLogs.length} logs',
                                    icon: Icons.currency_rupee,
                                    color: AppColors.expense,
                                    onTap: () => context.go('/finance'),
                                  ),
                                  _StatusCard(
                                    title: 'Fuel This Week',
                                    value: AppFormatters.formatAmount(
                                        fuelWeekAmount),
                                    subtitle:
                                        '${fuelThisWeek.length} fuel logs',
                                    icon: Icons.local_gas_station,
                                    color: AppColors.fuel,
                                    onTap: () => context.go('/finance'),
                                  ),
                                  _StatusCard(
                                    title: 'Pending Balance',
                                    value: AppFormatters.formatAmount(
                                        pendingBalance),
                                    subtitle: 'Across all drivers',
                                    icon: Icons.account_balance_wallet,
                                    color: AppColors.warning,
                                    onTap: () => context.go('/finance'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text('Live Fleet Snapshot'),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 220,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    initialCameraPosition: const CameraPosition(
                                      target: LatLng(20.5937, 78.9629),
                                      zoom: 5,
                                    ),
                                    markers: markers,
                                    myLocationEnabled: false,
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                    scrollGesturesEnabled: false,
                                    onTap: (_) => context.go('/map'),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () => context.go('/map'),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          'Full Map ->',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (alerts.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              const Text('Alerts'),
                              const SizedBox(height: 8),
                              ...alerts.map(
                                (a) => Card(
                                  child: ListTile(
                                    onTap: () {
                                      if (a.driverId != null) {
                                        context.push(
                                            '/fleet/drivers/${a.driverId}');
                                        return;
                                      }
                                      if (a.logId != null) {
                                        context.push('/log/${a.logId}');
                                      }
                                    },
                                    leading: Icon(
                                      a.type == AlertType.driverOffline
                                          ? Icons.person_off
                                          : Icons.warning,
                                      color: a.type == AlertType.driverOffline
                                          ? AppColors.warning
                                          : AppColors.expense,
                                    ),
                                    title: Text(a.message),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            const Text('Recent Activity'),
                            const SizedBox(height: 8),
                            ...logs.take(15).map((log) {
                              final driver = drivers
                                  .where((d) => d.userId == log.driverId)
                                  .firstOrNull;
                              final assignment =
                                  assignmentByVehicle[log.vehicleId];
                              final status = statusFromDriver(driver);
                              final statusColor = switch (status) {
                                DriverStatus.active => AppColors.income,
                                DriverStatus.idle => AppColors.warning,
                                DriverStatus.offline => AppColors.neutral,
                              };
                              return Card(
                                child: ListTile(
                                  onTap: () =>
                                      context.push('/log/${log.logId}'),
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        statusColor.withValues(alpha: 0.15),
                                    child: Icon(Icons.directions_car,
                                        color: statusColor),
                                  ),
                                  title: Text(
                                    '${driver?.name ?? 'Unknown'} • ${assignment?.vehicleId ?? log.vehicleId}',
                                  ),
                                  subtitle: Text(
                                    '${log.logType.name} • ${AppFormatters.formatRelative(log.createdAt)}',
                                  ),
                                  trailing: Text(
                                      AppFormatters.formatAmount(log.amount)),
                                ),
                              );
                            }),
                            if (vehicles.isEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                    'No vehicles yet. Add one in Settings.'),
                              ),
                          ],
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Text('Failed to load dashboard: $err'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(title,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const Spacer(),
                Text(value,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.neutral)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

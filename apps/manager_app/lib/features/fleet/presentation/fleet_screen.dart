import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/driver_status.dart';

class FleetScreen extends ConsumerWidget {
  const FleetScreen({super.key});

  static const String _driverPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.fleetfuel360.driver';

  String _inviteText(String code) {
    return 'Join my FleetFuel360 company as a driver.\n'
        'Company Code: $code\n\n'
        'Download FleetFuel360 Drivers:\n'
        '$_driverPlayStoreUrl';
  }

  void _showInviteDriverSheet(BuildContext context, CompanyModel company) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Driver',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Share this company code with your driver:'),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface.withValues(
                        alpha:
                            Theme.of(context).brightness == Brightness.light
                                ? 0.9
                                : 0.45,
                      ),
                ),
                child: Text(
                  company.companyCode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: company.companyCode),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Company code copied')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy Code'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => SharePlus.instance.share(
                        ShareParams(text: _inviteText(company.companyCode)),
                      ),
                      icon: const Icon(Icons.share),
                      label: const Text('Share Invite'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(companyVehiclesProvider);
    final driversMap = ref.watch(driverByIdProvider);
    final assignmentByVehicle = ref.watch(assignmentByVehicleProvider);
    final company = ref.watch(managerCompanyProvider).valueOrNull;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fleet'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Vehicles'),
              Tab(text: 'Drivers'),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            return AnimatedBuilder(
              animation: tabController.animation!,
              builder: (_, __) {
                final isVehiclesTab = tabController.index == 0;
                if (isVehiclesTab) {
                  return FloatingActionButton.extended(
                    onPressed: () => context.push('/settings/add-vehicle'),
                    shape: const StadiumBorder(),
                    icon: const Icon(Icons.add_road),
                    label: const Text('Add Vehicle'),
                  );
                }
                return FloatingActionButton.extended(
                  onPressed: company == null
                      ? null
                      : () => _showInviteDriverSheet(context, company),
                  shape: const StadiumBorder(),
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Add Driver'),
                );
              },
            );
          },
        ),
        body: TabBarView(
          children: [
            vehiclesAsync.when(
              data: (vehicles) {
                if (vehicles.isEmpty) {
                  return const Center(child: Text('No vehicles found'));
                }
                return ListView.builder(
                  itemCount: vehicles.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    final assignment = assignmentByVehicle[vehicle.vehicleId];
                    final driver = assignment != null
                        ? driversMap[assignment.driverId]
                        : null;
                    final status = statusFromDriver(driver);

                    return _ModernVehicleCard(
                      vehicle: vehicle,
                      driver: driver,
                      status: status,
                      onTap: () =>
                          context.push('/fleet/vehicles/${vehicle.vehicleId}'),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) =>
                  Center(child: Text('Failed to load vehicles: $err')),
            ),
            _DriversTab(driversMap: driversMap),
          ],
        ),
      ),
    );
  }
}

class _ModernVehicleCard extends StatelessWidget {
  const _ModernVehicleCard({
    required this.vehicle,
    required this.driver,
    required this.status,
    required this.onTap,
  });

  final VehicleModel vehicle;
  final UserModel? driver;
  final DriverStatus status;
  final VoidCallback onTap;

  String _fuelTypeDisplay(FuelType type) {
    return type.name.toUpperCase();
  }

  String _vehicleTypeDisplay(VehicleType type) {
    return type.name[0].toUpperCase() + type.name.substring(1);
  }

  Color _getStatusColor(DriverStatus status) {
    return switch (status) {
      DriverStatus.active => AppColors.income,
      DriverStatus.idle => AppColors.warning,
      DriverStatus.offline => AppColors.neutral,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Image
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: colorScheme.surface.withValues(
                      alpha: colorScheme.brightness == Brightness.light
                          ? 0.9
                          : 0.5,
                    ),
                  ),
                  child: vehicle.vehicleImageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: vehicle.vehicleImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (_, __, ___) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    size: 48,
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    vehicle.make,
                                    style: const TextStyle(
                                        color: AppColors.neutral),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 48,
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                vehicle.make,
                                style:
                                    const TextStyle(color: AppColors.neutral),
                              ),
                            ],
                          ),
                        ),
                ),
                // Status Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Registration Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        vehicle.registrationNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          vehicle.year.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Make & Model
                  Text(
                    '${vehicle.make} ${vehicle.model}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.neutral,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Badges
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _Badge(
                        label: _fuelTypeDisplay(vehicle.fuelType),
                        icon: Icons.local_gas_station,
                        color: AppColors.fuel,
                      ),
                      _Badge(
                        label: _vehicleTypeDisplay(vehicle.vehicleType),
                        icon: Icons.directions_car,
                        color: AppColors.primary,
                      ),
                      if (vehicle.tankCapacityLitres > 0)
                        _Badge(
                          label:
                              '${vehicle.tankCapacityLitres.toStringAsFixed(0)}L',
                          icon: Icons.water_drop,
                          color: AppColors.income,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Driver Assignment
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(
                        alpha: colorScheme.brightness == Brightness.light
                            ? 0.9
                            : 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: driver != null
                              ? AppColors.primary
                              : AppColors.neutral,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            driver?.name ?? 'Unassigned',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: driver != null
                                  ? colorScheme.onSurface
                                  : AppColors.neutral,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _DriversTab extends ConsumerWidget {
  const _DriversTab({required this.driversMap});

  final Map<String, UserModel> driversMap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drivers = driversMap.values.toList();
    final assignmentByDriver = ref.watch(assignmentByDriverProvider);

    if (drivers.isEmpty) {
      return const Center(child: Text('No drivers found'));
    }

    return ListView.builder(
      itemCount: drivers.length,
      itemBuilder: (context, index) {
        final driver = drivers[index];
        final assignment = assignmentByDriver[driver.userId];
        final status = statusFromDriver(driver);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            onTap: () => context.push('/fleet/drivers/${driver.userId}'),
            leading: CircleAvatar(
              child: Text(
                  driver.name.isNotEmpty ? driver.name[0].toUpperCase() : 'D'),
            ),
            title: Text(driver.name),
            subtitle: Text('Vehicle: ${assignment?.vehicleId ?? 'Unassigned'}'),
            trailing: Text(
              status.name,
              style: TextStyle(
                color: switch (status) {
                  DriverStatus.active => AppColors.income,
                  DriverStatus.idle => AppColors.warning,
                  DriverStatus.offline => AppColors.neutral,
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

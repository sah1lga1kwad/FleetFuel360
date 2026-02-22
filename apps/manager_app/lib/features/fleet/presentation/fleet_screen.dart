import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/driver_status.dart';

class FleetScreen extends ConsumerWidget {
  const FleetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(companyVehiclesProvider);
    final driversMap = ref.watch(driverByIdProvider);
    final assignmentByVehicle = ref.watch(assignmentByVehicleProvider);

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
                      onTap: () => context
                          .push('/fleet/vehicles/${vehicle.vehicleId}'),
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
                    color: AppColors.backgroundLight,
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
                                    color: AppColors.primary.withValues(
                                        alpha: 0.3),
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
                                color:
                                    AppColors.primary.withValues(alpha: 0.3),
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
                      color: AppColors.backgroundLight,
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
                                  ? Colors.black87
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

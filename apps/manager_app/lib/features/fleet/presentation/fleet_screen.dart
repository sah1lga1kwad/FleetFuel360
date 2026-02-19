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
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    final assignment = assignmentByVehicle[vehicle.vehicleId];
                    final driver = assignment != null
                        ? driversMap[assignment.driverId]
                        : null;
                    final status = statusFromDriver(driver);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        onTap: () => context
                            .push('/fleet/vehicles/${vehicle.vehicleId}'),
                        leading: Icon(
                          Icons.directions_car,
                          color: switch (status) {
                            DriverStatus.active => AppColors.income,
                            DriverStatus.idle => AppColors.warning,
                            DriverStatus.offline => AppColors.neutral,
                          },
                        ),
                        title: Text(vehicle.registrationNumber),
                        subtitle: Text(
                          assignment != null
                              ? (driversMap[assignment.driverId]?.name ??
                                  'Unknown')
                              : 'Unassigned',
                        ),
                        trailing: Text(status.name),
                      ),
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

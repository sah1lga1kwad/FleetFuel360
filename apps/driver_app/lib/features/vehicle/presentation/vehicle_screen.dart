import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class VehicleScreen extends ConsumerWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(assignedVehicleProvider);
    final assignmentsAsync = ref.watch(allAssignmentsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Vehicle')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current vehicle card
            vehicle == null
                ? _NoVehicleCard()
                : _VehicleDetailCard(vehicle: vehicle),
            const SizedBox(height: 24),

            // Assignment history
            Text('Assignment History',
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 12),
            assignmentsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (assignments) => assignments.isEmpty
                  ? _EmptyAssignments()
                  : Column(
                      children: assignments
                          .map((a) => _AssignmentTile(assignment: a))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoVehicleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.neutral.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.directions_car_outlined,
                  color: AppColors.neutral, size: 40),
            ),
            const SizedBox(height: 16),
            const Text('No Vehicle Assigned',
                style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            const Text(
              'Contact your fleet manager to get a vehicle assigned.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.neutral, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _VehicleDetailCard extends StatelessWidget {
  final VehicleModel vehicle;
  const _VehicleDetailCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: vehicle.vehicleImageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: vehicle.vehicleImageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Registration + status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        vehicle.registrationNumber,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.income.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Active',
                          style: TextStyle(
                              color: AppColors.income,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${vehicle.make} ${vehicle.model} · ${vehicle.year}',
                  style: const TextStyle(
                      color: AppColors.neutral, fontSize: 15),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),

                // Details grid
                Row(
                  children: [
                    Expanded(
                      child: _InfoTile(
                        label: 'Fuel Type',
                        value: vehicle.fuelType.name.toUpperCase(),
                        icon: Icons.local_gas_station,
                        color: AppColors.fuel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoTile(
                        label: 'Vehicle Type',
                        value: _vehicleTypeLabel(vehicle.vehicleType),
                        icon: Icons.directions_car,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (vehicle.tankCapacityLitres > 0)
                  _DetailRow(
                    label: 'Tank Capacity',
                    value: '${vehicle.tankCapacityLitres.toStringAsFixed(1)} L',
                  ),
                if (vehicle.currentDriverId?.isNotEmpty == true)
                  _DetailRow(
                    label: 'Driver ID',
                    value: vehicle.currentDriverId!,
                  ),
                if (vehicle.currentAssignmentId?.isNotEmpty == true)
                  _DetailRow(
                    label: 'Assignment ID',
                    value: vehicle.currentAssignmentId!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
        width: double.infinity,
        height: 180,
        color: AppColors.backgroundLight,
        child: const Icon(Icons.directions_car,
            size: 64, color: AppColors.neutral),
      );

  String _vehicleTypeLabel(VehicleType t) {
    switch (t) {
      case VehicleType.truck:
        return 'Truck';
      case VehicleType.van:
        return 'Van';
      case VehicleType.car:
        return 'Car';
      case VehicleType.bike:
        return 'Bike';
      case VehicleType.other:
        return 'Other';
    }
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  color: AppColors.neutral, fontSize: 11)),
          Text(value,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 13)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
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

class _AssignmentTile extends StatelessWidget {
  final VehicleAssignmentModel assignment;
  const _AssignmentTile({required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: assignment.isActive
                  ? AppColors.income.withValues(alpha: 0.1)
                  : AppColors.neutral.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.directions_car,
              color: assignment.isActive
                  ? AppColors.income
                  : AppColors.neutral,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppFormatters.formatDate(assignment.startDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
                Text(
                  assignment.isActive
                      ? 'Currently active'
                      : assignment.endDate != null
                          ? 'Until ${AppFormatters.formatDate(assignment.endDate!)}'
                          : 'Ended',
                  style: const TextStyle(
                      color: AppColors.neutral, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: assignment.isActive
                  ? AppColors.income.withValues(alpha: 0.1)
                  : AppColors.neutral.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              assignment.isActive ? 'Active' : 'Ended',
              style: TextStyle(
                color: assignment.isActive
                    ? AppColors.income
                    : AppColors.neutral,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyAssignments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text('No assignment history',
            style: TextStyle(color: AppColors.neutral)),
      ),
    );
  }
}

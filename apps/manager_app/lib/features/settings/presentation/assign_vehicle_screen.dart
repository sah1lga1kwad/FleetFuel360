import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';

class AssignVehicleScreen extends ConsumerStatefulWidget {
  const AssignVehicleScreen({super.key});

  @override
  ConsumerState<AssignVehicleScreen> createState() =>
      _AssignVehicleScreenState();
}

class _AssignVehicleScreenState extends ConsumerState<AssignVehicleScreen> {
  String? _vehicleId;
  String? _driverId;
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
    final vehicles = ref.watch(companyVehiclesProvider).valueOrNull ?? [];
    final drivers = ref.watch(companyDriversProvider).valueOrNull ?? [];
    final assignments = ref.watch(activeAssignmentsProvider).valueOrNull ?? [];

    final assignedDriverIds = assignments.map((a) => a.driverId).toSet();
    final unassignedVehicles =
        vehicles.where((v) => v.currentDriverId == null).toList();
    final availableDrivers =
        drivers.where((d) => !assignedDriverIds.contains(d.userId)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Assign Vehicle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _vehicleId,
            decoration: const InputDecoration(labelText: 'Unassigned vehicle'),
            items: unassignedVehicles
                .map((v) => DropdownMenuItem(
                    value: v.vehicleId, child: Text(v.registrationNumber)))
                .toList(),
            onChanged: (value) => setState(() => _vehicleId = value),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _driverId,
            decoration: const InputDecoration(labelText: 'Available driver'),
            items: availableDrivers
                .map((d) =>
                    DropdownMenuItem(value: d.userId, child: Text(d.name)))
                .toList(),
            onChanged: (value) => setState(() => _driverId = value),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _startOdoCtrl,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Start odometer reading'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _submitting ||
                    _vehicleId == null ||
                    _driverId == null ||
                    manager?.companyId == null
                ? null
                : () async {
                    setState(() => _submitting = true);
                    try {
                      await ref
                          .read(firestoreServiceProvider)
                          .assignVehicleToDriver(
                            vehicleId: _vehicleId!,
                            driverId: _driverId!,
                            companyId: manager!.companyId!,
                            startOdometerReading:
                                int.tryParse(_startOdoCtrl.text) ?? 0,
                            managerId: manager.userId,
                          );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Vehicle assigned successfully')),
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to assign vehicle: $e')),
                        );
                      }
                    } finally {
                      if (mounted) setState(() => _submitting = false);
                    }
                  },
            child: _submitting
                ? const SizedBox(
                    height: 18, width: 18, child: CircularProgressIndicator())
                : const Text('Assign Vehicle'),
          ),
        ],
      ),
    );
  }
}

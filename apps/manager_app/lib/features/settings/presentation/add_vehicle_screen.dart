import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';

class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  ConsumerState<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _regCtrl = TextEditingController();
  final _makeCtrl = TextEditingController();
  final _modelCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _capacityCtrl = TextEditingController();
  FuelType _fuelType = FuelType.diesel;
  VehicleType _vehicleType = VehicleType.truck;
  String? _imagePath;
  bool _submitting = false;

  @override
  void dispose() {
    _regCtrl.dispose();
    _makeCtrl.dispose();
    _modelCtrl.dispose();
    _yearCtrl.dispose();
    _capacityCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      setState(() => _imagePath = image.path);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final company = ref.read(managerCompanyProvider).valueOrNull;
    if (company == null) return;

    setState(() => _submitting = true);
    try {
      final firestore = ref.read(firestoreServiceProvider);
      final storage = ref.read(storageServiceProvider);
      final vehicleData = <String, dynamic>{
        'registrationNumber': _regCtrl.text.trim().toUpperCase(),
        'make': _makeCtrl.text.trim(),
        'model': _modelCtrl.text.trim(),
        'year': int.tryParse(_yearCtrl.text.trim()) ?? DateTime.now().year,
        'fuelType': _fuelType.name,
        'vehicleType': _vehicleType.name,
        'tankCapacityLitres': double.tryParse(_capacityCtrl.text.trim()) ?? 0,
        'vehicleImageUrl': '',
      };

      final vehicleId =
          await firestore.addVehicle(vehicleData, company.companyId);

      if (_imagePath != null) {
        final url = await storage.uploadImage(
          _imagePath!,
          'companies/${company.companyId}/vehicles/$vehicleId/main.jpg',
        );
        await FirebaseFirestore.instance
            .collection('vehicles')
            .doc(vehicleId)
            .update({
          'vehicleImageUrl': url,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vehicle added successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add vehicle: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Vehicle')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _regCtrl,
              decoration:
                  const InputDecoration(labelText: 'Registration number'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _makeCtrl,
              decoration: const InputDecoration(labelText: 'Make'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _modelCtrl,
              decoration: const InputDecoration(labelText: 'Model'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _yearCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Year'),
              validator: (v) => v == null || int.tryParse(v) == null
                  ? 'Enter valid year'
                  : null,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<FuelType>(
              initialValue: _fuelType,
              decoration: const InputDecoration(labelText: 'Fuel type'),
              items: FuelType.values
                  .map((f) => DropdownMenuItem(
                      value: f, child: Text(f.name.toUpperCase())))
                  .toList(),
              onChanged: (v) =>
                  setState(() => _fuelType = v ?? FuelType.diesel),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<VehicleType>(
              initialValue: _vehicleType,
              decoration: const InputDecoration(labelText: 'Vehicle type'),
              items: VehicleType.values
                  .map((v) => DropdownMenuItem(
                      value: v, child: Text(v.name.toUpperCase())))
                  .toList(),
              onChanged: (v) =>
                  setState(() => _vehicleType = v ?? VehicleType.truck),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _capacityCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration:
                  const InputDecoration(labelText: 'Tank capacity (litres)'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_camera),
              label: const Text('Pick vehicle photo'),
            ),
            if (_imagePath != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(File(_imagePath!),
                    height: 180, fit: BoxFit.cover),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      height: 18, width: 18, child: CircularProgressIndicator())
                  : const Text('Add Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}

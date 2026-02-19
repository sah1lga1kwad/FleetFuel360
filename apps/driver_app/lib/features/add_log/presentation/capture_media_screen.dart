import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import 'add_log_flow_notifier.dart';
import '../../../core/theme/app_theme.dart';

class CaptureMediaScreen extends ConsumerStatefulWidget {
  const CaptureMediaScreen({super.key});

  @override
  ConsumerState<CaptureMediaScreen> createState() => _CaptureMediaScreenState();
}

class _CaptureMediaScreenState extends ConsumerState<CaptureMediaScreen> {
  final _picker = ImagePicker();
  bool _isProcessing = false;

  Future<String?> _captureAndCompress(ImageSource source) async {
    setState(() => _isProcessing = true);
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1024,
      );
      if (picked == null) return null;

      final dir = await getTemporaryDirectory();
      final targetPath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final compressed = await FlutterImageCompress.compressAndGetFile(
        picked.path,
        targetPath,
        quality: 80,
        minWidth: 800,
      );

      return compressed?.path ?? picked.path;
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(addLogFlowProvider);
    final logType = flow.logType ?? LogType.other;
    final notifier = ref.read(addLogFlowProvider.notifier);

    final showFuelMeter = logType == LogType.fuelFill;
    final showReceipts = logType == LogType.cashExpense ||
        logType == LogType.paymentReceived;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 2 of 4 — Evidence'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Capture Evidence',
                style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 4),
            const Text(
              'Photos are proof. Take them clearly.',
              style: TextStyle(color: AppColors.neutral),
            ),
            const SizedBox(height: 24),

            // Odometer
            _MediaSection(
              title: 'Odometer Photo',
              subtitle: 'Required for all log types',
              isRequired: true,
              currentPath: flow.odometerImagePath,
              onCamera: () async {
                final path = await _captureAndCompress(ImageSource.camera);
                if (path != null) notifier.setOdometerImage(path);
              },
              onGallery: () async {
                final path = await _captureAndCompress(ImageSource.gallery);
                if (path != null) notifier.setOdometerImage(path);
              },
              onRemove: () => notifier.setOdometerImage(''),
            ),

            // Fuel Meter (fuel logs only)
            if (showFuelMeter) ...[
              const SizedBox(height: 16),
              _MediaSection(
                title: 'Fuel Meter / Pump Receipt',
                subtitle: 'Shows quantity dispensed',
                isRequired: false,
                currentPath: flow.fuelMeterImagePath,
                onCamera: () async {
                  final path = await _captureAndCompress(ImageSource.camera);
                  if (path != null) notifier.setFuelMeterImage(path);
                },
                onGallery: () async {
                  final path = await _captureAndCompress(ImageSource.gallery);
                  if (path != null) notifier.setFuelMeterImage(path);
                },
                onRemove: () => notifier.setFuelMeterImage(''),
              ),
            ],

            // Receipts (expense / payment)
            if (showReceipts) ...[
              const SizedBox(height: 16),
              _ReceiptsSection(
                paths: flow.receiptImagePaths,
                onAdd: () async {
                  final path = await _captureAndCompress(ImageSource.camera);
                  if (path != null) notifier.addReceiptImage(path);
                },
                onAddGallery: () async {
                  final path = await _captureAndCompress(ImageSource.gallery);
                  if (path != null) notifier.addReceiptImage(path);
                },
                onRemove: (i) => notifier.removeReceiptImage(i),
              ),
            ],

            // Vehicle Photo (optional, all types)
            const SizedBox(height: 16),
            _MediaSection(
              title: 'Vehicle Photo (Optional)',
              subtitle: 'Front view of vehicle at location',
              isRequired: false,
              currentPath: flow.vehicleImagePath,
              onCamera: () async {
                final path = await _captureAndCompress(ImageSource.camera);
                if (path != null) notifier.setVehicleImage(path);
              },
              onGallery: () async {
                final path = await _captureAndCompress(ImageSource.gallery);
                if (path != null) notifier.setVehicleImage(path);
              },
              onRemove: () => notifier.setVehicleImage(''),
            ),

            const SizedBox(height: 32),
            if (_isProcessing)
              const Center(child: CircularProgressIndicator()),
            if (!_isProcessing)
              ElevatedButton(
                onPressed: () => context.push('/log/add/details'),
                child: const Text('Next: Fill Details'),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MediaSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isRequired;
  final String? currentPath;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onRemove;

  const _MediaSection({
    required this.title,
    required this.subtitle,
    required this.isRequired,
    required this.currentPath,
    required this.onCamera,
    required this.onGallery,
    required this.onRemove,
  });

  bool get _hasImage => currentPath != null && currentPath!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const Text('*',
                  style: TextStyle(color: AppColors.expense, fontSize: 16)),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(subtitle,
            style: const TextStyle(color: AppColors.neutral, fontSize: 12)),
        const SizedBox(height: 8),
        if (_hasImage)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(currentPath!),
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              _CaptureButton(
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: onCamera,
              ),
              const SizedBox(width: 8),
              _CaptureButton(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: onGallery,
              ),
            ],
          ),
      ],
    );
  }
}

class _ReceiptsSection extends StatelessWidget {
  final List<String> paths;
  final VoidCallback onAdd;
  final VoidCallback onAddGallery;
  final void Function(int) onRemove;

  const _ReceiptsSection({
    required this.paths,
    required this.onAdd,
    required this.onAddGallery,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Receipt Photo(s)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...paths.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(e.value),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => onRemove(e.key),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    color: Colors.white, size: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              _CaptureButton(
                icon: Icons.add_a_photo,
                label: 'Add',
                onTap: onAdd,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CaptureButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    color: AppColors.primary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

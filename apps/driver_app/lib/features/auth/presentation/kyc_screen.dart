import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class KYCScreen extends ConsumerStatefulWidget {
  const KYCScreen({super.key});

  @override
  ConsumerState<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends ConsumerState<KYCScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseController = TextEditingController();
  String? _licenseImagePath;
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _pickLicenseImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (image != null) setState(() => _licenseImagePath = image.path);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_licenseImagePath == null) {
      setState(() => _error = 'Please capture your license photo');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final firebaseUser = FirebaseAuth.instance.currentUser!;
      await firebaseUser.getIdToken(true);
      final storageService = ref.read(storageServiceProvider);
      final firestoreService = ref.read(firestoreServiceProvider);

      // Upload license image
      final storagePath = StorageService.userImagePath(
        'unassigned', // companyId not yet known
        firebaseUser.uid,
        'license',
      );
      final licenseUrl =
          await storageService.uploadImage(_licenseImagePath!, storagePath);

      // Create user document
      final now = DateTime.now();
      final user = UserModel(
        userId: firebaseUser.uid,
        name: _nameController.text.trim(),
        email: firebaseUser.email ?? '',
        phoneNumber: _phoneController.text.trim(),
        licenseNumber: _licenseController.text.trim(),
        licenseImageUrl: licenseUrl,
        kycCompleted: true,
        role: 'driver',
        createdAt: now,
        updatedAt: now,
      );

      await firestoreService.createUser(user);
      // GoRouter redirect handles navigation
    } on FirebaseException catch (e) {
      final isStoragePermissionError =
          e.plugin == 'firebase_storage' && e.code == 'unauthorized';
      setState(() {
        _error = isStoragePermissionError
            ? 'Upload blocked by Firebase Storage permissions/App Check. Please contact support.'
            : 'Submission failed. Please try again.';
        _isSubmitting = false;
      });
    } catch (_) {
      setState(() {
        _error = 'Submission failed. Please try again.';
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before you can log expenses, we need a few details.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.neutral,
                    ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) => AppValidators.required(v, field: 'Full name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (becomes your Driver ID)',
                  prefixIcon: Icon(Icons.phone_outlined),
                  prefixText: '+91 ',
                ),
                keyboardType: TextInputType.phone,
                validator: AppValidators.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _licenseController,
                decoration: const InputDecoration(
                  labelText: 'Driving License Number',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                textCapitalization: TextCapitalization.characters,
                validator: AppValidators.licenseNumber,
              ),
              const SizedBox(height: 24),
              Text(
                'License Photo',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickLicenseImage,
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _licenseImagePath != null
                          ? AppColors.income
                          : const Color(0xFFE0E0E0),
                      width: 2,
                    ),
                  ),
                  child: _licenseImagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(_licenseImagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.check_circle,
                              color: AppColors.income,
                              size: 48,
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt_outlined,
                                size: 40, color: AppColors.neutral),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to capture license photo',
                              style: TextStyle(color: AppColors.neutral),
                            ),
                          ],
                        ),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(_error!,
                    style: const TextStyle(color: AppColors.expense)),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

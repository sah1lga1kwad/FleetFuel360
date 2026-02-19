import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class CompanySetupScreen extends ConsumerStatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  ConsumerState<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

class _CompanySetupScreenState extends ConsumerState<CompanySetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _industry = 'Logistics';

  bool _isSubmitting = false;
  String? _error;
  String? _companyCode;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String _generateCompanyCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random.secure();
    return List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      setState(() => _error = 'Please log in again.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      final now = DateTime.now();
      final companyId =
          FirebaseFirestore.instance.collection('companies').doc().id;
      final code = _generateCompanyCode();

      final company = CompanyModel(
        companyId: companyId,
        name: _nameController.text.trim(),
        companyCode: code,
        managerId: firebaseUser.uid,
        createdAt: now,
        updatedAt: now,
      );
      await firestoreService.createCompany(company);

      final existing = await firestoreService.getUser(firebaseUser.uid);
      if (existing == null) {
        final user = UserModel(
          userId: firebaseUser.uid,
          name: firebaseUser.displayName?.trim().isNotEmpty == true
              ? firebaseUser.displayName!.trim()
              : 'Manager',
          email: firebaseUser.email ?? '',
          phoneNumber: _phoneController.text.trim(),
          role: 'manager',
          companyId: companyId,
          companyCode: code,
          createdAt: now,
          updatedAt: now,
        );
        await firestoreService.createUser(user);
      } else {
        await firestoreService.updateUser(firebaseUser.uid, {
          'name': existing.name.isEmpty
              ? (firebaseUser.displayName ?? 'Manager')
              : existing.name,
          'email': existing.email.isEmpty
              ? (firebaseUser.email ?? '')
              : existing.email,
          'phoneNumber': _phoneController.text.trim(),
          'role': 'manager',
          'companyId': companyId,
          'companyCode': code,
          'industry': _industry,
        });
      }

      setState(() {
        _companyCode = code;
        _isSubmitting = false;
      });
    } catch (_) {
      setState(() {
        _isSubmitting = false;
        _error = 'Failed to create company. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_companyCode != null) {
      return _SuccessState(companyCode: _companyCode!);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Company')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Company name',
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Company name is required'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _industry,
                decoration: const InputDecoration(
                  labelText: 'Industry',
                  prefixIcon: Icon(Icons.apartment),
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'Logistics', child: Text('Logistics')),
                  DropdownMenuItem(
                      value: 'Food Delivery', child: Text('Food Delivery')),
                  DropdownMenuItem(
                      value: 'Construction', child: Text('Construction')),
                  DropdownMenuItem(value: 'Taxi', child: Text('Taxi')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) =>
                    setState(() => _industry = value ?? 'Logistics'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Manager phone number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Phone number is required'
                    : null,
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: AppColors.expense)),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create Company'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.companyCode});

  final String companyCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Setup')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company Created!',
                style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 8),
            const Text('Share this code with your drivers:'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      companyCode,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 6,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () =>
                        Clipboard.setData(ClipboardData(text: companyCode)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => SharePlus.instance.share(
                      ShareParams(text: 'Join my fleet: $companyCode'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

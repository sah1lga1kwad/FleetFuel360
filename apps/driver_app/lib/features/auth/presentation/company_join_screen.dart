import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class CompanyJoinScreen extends ConsumerStatefulWidget {
  const CompanyJoinScreen({super.key});

  @override
  ConsumerState<CompanyJoinScreen> createState() => _CompanyJoinScreenState();
}

class _CompanyJoinScreenState extends ConsumerState<CompanyJoinScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _joinCompany() async {
    final code = _codeController.text.trim().toUpperCase();
    final error = AppValidators.companyCode(code);
    if (error != null) {
      setState(() => _error = error);
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) throw Exception('Not logged in');

      final company = await firestoreService.getCompanyByCode(code);
      if (company == null) {
        setState(() {
          _error = 'Invalid company code. Please check and try again.';
          _isLoading = false;
        });
        return;
      }

      // Add driver to company
      await firestoreService.addDriverToCompany(
          company.companyId, currentUser.userId);

      // Update user doc with companyId + companyCode
      await firestoreService.updateUser(currentUser.userId, {
        'companyId': company.companyId,
        'companyCode': code,
      });

      // GoRouter redirect handles navigation to Home
    } catch (e) {
      setState(() {
        _error = 'Failed to join company. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _confirmSignOut() async {
    final authService = ref.read(authServiceProvider);
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text(
          'You can sign back in anytime with another account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: AppColors.expense),
            ),
          ),
        ],
      ),
    );

    if (shouldSignOut != true) return;
    await authService.signOut();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Your Company'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.business, color: AppColors.primary, size: 36),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Ask your fleet manager for the 6-character company code.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Company Code',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: 'e.g. ABC123',
                prefixIcon: const Icon(Icons.vpn_key_outlined),
                errorText: _error,
              ),
              textCapitalization: TextCapitalization.characters,
              maxLength: 6,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
              onChanged: (v) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : _joinCompany,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Join Company'),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: _isLoading ? null : _confirmSignOut,
                child: const Text('Use a different account'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/di/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String _driverPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.fleetfuel360.driver';

  String _inviteText(String code) {
    return 'Join my FleetFuel360 company as a driver.\n'
        'Company Code: $code\n\n'
        'Download FleetFuel360 Drivers:\n'
        '$_driverPlayStoreUrl';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(currentManagerProvider).valueOrNull;
    final company = ref.watch(managerCompanyProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.business),
              title: Text(company?.name ?? 'Company'),
              subtitle: Text('Manager: ${manager?.name ?? '-'}'),
            ),
          ),
          if (company != null)
            Card(
              child: ListTile(
                leading: const Icon(Icons.key),
                title: Text('Company Code: ${company.companyCode}'),
                subtitle:
                    const Text('Share this with drivers to join your fleet'),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      onPressed: () => Clipboard.setData(
                        ClipboardData(text: company.companyCode),
                      ),
                      icon: const Icon(Icons.copy),
                    ),
                    IconButton(
                      onPressed: () => SharePlus.instance.share(
                        ShareParams(text: _inviteText(company.companyCode)),
                      ),
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
              ),
            ),
          if (company != null)
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_add_alt_1),
                title: const Text('Invite Driver'),
                subtitle: const Text(
                  'Share company code and Play Store install link',
                ),
                trailing: IconButton(
                  onPressed: () => SharePlus.instance.share(
                    ShareParams(text: _inviteText(company.companyCode)),
                  ),
                  icon: const Icon(Icons.share),
                ),
                onTap: () => SharePlus.instance.share(
                  ShareParams(text: _inviteText(company.companyCode)),
                ),
              ),
            ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.add_road),
              title: const Text('Add Vehicle'),
              onTap: () => context.push('/settings/add-vehicle'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Assign Vehicle to Driver'),
              onTap: () => context.push('/settings/assign-vehicle'),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title:
                  const Text('Sign Out', style: TextStyle(color: Colors.red)),
              onTap: () => _showSignOutDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

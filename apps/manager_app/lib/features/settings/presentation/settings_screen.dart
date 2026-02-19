import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/di/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

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
                        ShareParams(
                            text: 'Join my fleet: ${company.companyCode}'),
                      ),
                      icon: const Icon(Icons.share),
                    ),
                  ],
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
        ],
      ),
    );
  }
}

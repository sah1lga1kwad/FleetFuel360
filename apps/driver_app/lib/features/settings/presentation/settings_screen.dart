import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../tracking/background_location_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final vehicle = ref.watch(assignedVehicleProvider);
    final authService = ref.read(authServiceProvider);
    final permissionStatus =
        ref.watch(trackingPermissionStatusProvider).valueOrNull;
    final trackingEnabled = ref.watch(trackingEnabledProvider);
    final trackingDiagnosticsAsync = ref.watch(trackingDiagnosticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile card
          _ProfileCard(user: user),
          const SizedBox(height: 20),

          // Vehicle info
          _SectionHeader(title: 'Vehicle'),
          _VehicleTile(vehicle: vehicle),
          const SizedBox(height: 20),

          // App settings
          _SectionHeader(title: 'App'),
          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Theme',
            subtitle: 'System default',
            onTap: () {}, // Phase 2
          ),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: permissionStatus == null
                ? 'Checking status...'
                : (permissionStatus.notificationRequired
                    ? (permissionStatus.notificationGranted
                        ? 'Granted'
                        : 'Required for tracking alerts')
                    : 'Not required on this Android version'),
            onTap: null,
          ),
          _SettingsTile(
            icon: Icons.location_on_outlined,
            title: 'Location Tracking',
            subtitle: permissionStatus == null
                ? 'Checking status...'
                : (permissionStatus.allGranted
                    ? 'Background tracking active'
                    : 'Permission required'),
            trailing: Switch(
              value: trackingEnabled,
              onChanged: (value) => ref
                  .read(trackingEnabledAsyncProvider.notifier)
                  .setEnabled(value),
            ),
            onTap: null,
          ),
          _SettingsTile(
            icon: Icons.battery_saver_outlined,
            title: 'Battery Optimization',
            subtitle: permissionStatus == null
                ? 'Checking status...'
                : (permissionStatus.batteryOptimizationIgnored
                    ? 'Ignored for stable tracking'
                    : 'Can pause tracking in background'),
            onTap: () async {
              await Permission.ignoreBatteryOptimizations.request();
              ref.invalidate(trackingPermissionStatusProvider);
            },
          ),
          const SizedBox(height: 12),
          _PermissionHealthCard(status: permissionStatus),
          const SizedBox(height: 12),
          _TrackingDiagnosticsCard(
            diagnosticsAsync: trackingDiagnosticsAsync,
            onRefresh: () async {
              ref.invalidate(trackingDiagnosticsProvider);
            },
            onForceSync: () async {
              try {
                await ref
                    .read(syncServiceProvider)
                    .syncAll()
                    .timeout(const Duration(seconds: 15));
                ref.invalidate(trackingDiagnosticsProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sync triggered')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sync failed: $e')),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 20),

          // Account
          _SectionHeader(title: 'Account'),
          _SettingsTile(
            icon: Icons.swap_horiz_outlined,
            title: 'Change Company',
            subtitle: user?.companyCode.isNotEmpty == true
                ? 'Current code: ${user!.companyCode}'
                : 'Leave current company and join another',
            onTap: user == null
                ? null
                : () => _confirmChangeCompany(context, ref, user),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.info_outlined,
            title: 'App Version',
            subtitle: '1.0.0',
            onTap: null,
          ),
          const SizedBox(height: 8),

          // Sign out
          OutlinedButton.icon(
            onPressed: () => _confirmSignOut(context, authService, ref),
            icon: const Icon(Icons.logout, color: AppColors.expense),
            label: const Text('Sign Out',
                style: TextStyle(color: AppColors.expense)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.expense),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _confirmSignOut(
      BuildContext context, AuthService authService, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await authService.signOut();
              if (context.mounted) context.go('/login');
            },
            child: const Text('Sign Out',
                style: TextStyle(color: AppColors.expense)),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmChangeCompany(
    BuildContext context,
    WidgetRef ref,
    UserModel user,
  ) async {
    final shouldChange = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Change Company'),
        content: const Text(
          'This will remove you from your current company, stop tracking, and clear local offline logs/pings from this company on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Continue',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );

    if (shouldChange != true) return;

    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      final isar = ref.read(isarProvider);

      await resetTrackingStateForCompanySwitch();
      await isar.writeTxn(() async {
        await isar.localLogs.clear();
        await isar.localLocationPings.clear();
        await isar.driverContexts.clear();
      });

      if (user.companyId != null && user.companyId!.isNotEmpty) {
        await firestoreService.removeDriverFromCompany(
            user.companyId!, user.userId);
      }
      await firestoreService.updateUser(user.userId, {
        'companyId': null,
        'companyCode': '',
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Company changed. Join a new company.')),
        );
        GoRouter.of(context).go('/company-join');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change company: $e')),
        );
      }
    }
  }
}

class _ProfileCard extends StatelessWidget {
  final UserModel? user;
  const _ProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: user?.profileImageUrl.isNotEmpty == true
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user!.profileImageUrl,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(Icons.person,
                            size: 32, color: AppColors.primary),
                      ),
                    )
                  : const Icon(Icons.person,
                      size: 32, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'Driver',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  if (user?.phoneNumber.isNotEmpty == true)
                    Text(
                      user!.phoneNumber,
                      style: const TextStyle(
                          color: AppColors.neutral, fontSize: 14),
                    ),
                  if (user?.licenseNumber.isNotEmpty == true)
                    Text(
                      'DL: ${user!.licenseNumber}',
                      style: const TextStyle(
                          color: AppColors.neutral, fontSize: 12),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VehicleTile extends StatelessWidget {
  final VehicleModel? vehicle;
  const _VehicleTile({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    if (vehicle == null) {
      return _SettingsTile(
        icon: Icons.directions_car_outlined,
        title: 'No Vehicle Assigned',
        subtitle: 'Contact your manager',
        onTap: null,
      );
    }
    return _SettingsTile(
      icon: Icons.directions_car,
      title: vehicle!.registrationNumber,
      subtitle: '${vehicle!.make} ${vehicle!.model} · ${vehicle!.year}',
      onTap: () => GoRouter.of(context).go('/vehicle'),
      trailing: const Icon(Icons.chevron_right, color: AppColors.neutral),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.neutral,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _PermissionHealthCard extends StatelessWidget {
  final TrackingPermissionStatus? status;

  const _PermissionHealthCard({required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 10),
              Text('Checking permission health...'),
            ],
          ),
        ),
      );
    }

    final notificationOk =
        !status!.notificationRequired || status!.notificationGranted;
    final locationOk =
        status!.foregroundLocationGranted && status!.backgroundLocationGranted;
    final allGranted = status!.allGranted;

    final Color accent = allGranted
        ? AppColors.income
        : (locationOk || notificationOk
            ? AppColors.warning
            : AppColors.expense);
    final String headline = allGranted
        ? 'Permission Health: Healthy'
        : (locationOk || notificationOk
            ? 'Permission Health: Action Needed'
            : 'Permission Health: Blocked');
    final String summary = allGranted
        ? 'Background tracking is fully available on this device.'
        : 'Some required permissions are missing. Tracking and sync reliability may be reduced.';

    return Container(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                allGranted
                    ? Icons.verified_rounded
                    : Icons.warning_amber_rounded,
                color: accent,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  headline,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            summary,
            style: const TextStyle(color: AppColors.neutral, fontSize: 12),
          ),
          const SizedBox(height: 10),
          _PermissionCheckRow(
            label: 'Foreground Location',
            ok: status!.foregroundLocationGranted,
          ),
          _PermissionCheckRow(
            label: 'Background Location',
            ok: status!.backgroundLocationGranted,
          ),
          _PermissionCheckRow(
            label: 'Notifications',
            ok: notificationOk,
          ),
          _PermissionCheckRow(
            label: 'Battery Optimization Ignored',
            ok: status!.batteryOptimizationIgnored,
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => context.push('/permissions'),
            icon: const Icon(Icons.security_rounded),
            label: Text(allGranted ? 'Review Permissions' : 'Fix Permissions'),
          ),
        ],
      ),
    );
  }
}

class _PermissionCheckRow extends StatelessWidget {
  final String label;
  final bool ok;

  const _PermissionCheckRow({required this.label, required this.ok});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: ok ? AppColors.income : AppColors.expense,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Text(
            ok ? 'Granted' : 'Missing',
            style: TextStyle(
              fontSize: 11,
              color: ok ? AppColors.income : AppColors.expense,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingDiagnosticsCard extends StatelessWidget {
  final AsyncValue<TrackingDiagnostics> diagnosticsAsync;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onForceSync;

  const _TrackingDiagnosticsCard({
    required this.diagnosticsAsync,
    required this.onRefresh,
    required this.onForceSync,
  });

  String _fmt(DateTime? dt) {
    if (dt == null) return '-';
    return dt.toLocal().toString().split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: diagnosticsAsync.when(
          loading: () => const SizedBox(
            height: 56,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text(
            'Diagnostics unavailable: $e',
            style: const TextStyle(color: AppColors.expense),
          ),
          data: (d) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tracking Diagnostics',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 10),
              _DiagRow(
                  label: 'Service Running', value: d.running ? 'Yes' : 'No'),
              _DiagRow(
                label: 'Pending Pings (Local)',
                value: d.pendingPingCount.toString(),
              ),
              _DiagRow(
                label: 'Synced Pings (Local)',
                value: d.syncedPingCount.toString(),
              ),
              _DiagRow(
                  label: 'Last Captured Ping', value: _fmt(d.lastCapturedAt)),
              _DiagRow(label: 'Last Synced Ping', value: _fmt(d.lastSyncedAt)),
              _DiagRow(
                label: 'Last Error',
                value: (d.lastError == null || d.lastError!.isEmpty)
                    ? '-'
                    : d.lastError!,
                error: d.lastError != null && d.lastError!.isNotEmpty,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async => onRefresh(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onForceSync,
                      icon: const Icon(Icons.sync),
                      label: const Text('Force Sync Now'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiagRow extends StatelessWidget {
  final String label;
  final String value;
  final bool error;

  const _DiagRow({
    required this.label,
    required this.value,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.neutral, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: error ? AppColors.expense : null,
                fontWeight: error ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: subtitle != null
            ? Text(subtitle!,
                style: const TextStyle(color: AppColors.neutral, fontSize: 12))
            : null,
        trailing: trailing ??
            (onTap != null
                ? const Icon(Icons.chevron_right, color: AppColors.neutral)
                : null),
        onTap: onTap,
      ),
    );
  }
}

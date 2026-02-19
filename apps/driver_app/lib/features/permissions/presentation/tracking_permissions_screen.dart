import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class TrackingPermissionsScreen extends ConsumerStatefulWidget {
  const TrackingPermissionsScreen({super.key});

  @override
  ConsumerState<TrackingPermissionsScreen> createState() =>
      _TrackingPermissionsScreenState();
}

class _TrackingPermissionsScreenState
    extends ConsumerState<TrackingPermissionsScreen>
    with WidgetsBindingObserver {
  bool _requesting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(trackingPermissionStatusProvider);
    }
  }

  Future<void> _requestNotification() async {
    await Permission.notification.request();
    ref.invalidate(trackingPermissionStatusProvider);
  }

  Future<void> _requestForegroundLocation() async {
    await Permission.locationWhenInUse.request();
    ref.invalidate(trackingPermissionStatusProvider);
  }

  Future<void> _requestBackgroundLocation() async {
    await Permission.locationAlways.request();
    ref.invalidate(trackingPermissionStatusProvider);
  }

  Future<void> _requestBatteryOptimizationIgnore() async {
    await Permission.ignoreBatteryOptimizations.request();
    ref.invalidate(trackingPermissionStatusProvider);
  }

  Future<void> _requestAll(TrackingPermissionStatus current) async {
    setState(() => _requesting = true);
    try {
      if (current.notificationRequired && !current.notificationGranted) {
        await Permission.notification.request();
      }
      if (!current.foregroundLocationGranted) {
        await Permission.locationWhenInUse.request();
      }
      if (!current.backgroundLocationGranted) {
        await Permission.locationAlways.request();
      }
      if (!current.batteryOptimizationIgnored) {
        await Permission.ignoreBatteryOptimizations.request();
      }

      ref.invalidate(trackingPermissionStatusProvider);
      final updated = await ref.read(trackingPermissionStatusProvider.future);
      if (!mounted) return;
      if (updated.allGranted) {
        context.go('/home');
      }
    } finally {
      if (mounted) {
        setState(() => _requesting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(trackingPermissionStatusProvider);

    return Scaffold(
      body: SafeArea(
        child: statusAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _PermissionError(error: e.toString()),
          data: (status) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderCard(allGranted: status.allGranted),
                  const SizedBox(height: 16),
                  _PermissionCard(
                    icon: Icons.notifications_active_rounded,
                    title: 'Notifications',
                    subtitle:
                        'Required to show ongoing tracking status and sync alerts.',
                    granted: !status.notificationRequired || status.notificationGranted,
                    required: status.notificationRequired,
                    onGrant: status.notificationRequired && !status.notificationGranted
                        ? _requestNotification
                        : null,
                  ),
                  const SizedBox(height: 12),
                  _PermissionCard(
                    icon: Icons.my_location_rounded,
                    title: 'Precise Location',
                    subtitle:
                        'Needed to capture accurate route points while driving.',
                    granted: status.foregroundLocationGranted,
                    required: true,
                    onGrant: status.foregroundLocationGranted
                        ? null
                        : _requestForegroundLocation,
                  ),
                  const SizedBox(height: 12),
                  _PermissionCard(
                    icon: Icons.location_history_rounded,
                    title: 'Background Location',
                    subtitle:
                        'Needed to continue tracking when the app is minimized or closed.',
                    granted: status.backgroundLocationGranted,
                    required: true,
                    onGrant: status.backgroundLocationGranted
                        ? null
                        : _requestBackgroundLocation,
                  ),
                  const SizedBox(height: 12),
                  _PermissionCard(
                    icon: Icons.battery_saver_rounded,
                    title: 'Ignore Battery Optimization',
                    subtitle:
                        'Recommended so Android does not throttle tracking while app is idle.',
                    granted: status.batteryOptimizationIgnored,
                    required: true,
                    onGrant: status.batteryOptimizationIgnored
                        ? null
                        : _requestBatteryOptimizationIgnore,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _requesting ? null : () => _requestAll(status),
                    child: Text(_requesting
                        ? 'Requesting Permissions...'
                        : 'Grant All & Continue'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => openAppSettings(),
                    child: const Text('Open System Settings'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tracking is disabled until all required permissions are granted.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.neutral,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final bool allGranted;

  const _HeaderCard({required this.allGranted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: allGranted
              ? [AppColors.income, AppColors.primary]
              : [AppColors.primary, AppColors.fuel],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  allGranted ? Icons.verified_rounded : Icons.security_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  allGranted
                      ? 'All Permissions Granted'
                      : 'Enable Tracking Permissions',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'FleetFuel360 needs these permissions to capture compliant, audit-ready trip and fuel logs.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool granted;
  final bool required;
  final Future<void> Function()? onGrant;

  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.granted,
    required this.required,
    required this.onGrant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (granted ? AppColors.income : AppColors.warning)
                    .withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: granted ? AppColors.income : AppColors.warning,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: granted
                              ? AppColors.income.withValues(alpha: 0.12)
                              : AppColors.warning.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          granted ? 'Granted' : (required ? 'Required' : 'Optional'),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color:
                                granted ? AppColors.income : AppColors.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.neutral,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (!granted)
                    OutlinedButton(
                      onPressed: onGrant == null ? null : () => onGrant!(),
                      child: const Text('Grant Permission'),
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

class _PermissionError extends StatelessWidget {
  final String error;

  const _PermissionError({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.expense, size: 38),
            const SizedBox(height: 12),
            const Text(
              'Could not load permission status',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.neutral, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

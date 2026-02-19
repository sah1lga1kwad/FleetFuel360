import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fleetfuel_core/fleetfuel_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'core/di/providers.dart';
import 'core/router/app_router.dart' show appRouterProvider;
import 'core/theme/app_theme.dart';
import 'features/tracking/background_location_service.dart';

class DriverApp extends ConsumerStatefulWidget {
  const DriverApp({super.key});

  @override
  ConsumerState<DriverApp> createState() => _DriverAppState();
}

class _DriverAppState extends ConsumerState<DriverApp>
    with WidgetsBindingObserver {
  BackgroundLocationService? _trackingService;
  String? _trackingUserId;
  bool _syncInProgress = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  bool _wasOnline = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshNativeTrackingDebug();
    _bindConnectivitySync();
    ref.listenManual<UserModel?>(
      currentUserProvider,
      (previous, next) {
        _syncTrackingForUser(next);
      },
      fireImmediately: true,
    );
    ref.listenManual<AsyncValue<TrackingPermissionStatus>>(
      trackingPermissionStatusProvider,
      (previous, next) {
        if (next.isLoading || next.hasError) return;
        final current = next.valueOrNull;
        if (current == null) return;

        final previousGranted = previous?.valueOrNull?.allGranted;
        final currentGranted = current.allGranted;

        if (previousGranted == true && !currentGranted) {
          _stopTracking();
          return;
        }
        if (currentGranted) {
          final user = ref.read(currentUserProvider);
          _syncTrackingForUser(user);
        }
      },
      fireImmediately: true,
    );
    ref.listenManual<bool>(
      trackingEnabledProvider,
      (previous, next) {
        if (!next) {
          _stopTracking();
          return;
        }
        final user = ref.read(currentUserProvider);
        _syncTrackingForUser(user);
      },
      fireImmediately: true,
    );
  }

  void _bindConnectivitySync() {
    final connectivity = Connectivity();
    connectivity.checkConnectivity().then((results) {
      _wasOnline = results.any((r) => r != ConnectivityResult.none);
      if (_wasOnline) {
        _attemptForegroundSync();
      }
    });

    _connectivitySub = connectivity.onConnectivityChanged.listen((results) {
      final isOnline = results.any((r) => r != ConnectivityResult.none);
      if (!_wasOnline && isOnline) {
        _attemptForegroundSync();
      }
      _wasOnline = isOnline;
    });
  }

  Future<void> _refreshNativeTrackingDebug() async {
    try {
      final state = await bg.BackgroundGeolocation.state;
      await setTrackingRunningDebug(state.enabled);
      if (state.enabled) {
        final user = ref.read(currentUserProvider);
        _syncTrackingForUser(user);
      }
    } catch (_) {
      // Background geolocation may not be ready yet.
    }
  }

  Future<void> _stopTracking() async {
    final service = _trackingService;
    _trackingService = null;
    _trackingUserId = null;
    await setTrackingRunningDebug(false);
    if (service == null) return;
    try {
      await service.stop();
      await service.clearIdentityCache();
    } catch (_) {}
  }

  Future<void> _syncTrackingForUser(UserModel? user) async {
    if (!mounted) return;

    if (user != null) {
      _attemptForegroundSync();
    }

    if (user == null) {
      final authAsync = ref.read(authStateStreamProvider);
      if (authAsync.isLoading) {
        // Auth state is still resolving on startup. Avoid stopping
        // an already-running native tracker during this transient window.
        return;
      }
      final firebaseUser = ref.read(currentFirebaseUserProvider);
      if (firebaseUser != null) {
        // User profile still loading; do not stop an already-running tracker.
        return;
      }
      await _stopTracking();
      return;
    }

    if (user.companyId == null || user.companyId!.isEmpty) {
      await _stopTracking();
      return;
    }

    final permissionsAsync = ref.read(trackingPermissionStatusProvider);
    if (permissionsAsync.isLoading || permissionsAsync.hasError) {
      // Do not stop/start tracking during transient permission state resolution.
      return;
    }
    final permissionsGranted = permissionsAsync.valueOrNull?.allGranted ?? false;
    if (!permissionsGranted) {
      await _stopTracking();
      return;
    }

    final trackingEnabled = ref.read(trackingEnabledProvider);
    if (!trackingEnabled) {
      await _stopTracking();
      return;
    }

    if (_trackingUserId == user.userId && _trackingService != null) {
      final activeAssignment =
          await ref.read(firestoreServiceProvider).getActiveAssignment(
                user.userId,
                companyId: user.companyId,
              );
      await _trackingService!.updateIdentity(
        vehicleId: activeAssignment?.vehicleId ?? '',
        assignmentId: activeAssignment?.assignmentId ?? '',
      );
      return;
    }

    final activeAssignment =
        await ref.read(firestoreServiceProvider).getActiveAssignment(
              user.userId,
              companyId: user.companyId,
            );
    final isar = ref.read(isarProvider);
    final service = BackgroundLocationService(
      isar: isar,
      driverId: user.userId,
      companyId: user.companyId!,
      vehicleId: activeAssignment?.vehicleId ?? '',
      assignmentId: activeAssignment?.assignmentId ?? '',
      onNetworkRestored: _attemptForegroundSync,
      onPingCaptured: _attemptForegroundSync,
    );

    try {
      await service.configure();
      await service.start();
      _trackingService = service;
      _trackingUserId = user.userId;
      await setTrackingRunningDebug(true);
    } catch (_) {
      await setTrackingRunningDebug(false);
      // Keep app functional even if location service init fails.
    }
  }

  Future<void> _attemptForegroundSync() async {
    if (_syncInProgress) return;
    _syncInProgress = true;
    try {
      await ref.read(syncServiceProvider).syncAll();
    } catch (_) {
      // Sync will retry later.
    } finally {
      _syncInProgress = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _attemptForegroundSync();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySub?.cancel();
    _trackingService = null;
    _trackingUserId = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'FleetFuel360',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

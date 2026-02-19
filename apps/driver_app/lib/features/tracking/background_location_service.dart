import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';
import '../../firebase_options.dart';

/// Headless task handler — runs even when app is terminated.
/// Must be a top-level function (not a method).
@pragma('vm:entry-point')
void headlessTask(bg.HeadlessEvent event) async {
  try {
    final context = await _readTrackingContext();
    if (context == null) return;

    if (event.name == bg.Event.LOCATION) {
      final bg.Location location = event.event as bg.Location;
      await _saveLocationPing(
        location,
        companyId: context.companyId,
        driverId: context.driverId,
        vehicleId: context.vehicleId,
        assignmentId: context.assignmentId,
        tryImmediateSync: true,
      );
      return;
    }

    if (event.name == bg.Event.HEARTBEAT) {
      final location = await bg.BackgroundGeolocation.getCurrentPosition(
        persist: false,
        samples: 1,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        timeout: 30,
      );
      await _saveLocationPing(
        location,
        companyId: context.companyId,
        driverId: context.driverId,
        vehicleId: context.vehicleId,
        assignmentId: context.assignmentId,
        tryImmediateSync: true,
      );
    }
  } catch (_) {
    // Keep headless resilient; failed events will be retried via foreground sync.
  }
}

/// Save a location ping to Isar (offline-first).
Future<void> _saveLocationPing(
  bg.Location location, {
  required String companyId,
  required String driverId,
  required String vehicleId,
  required String assignmentId,
  Isar? isarInstance,
  bool tryImmediateSync = false,
}) async {
  try {
    final isar = isarInstance ?? await _openIsar();
    final now = DateTime.now();

    final ping = LocalLocationPing()
      ..localId = 'ping_${now.microsecondsSinceEpoch}'
      ..companyId = companyId
      ..driverId = driverId
      ..vehicleId = vehicleId
      ..assignmentId = assignmentId
      ..latitude = location.coords.latitude
      ..longitude = location.coords.longitude
      ..accuracy = location.coords.accuracy
      ..speed = location.coords.speed
      ..bearing = location.coords.heading
      ..altitude = location.coords.altitude
      ..geohash = Geohash.encode(location.coords.latitude, location.coords.longitude)
      ..activity = _activityType(location)
      ..isMoving = _isMoving(location)
      ..batteryLevel = _batteryLevel(location)
      ..isCharging = _isCharging(location)
      ..networkType = _networkType(location)
      ..recordedAt = _recordedAt(location)
      ..syncStatus = SyncStatus.pending;
    await isar.writeTxn(() async {
      await isar.localLocationPings.put(ping);
    });
    await _setTrackingDebug(
      lastCapturedAt: now,
      lastError: null,
    );

    if (tryImmediateSync) {
      await _tryImmediatePingSync(isar, ping);
    }
  } catch (e) {
    await _setTrackingDebug(lastError: e.toString());
    // Silently fail in headless mode — retry happens on next sync
  }
}

Future<Isar> _openIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [LocalLocationPingSchema],
    directory: dir.path,
    name: AppConstants.isarInstanceName,
  );
}

String _activityType(bg.Location location) {
  try {
    final dynamic type = (location as dynamic).activity?.type;
    if (type is String && type.isNotEmpty) return type;
  } catch (_) {}
  return ActivityType.unknown.name;
}

int _batteryLevel(bg.Location location) {
  try {
    final dynamic level = (location as dynamic).battery?.level;
    if (level is num) return level.round();
  } catch (_) {}
  return 0;
}

String _networkType(bg.Location location) {
  try {
    final dynamic network = (location as dynamic).networkType;
    if (network is String && network.isNotEmpty) return network;
  } catch (_) {}
  try {
    final dynamic network = (location as dynamic).battery?.networkType;
    if (network is String && network.isNotEmpty) return network;
  } catch (_) {}
  return 'unknown';
}

bool _isMoving(bg.Location location) {
  try {
    final dynamic moving = (location as dynamic).isMoving;
    if (moving is bool) return moving;
  } catch (_) {}
  return false;
}

bool _isCharging(bg.Location location) {
  try {
    final dynamic charging = (location as dynamic).battery?.isCharging;
    if (charging is bool) return charging;
  } catch (_) {}
  return false;
}

DateTime _recordedAt(bg.Location location) {
  try {
    final dynamic ts = (location as dynamic).timestamp;
    if (ts is String) {
      return DateTime.tryParse(ts) ?? DateTime.now();
    }
    if (ts is int) {
      return DateTime.fromMillisecondsSinceEpoch(ts);
    }
  } catch (_) {}
  return DateTime.now();
}

class BackgroundLocationService {
  final Isar _isar;
  final String _driverId;
  final String _companyId;
  String _vehicleId;
  String _assignmentId;
  final VoidCallback? _onNetworkRestored;
  final VoidCallback? _onPingCaptured;

  BackgroundLocationService({
    required Isar isar,
    required String driverId,
    required String companyId,
    String vehicleId = '',
    String assignmentId = '',
    VoidCallback? onNetworkRestored,
    VoidCallback? onPingCaptured,
  })  : _isar = isar,
        _driverId = driverId,
        _companyId = companyId,
        _vehicleId = vehicleId,
        _assignmentId = assignmentId,
        _onNetworkRestored = onNetworkRestored,
        _onPingCaptured = onPingCaptured;

  Future<void> configure() async {
    await _writeTrackingContext(
      _TrackingContext(
        driverId: _driverId,
        companyId: _companyId,
        vehicleId: _vehicleId,
        assignmentId: _assignmentId,
      ),
    );

    await bg.BackgroundGeolocation.ready(bg.Config(
      // Tracking parameters
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: AppConstants.locationDistanceFilterMetres.toDouble(),
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,

      // iOS-specific
      activityType: bg.Config.ACTIVITY_TYPE_AUTOMOTIVE_NAVIGATION,
      pausesLocationUpdatesAutomatically: false,

      // Android-specific
      foregroundService: true,
      notification: bg.Notification(
        title: 'FleetFuel360',
        text: 'Tracking your route',
        smallIcon: 'mipmap/ic_launcher',
      ),

      // Heartbeat
      heartbeatInterval: 60,

      // Logging (disable in production)
      logLevel: bg.Config.LOG_LEVEL_OFF,
    ));

    bg.BackgroundGeolocation.onLocation(_onLocation);
    bg.BackgroundGeolocation.onHeartbeat(_onHeartbeat);
    bg.BackgroundGeolocation.onConnectivityChange(_onConnectivity);
  }

  Future<void> updateIdentity({
    required String vehicleId,
    required String assignmentId,
  }) async {
    _vehicleId = vehicleId;
    _assignmentId = assignmentId;
    await _writeTrackingContext(
      _TrackingContext(
        driverId: _driverId,
        companyId: _companyId,
        vehicleId: _vehicleId,
        assignmentId: _assignmentId,
      ),
    );
  }

  void _onLocation(bg.Location location) async {
    await _saveLocationPing(
      location,
      companyId: _companyId,
      driverId: _driverId,
      vehicleId: _vehicleId,
      assignmentId: _assignmentId,
      isarInstance: _isar,
      tryImmediateSync: true,
    );
    _onPingCaptured?.call();
  }

  void _onHeartbeat(bg.HeartbeatEvent event) async {
    try {
      final location = await bg.BackgroundGeolocation.getCurrentPosition(
        persist: false,
        samples: 1,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        timeout: 30,
      );
      await _saveLocationPing(
        location,
        companyId: _companyId,
        driverId: _driverId,
        vehicleId: _vehicleId,
        assignmentId: _assignmentId,
        isarInstance: _isar,
        tryImmediateSync: true,
      );
      _onPingCaptured?.call();
    } catch (_) {}
  }

  void _onConnectivity(bg.ConnectivityChangeEvent event) {
    if (event.connected == true) {
      _onNetworkRestored?.call();
    }
  }

  Future<void> start() async {
    await bg.BackgroundGeolocation.start();
  }

  Future<void> stop() async {
    await bg.BackgroundGeolocation.stop();
  }

  Future<void> clearIdentityCache() async {
    await _clearTrackingContext();
  }

  Future<bool> get isRunning async {
    final state = await bg.BackgroundGeolocation.state;
    return state.enabled;
  }
}

/// Provider for the background location service.
/// Must be overridden in main() after Isar and user are available.
final backgroundLocationServiceProvider =
    Provider<BackgroundLocationService?>((ref) => null);

class _TrackingContext {
  final String driverId;
  final String companyId;
  final String vehicleId;
  final String assignmentId;

  const _TrackingContext({
    required this.driverId,
    required this.companyId,
    required this.vehicleId,
    required this.assignmentId,
  });
}

const _trackingDriverIdKey = 'tracking_driver_id';
const _trackingCompanyIdKey = 'tracking_company_id';
const _trackingVehicleIdKey = 'tracking_vehicle_id';
const _trackingAssignmentIdKey = 'tracking_assignment_id';

Future<void> _writeTrackingContext(_TrackingContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_trackingDriverIdKey, context.driverId);
  await prefs.setString(_trackingCompanyIdKey, context.companyId);
  await prefs.setString(_trackingVehicleIdKey, context.vehicleId);
  await prefs.setString(_trackingAssignmentIdKey, context.assignmentId);
}

Future<_TrackingContext?> _readTrackingContext() async {
  final prefs = await SharedPreferences.getInstance();
  final driverId = prefs.getString(_trackingDriverIdKey) ?? '';
  final companyId = prefs.getString(_trackingCompanyIdKey) ?? '';
  final vehicleId = prefs.getString(_trackingVehicleIdKey) ?? '';
  final assignmentId = prefs.getString(_trackingAssignmentIdKey) ?? '';
  if (driverId.isEmpty || companyId.isEmpty) return null;
  return _TrackingContext(
    driverId: driverId,
    companyId: companyId,
    vehicleId: vehicleId,
    assignmentId: assignmentId,
  );
}

Future<void> _clearTrackingContext() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_trackingDriverIdKey);
  await prefs.remove(_trackingCompanyIdKey);
  await prefs.remove(_trackingVehicleIdKey);
  await prefs.remove(_trackingAssignmentIdKey);
}

Future<void> _ensureFirebaseInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isNotEmpty) return;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _tryImmediatePingSync(Isar isar, LocalLocationPing ping) async {
  try {
    if (ping.driverId.isEmpty || ping.companyId.isEmpty) return;

    final connectivity = await Connectivity().checkConnectivity();
    final isOnline = connectivity.any((r) => r != ConnectivityResult.none);
    if (!isOnline) return;

    await _ensureFirebaseInitialized();

    final authUid = FirebaseAuth.instance.currentUser?.uid;
    if (authUid == null || authUid != ping.driverId) return;

    final activity = ActivityType.values.firstWhere(
      (a) => a.name == ping.activity,
      orElse: () => ActivityType.unknown,
    );
    final model = LocationPingModel(
      pingId: '',
      driverId: ping.driverId,
      vehicleId: ping.vehicleId,
      companyId: ping.companyId,
      assignmentId: ping.assignmentId,
      latitude: ping.latitude,
      longitude: ping.longitude,
      accuracy: ping.accuracy,
      altitude: ping.altitude,
      speed: ping.speed,
      bearing: ping.bearing,
      geohash: ping.geohash,
      activity: activity,
      isMoving: ping.isMoving,
      batteryLevel: ping.batteryLevel,
      isCharging: ping.isCharging,
      networkType: ping.networkType,
      recordedAt: ping.recordedAt,
      createdAt: ping.recordedAt,
    );

    final firestoreId = await FirestoreService().createLocationPing(model);
    await isar.writeTxn(() async {
      ping.firestoreId = firestoreId;
      ping.syncStatus = SyncStatus.synced;
      ping.syncedAt = DateTime.now();
      await isar.localLocationPings.put(ping);
    });
    await _setTrackingDebug(
      lastSyncedAt: DateTime.now(),
      lastError: null,
    );
  } catch (e) {
    await _setTrackingDebug(lastError: e.toString());
    // Keep pending; sync service will retry.
  }
}

const _trackingRunningKey = 'tracking_running';
const _trackingLastCapturedAtKey = 'tracking_last_captured_at';
const _trackingLastSyncedAtKey = 'tracking_last_synced_at';
const _trackingLastErrorKey = 'tracking_last_error';

Future<void> setTrackingRunningDebug(bool running) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_trackingRunningKey, running);
}

Future<void> _setTrackingDebug({
  DateTime? lastCapturedAt,
  DateTime? lastSyncedAt,
  String? lastError,
}) async {
  final prefs = await SharedPreferences.getInstance();
  if (lastCapturedAt != null) {
    await prefs.setString(
      _trackingLastCapturedAtKey,
      lastCapturedAt.toIso8601String(),
    );
  }
  if (lastSyncedAt != null) {
    await prefs.setString(
      _trackingLastSyncedAtKey,
      lastSyncedAt.toIso8601String(),
    );
  }
  if (lastError == null) {
    await prefs.remove(_trackingLastErrorKey);
  } else {
    await prefs.setString(_trackingLastErrorKey, lastError);
  }
}

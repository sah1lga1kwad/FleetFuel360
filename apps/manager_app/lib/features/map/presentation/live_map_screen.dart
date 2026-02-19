import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/driver_status.dart';

class LiveMapScreen extends ConsumerStatefulWidget {
  const LiveMapScreen({super.key});

  @override
  ConsumerState<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends ConsumerState<LiveMapScreen> {
  GoogleMapController? _mapController;
  final Map<String, BitmapDescriptor> _markerCache = {};
  Set<Polyline> _polylines = {};
  String? _activeDriverId;
  String? _selectedRange;

  Future<BitmapDescriptor> _buildDriverMarker(
    String initials,
    DriverStatus status,
  ) async {
    final cacheKey = '${initials.toUpperCase()}_${status.name}';
    final cached = _markerCache[cacheKey];
    if (cached != null) return cached;

    const size = 80.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final bgColor = switch (status) {
      DriverStatus.active => const Color(0xFF43A047),
      DriverStatus.idle => const Color(0xFFFB8C00),
      DriverStatus.offline => const Color(0xFF757575),
    };

    canvas.drawCircle(const Offset(40, 40), 38, Paint()..color = bgColor);
    canvas.drawCircle(
      const Offset(40, 40),
      38,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    final text = initials.substring(0, min(2, initials.length)).toUpperCase();
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset((size - tp.width) / 2, (size - tp.height) / 2));

    final img =
        await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
    final descriptor = BitmapDescriptor.fromBytes(
      bytes?.buffer.asUint8List() ?? Uint8List(0),
    );
    _markerCache[cacheKey] = descriptor;
    return descriptor;
  }

  Future<void> _showTrailForDriver(String driverId, Duration range) async {
    final service = ref.read(firestoreServiceProvider);
    final pings = await service.getDriverPings(
      driverId,
      startDate: DateTime.now().subtract(range),
      endDate: DateTime.now(),
    );

    final points = pings.map((p) => LatLng(p.latitude, p.longitude)).toList();

    setState(() {
      _activeDriverId = driverId;
      _polylines = {
        Polyline(
          polylineId: PolylineId(driverId),
          points: points,
          color: AppColors.primary,
          width: 4,
        ),
      };
    });

    if (points.isNotEmpty) {
      await _mapController?.animateCamera(CameraUpdate.newLatLng(points.last));
    }
  }

  @override
  Widget build(BuildContext context) {
    final driversAsync = ref.watch(companyDriversProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Map')),
      body: driversAsync.when(
        data: (drivers) {
          return FutureBuilder<Set<Marker>>(
            future: _buildMarkers(drivers),
            builder: (context, snapshot) {
              final markers = snapshot.data ?? <Marker>{};
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(20.5937, 78.9629),
                      zoom: 5,
                    ),
                    markers: markers,
                    polylines: _polylines,
                    onMapCreated: (controller) => _mapController = controller,
                  ),
                  if (_activeDriverId != null)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final label in ['30 min', '1 hr', 'Today'])
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ChoiceChip(
                                label: Text(label),
                                selected: _selectedRange == label,
                                onSelected: (_) {
                                  setState(() => _selectedRange = label);
                                  final range = switch (label) {
                                    '30 min' => const Duration(minutes: 30),
                                    '1 hr' => const Duration(hours: 1),
                                    'Today' =>
                                      Duration(hours: DateTime.now().hour + 1),
                                    _ => const Duration(hours: 1),
                                  };
                                  _showTrailForDriver(_activeDriverId!, range);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FloatingActionButton.small(
                      onPressed: () => setState(() {
                        _polylines = {};
                        _activeDriverId = null;
                        _selectedRange = null;
                      }),
                      child: const Icon(Icons.clear),
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Failed to load map: $err')),
      ),
    );
  }

  Future<Set<Marker>> _buildMarkers(List<UserModel> drivers) async {
    final markers = <Marker>{};
    for (final driver in drivers) {
      final loc = driver.lastKnownLocation;
      if (loc == null) continue;
      final initials = _initials(driver.name);
      final status = statusFromDriver(driver);
      final icon = await _buildDriverMarker(initials, status);

      markers.add(
        Marker(
          markerId: MarkerId(driver.userId),
          position: LatLng(loc.latitude, loc.longitude),
          icon: icon,
          onTap: () {
            final assignment =
                ref.read(assignmentByDriverProvider)[driver.userId];
            showModalBottomSheet<void>(
              context: context,
              builder: (_) => _DriverMapSheet(
                driver: driver,
                assignment: assignment,
                onViewDriver: () {
                  Navigator.pop(context);
                  context.push('/fleet/drivers/${driver.userId}');
                },
                onShowTrail: () {
                  Navigator.pop(context);
                  _selectedRange = '1 hr';
                  _showTrailForDriver(driver.userId, const Duration(hours: 1));
                },
              ),
            );
          },
        ),
      );
    }
    return markers;
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return 'D';
    if (parts.length == 1) return parts.first.characters.first;
    return '${parts.first.characters.first}${parts.last.characters.first}';
  }
}

class _DriverMapSheet extends StatelessWidget {
  const _DriverMapSheet({
    required this.driver,
    required this.assignment,
    required this.onViewDriver,
    required this.onShowTrail,
  });

  final UserModel driver;
  final VehicleAssignmentModel? assignment;
  final VoidCallback onViewDriver;
  final VoidCallback onShowTrail;

  @override
  Widget build(BuildContext context) {
    final loc = driver.lastKnownLocation;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(driver.name, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 4),
            Text(driver.phoneNumber.isEmpty
                ? driver.userId
                : driver.phoneNumber),
            const SizedBox(height: 8),
            Text('Vehicle: ${assignment?.vehicleId ?? 'Unassigned'}'),
            if (loc != null) ...[
              const SizedBox(height: 4),
              Text('Last seen ${AppFormatters.formatRelative(loc.recordedAt)}'),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onShowTrail,
                    child: const Text('Show Trail'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: onViewDriver,
                    child: const Text('View Driver'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

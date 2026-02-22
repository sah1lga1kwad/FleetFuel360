import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';

class LogDetailScreen extends ConsumerWidget {
  const LogDetailScreen({super.key, required this.logId});

  final String logId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Detail')),
      body: FutureBuilder<LogModel?>(
        future: ref.read(firestoreServiceProvider).getLog(logId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final log = snapshot.data;
          if (log == null) {
            return const Center(child: Text('Log not found'));
          }

          final images = [
            ...log.receiptImageUrls,
            if (log.odometerImageUrl != null &&
                log.odometerImageUrl!.isNotEmpty)
              log.odometerImageUrl!,
            if (log.fuelMeterImageUrl != null &&
                log.fuelMeterImageUrl!.isNotEmpty)
              log.fuelMeterImageUrl!,
            if (log.vehicleImageUrl != null && log.vehicleImageUrl!.isNotEmpty)
              log.vehicleImageUrl!,
          ];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(log.logType.name,
                  style: Theme.of(context).textTheme.displaySmall),
              Text(AppFormatters.formatDateTime(log.createdAt)),
              const SizedBox(height: 8),
              Text('Amount: ${AppFormatters.formatAmount(log.amount)}'),
              Text('Driver: ${log.driverId}'),
              Text('Vehicle: ${log.vehicleId}'),
              const SizedBox(height: 12),
              if (log.location.latitude != 0.0 || log.location.longitude != 0.0)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: _staticMapUrl(
                      log.location.latitude,
                      log.location.longitude,
                    ),
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
              if (log.location.latitude != 0.0 || log.location.longitude != 0.0)
                const SizedBox(height: 12),
              if (images.isNotEmpty)
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                              appBar: AppBar(),
                              body: PhotoView(
                                imageProvider:
                                    CachedNetworkImageProvider(images[i]),
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: images[i],
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: images.length,
                  ),
                ),
              const SizedBox(height: 12),
              Text('Notes: ${log.notes.isEmpty ? '-' : log.notes}'),
              Text(
                  'Description: ${log.description.isEmpty ? '-' : log.description}'),
              if (log.isEdited)
                ExpansionTile(
                  title: Text('⚠ Edited ${log.editHistory.length} time(s)'),
                  children: log.editHistory
                      .map(
                        (edit) => ListTile(
                          title: Text(
                            'Edited ${AppFormatters.formatRelative(edit.editedAt)}',
                          ),
                          subtitle: Text(
                            edit.reason.isEmpty
                                ? 'No reason given'
                                : edit.reason,
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          );
        },
      ),
    );
  }

  String _staticMapUrl(double lat, double lng) {
    const apiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
    final center = '$lat,$lng';
    final markers = 'color:red|$lat,$lng';
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=${Uri.encodeQueryComponent(center)}'
        '&zoom=15'
        '&size=400x200'
        '&markers=${Uri.encodeQueryComponent(markers)}'
        '&key=$apiKey';
  }
}

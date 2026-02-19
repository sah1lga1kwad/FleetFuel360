import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              if (images.isNotEmpty)
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: images[i],
                        width: 220,
                        fit: BoxFit.cover,
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
            ],
          );
        },
      ),
    );
  }
}

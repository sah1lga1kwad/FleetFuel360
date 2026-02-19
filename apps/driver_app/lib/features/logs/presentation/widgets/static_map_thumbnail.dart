import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class StaticMapThumbnail extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double width;
  final double height;
  final double borderRadius;
  final int zoom;
  final String? noLocationLabel;

  const StaticMapThumbnail({
    super.key,
    required this.latitude,
    required this.longitude,
    this.width = 60,
    this.height = 60,
    this.borderRadius = 10,
    this.zoom = 15,
    this.noLocationLabel,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation = latitude != 0.0 || longitude != 0.0;
    if (!hasLocation) {
      return _placeholder();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedWidth = width.isFinite
            ? width
            : (constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0);
        final resolvedHeight = height.isFinite ? height : 170.0;
        final url = _buildStaticMapUrl(
          latitude: latitude,
          longitude: longitude,
          width: resolvedWidth.toInt(),
          height: resolvedHeight.toInt(),
          zoom: zoom,
        );

        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            url,
            width: resolvedWidth,
            height: resolvedHeight,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _placeholder(),
          ),
        );
      },
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.map_outlined, color: AppColors.neutral),
          if (noLocationLabel != null) ...[
            const SizedBox(height: 4),
            Text(
              noLocationLabel!,
              style: const TextStyle(
                color: AppColors.neutral,
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _buildStaticMapUrl({
    required double latitude,
    required double longitude,
    required int width,
    required int height,
    required int zoom,
  }) {
    final clampedWidth = width.clamp(1, 640);
    final clampedHeight = height.clamp(1, 640);
    const envApiKey = String.fromEnvironment('GOOGLE_MAPS_STATIC_API_KEY');
    const fallbackApiKey = 'AIzaSyCYbuFTJtGgDeTZs7HJ2tYHtDCQHvHPvTI';
    final apiKey = envApiKey.isNotEmpty ? envApiKey : fallbackApiKey;
    final params = <String, String>{
      'center': '$latitude,$longitude',
      'zoom': '$zoom',
      'size': '${clampedWidth}x$clampedHeight',
      'scale': '2',
      'maptype': 'roadmap',
      'markers': 'color:red|$latitude,$longitude',
      if (apiKey.isNotEmpty) 'key': apiKey,
    };
    return Uri.https('maps.googleapis.com', '/maps/api/staticmap', params)
        .toString();
  }
}

/// Simple geohash encoder for indexing location data in Firestore.
/// Precision 7 = ~150m accuracy, sufficient for log location queries.
class Geohash {
  static const String _base32 = '0123456789bcdefghjkmnpqrstuvwxyz';
  static const int _defaultPrecision = 7;

  /// Encode lat/lng to geohash string.
  static String encode(double lat, double lng, {int precision = _defaultPrecision}) {
    var minLat = -90.0, maxLat = 90.0;
    var minLng = -180.0, maxLng = 180.0;
    var isEven = true;
    var bit = 0;
    var ch = 0;
    final hash = StringBuffer();

    while (hash.length < precision) {
      if (isEven) {
        final mid = (minLng + maxLng) / 2;
        if (lng > mid) {
          ch |= (1 << (4 - bit));
          minLng = mid;
        } else {
          maxLng = mid;
        }
      } else {
        final mid = (minLat + maxLat) / 2;
        if (lat > mid) {
          ch |= (1 << (4 - bit));
          minLat = mid;
        } else {
          maxLat = mid;
        }
      }
      isEven = !isEven;

      if (bit < 4) {
        bit++;
      } else {
        hash.write(_base32[ch]);
        bit = 0;
        ch = 0;
      }
    }

    return hash.toString();
  }

  /// Returns neighboring geohashes for a given geohash.
  static List<String> neighbors(String geohash) {
    // Simplified — returns the hash itself for Phase 1
    // Phase 2: implement full neighbor calculation
    return [geohash];
  }
}

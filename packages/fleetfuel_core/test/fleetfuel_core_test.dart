import 'package:flutter_test/flutter_test.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

void main() {
  test('geohash encoder returns a value', () {
    final hash = Geohash.encode(12.9716, 77.5946);
    expect(hash, isNotEmpty);
  });
}

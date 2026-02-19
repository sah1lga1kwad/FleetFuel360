import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'package:fleetfuel_core/fleetfuel_core.dart';

import 'app.dart';
import 'core/di/providers.dart';
import 'features/tracking/background_location_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: kDebugMode
        ? AndroidProvider.debug
        : AndroidProvider.playIntegrity,
  );

  // Isar — open with all local schemas
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [LocalLogSchema, LocalLocationPingSchema],
    directory: dir.path,
    name: AppConstants.isarInstanceName,
  );

  // Register the background GPS headless task before BackgroundGeolocation.ready
  bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);

  runApp(
    ProviderScope(
      overrides: [
        // Inject the real Isar instance into the provider graph
        isarProvider.overrideWithValue(isar),
      ],
      child: const DriverApp(),
    ),
  );
}

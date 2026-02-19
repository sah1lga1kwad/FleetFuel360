// GENERATED FILE — run `flutterfire configure` to populate this file.
// This stub lets the project compile before Firebase is configured.
// Replace this entire file by running: flutterfire configure

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform. '
          'Run: flutterfire configure',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiWK80q1o8w1zP5pJANF5Ve_cWH6OCy_k',
    appId: '1:155537989342:android:c70084a5c616edc50b2c4f',
    messagingSenderId: '155537989342',
    projectId: 'fleetfuel360-dev',
    storageBucket: 'fleetfuel360-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFZoHHikLi4BQqwmfIirGHEap4o-aCkYE',
    appId: '1:155537989342:ios:4ad7be80c05c61480b2c4f',
    messagingSenderId: '155537989342',
    projectId: 'fleetfuel360-dev',
    storageBucket: 'fleetfuel360-dev.firebasestorage.app',
    androidClientId: '155537989342-51tb9gqt4gfdmscqdjls6kmq1nb8s6nj.apps.googleusercontent.com',
    iosClientId: '155537989342-l8nqpf36fv76mncp9747pga9l6gm8t9c.apps.googleusercontent.com',
    iosBundleId: 'com.fleetfuel360.manager',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'REPLACE_WITH_WEB_API_KEY',
    appId: 'REPLACE_WITH_WEB_APP_ID',
    messagingSenderId: 'REPLACE_WITH_SENDER_ID',
    projectId: 'REPLACE_WITH_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_STORAGE_BUCKET',
    authDomain: 'REPLACE_WITH_AUTH_DOMAIN',
  );
}
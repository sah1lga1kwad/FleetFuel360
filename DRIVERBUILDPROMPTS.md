# AI Agent Build Prompt — FleetFuel360 Phase 1
## Driver App + Shared Backend

> **Instructions for the agent:** Read this entire prompt before writing any code.  
> Do not hallucinate packages, APIs, or Flutter APIs that do not exist.  
> If you are uncertain about a package API, use the package's official pub.dev documentation.  
> Build incrementally. After each section, confirm files created before moving to the next.  
> Never skip error handling. Never assume network is available.

---

## What You Are Building

A Flutter monorepo called `fleetfuel360` containing:

1. `packages/fleetfuel_core` — Shared Dart package with all models, Firebase service classes, and utilities
2. `apps/driver_app` — Flutter app "FleetFuel360 Drivers" for vehicle drivers
3. `apps/manager_app` — Flutter app placeholder only (scaffold, empty main.dart)

The driver app is a **fuel and expense tracking app** for commercial vehicle drivers. Drivers log fuel fills, cash expenses, and payments received. The app tracks their GPS location every 60 seconds in the background — even when the app is killed. All data must work **offline first** — logs created without internet must sync automatically when internet returns.

---

## Monorepo Structure to Create

```
fleetfuel360/
├── apps/
│   ├── driver_app/
│   └── manager_app/
├── packages/
│   └── fleetfuel_core/
├── firebase/
│   ├── firestore.rules
│   ├── storage.rules
│   ├── firestore.indexes.json
│   └── functions/
│       ├── src/index.ts
│       └── package.json
├── SPEC.md
├── .gitignore
└── README.md
```

---

## STEP 1 — Create Monorepo Scaffold

Run these commands in order:

```bash
# Create root directory
mkdir fleetfuel360 && cd fleetfuel360

# Create shared Dart package
mkdir -p packages
cd packages
flutter create --template=package fleetfuel_core
cd ..

# Create driver app
mkdir -p apps
cd apps
flutter create --org com.fleetfuel360 --project-name driver_app driver_app
cd driver_app
# Rename bundle ID to com.fleetfuel360.driver in android/app/build.gradle and iOS config

# Create manager app (placeholder only)
cd ..
flutter create --org com.fleetfuel360 --project-name manager_app manager_app
# Replace manager_app/lib/main.dart with a simple placeholder widget only
cd ../..
```

After scaffold is created, verify all three directories exist:
- `fleetfuel360/packages/fleetfuel_core/`
- `fleetfuel360/apps/driver_app/`
- `fleetfuel360/apps/manager_app/`

---

## STEP 2 — Configure pubspec.yaml Files

### `packages/fleetfuel_core/pubspec.yaml`

```yaml
name: fleetfuel_core
description: Shared models, services, and utilities for FleetFuel360 apps
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cloud_firestore: ^5.4.4
  firebase_storage: ^12.3.6
  firebase_auth: ^5.3.4
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  isar: ^3.1.0+1
  path_provider: ^2.1.4
  crypto: ^3.0.3
  uuid: ^4.4.0

dev_dependencies:
  build_runner: ^2.4.12
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  isar_generator: ^3.1.0+1
```

### `apps/driver_app/pubspec.yaml`

```yaml
name: driver_app
description: FleetFuel360 Drivers - Fuel and expense tracking for fleet drivers
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Shared package
  fleetfuel_core:
    path: ../../packages/fleetfuel_core

  # Firebase
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.4
  cloud_firestore: ^5.4.4
  firebase_storage: ^12.3.6
  firebase_messaging: ^15.1.4

  # Google Sign-In
  google_sign_in: ^6.2.1

  # State Management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  # Navigation
  go_router: ^14.2.7

  # Background GPS — transistorsoft package
  # IMPORTANT: This requires a license for production. For development it works without one.
  # Package name: flutter_background_geolocation
  # Add manually: follow transistorsoft setup at https://pub.dev/packages/flutter_background_geolocation
  flutter_background_geolocation: ^4.17.0

  # Maps & Location
  google_maps_flutter: ^2.7.0
  geolocator: ^12.0.0
  geocoding: ^3.0.0

  # Local Database
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.4

  # Images
  image_picker: ^1.1.2
  flutter_image_compress: ^2.3.0
  cached_network_image: ^3.3.1

  # Connectivity
  connectivity_plus: ^6.0.5
  device_info_plus: ^10.1.2
  battery_plus: ^6.0.3
  permission_handler: ^11.3.1

  # UI
  google_fonts: ^6.2.1
  shimmer: ^3.0.0
  lottie: ^3.1.2
  intl: ^0.19.0

  # Utils
  uuid: ^4.4.0
  package_info_plus: ^8.0.2
  url_launcher: ^6.3.0
  share_plus: ^9.0.0
  crypto: ^3.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.12
  riverpod_generator: ^2.3.5
  riverpod_lint: ^2.3.7
  isar_generator: ^3.1.0+1
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  flutter_lints: ^4.0.0
```

---

## STEP 3 — Build `fleetfuel_core` Package

Build all models and services in the shared package. Every model must be a Freezed class with JSON serialization and an `isar` compatible version where needed.

### 3.1 Barrel export file

`packages/fleetfuel_core/lib/fleetfuel_core.dart`:
```dart
library fleetfuel_core;

// Models
export 'models/company_model.dart';
export 'models/user_model.dart';
export 'models/vehicle_model.dart';
export 'models/vehicle_assignment_model.dart';
export 'models/log_model.dart';
export 'models/location_ping_model.dart';

// Local (Isar) Models
export 'models/local/local_log.dart';
export 'models/local/local_location_ping.dart';

// Services
export 'services/auth_service.dart';
export 'services/firestore_service.dart';
export 'services/storage_service.dart';
export 'services/sync_service.dart';

// Utils
export 'utils/constants.dart';
export 'utils/formatters.dart';
export 'utils/geohash.dart';
```

### 3.2 Firestore Models (Freezed)

Create these files in `packages/fleetfuel_core/lib/models/`:

**`company_model.dart`**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String companyId,
    required String name,
    required String companyCode,
    required String managerId,
    @Default([]) List<String> memberDriverIds,
    @Default([]) List<String> vehicleIds,
    @Default('INR') String currency,
    @Default('Asia/Kolkata') String timezone,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CompanyModel.fromJson({
      ...data,
      'companyId': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
```

**`user_model.dart`** — include all fields from spec section 5.2  
**`vehicle_model.dart`** — include all fields from spec section 5.3  
**`vehicle_assignment_model.dart`** — include all fields from spec section 5.4  

**`log_model.dart`** — This is the most critical model. Include ALL fields from spec section 5.5:
- logType as enum: `LogType { fuelFill, cashExpense, paymentReceived, advance, loan, other }`
- category as enum: `LogCategory { fuel, repair, food, toll, tyre, oil, cleaning, fine, other }`
- paidBy as enum: `PaidBy { driver, company }`
- paymentMode as enum: `PaymentMode { cash, upi, card, fuelCard, bankTransfer, other }`
- EditHistoryEntry as a nested Freezed class
- LocationData as a nested Freezed class
- DeviceContext as a nested Freezed class

**`location_ping_model.dart`** — include all fields from spec section 5.6

### 3.3 Local Isar Models

**`packages/fleetfuel_core/lib/models/local/local_log.dart`**

```dart
import 'package:isar/isar.dart';

part 'local_log.g.dart';

enum SyncStatus { pending, uploading, synced, failed }

@collection
class LocalLog {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String localId;

  String? firestoreId;
  
  late String driverId;
  late String vehicleId;
  late String companyId;
  late String assignmentId;

  late String logType;
  late String category;
  late int amount;
  late String currency;
  late String paidBy;
  late String paymentMode;
  late String description;
  late String notes;

  // Local image file paths (before upload)
  late List<String> localReceiptImagePaths;
  String? localOdometerImagePath;
  String? localFuelMeterImagePath;
  String? localVehicleImagePath;

  // Firebase Storage URLs (set after upload)
  late List<String> receiptImageUrls;
  String? odometerImageUrl;
  String? fuelMeterImageUrl;
  String? vehicleImageUrl;

  late int odometerReading;
  late double fuelQuantityLitres;
  late double fuelPricePerLitre;

  late double latitude;
  late double longitude;
  late double accuracy;
  late String address;
  late String geohash;

  late double speed;
  late double bearing;
  late double altitude;
  late int batteryLevel;
  late bool isCharging;
  late String networkType;

  @Enumerated(EnumType.name)
  late SyncStatus syncStatus;
  late int syncAttempts;
  String? syncError;

  late bool isEdited;

  late DateTime createdAt;
  late DateTime updatedAt;
}
```

**`packages/fleetfuel_core/lib/models/local/local_location_ping.dart`**

```dart
import 'package:isar/isar.dart';

part 'local_location_ping.g.dart';

@collection
class LocalLocationPing {
  Id isarId = Isar.autoIncrement;

  String? firestoreId;

  @Index(unique: true)
  late String localId;

  late String driverId;
  late String vehicleId;
  late String companyId;
  late String assignmentId;

  late double latitude;
  late double longitude;
  late double accuracy;
  late double altitude;
  late double speed;
  late double bearing;
  late String geohash;

  late String activity;
  late bool isMoving;
  late int batteryLevel;
  late bool isCharging;
  late String networkType;

  @Enumerated(EnumType.name)
  late SyncStatus syncStatus;

  late DateTime recordedAt;
  DateTime? syncedAt;
}
```

### 3.4 Firebase Service Classes

**`packages/fleetfuel_core/lib/services/firestore_service.dart`**

Implement these methods:
```dart
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Companies
  Future<CompanyModel?> getCompanyByCode(String code);
  Future<void> addDriverToCompany(String companyId, String driverId);
  Stream<CompanyModel?> watchCompany(String companyId);

  // Users
  Future<void> createUser(UserModel user);
  Future<UserModel?> getUser(String userId);
  Future<void> updateUser(String userId, Map<String, dynamic> data);
  Stream<UserModel?> watchUser(String userId);

  // Vehicles
  Stream<VehicleModel?> watchAssignedVehicle(String driverId);

  // Vehicle Assignments
  Future<VehicleAssignmentModel?> getActiveAssignment(String driverId);
  Stream<List<VehicleAssignmentModel>> watchAllAssignments(String driverId);

  // Logs
  Future<void> createLog(LogModel log);
  Future<void> updateLog(String logId, Map<String, dynamic> data);
  Stream<List<LogModel>> watchLogs(String driverId, {int limit = 20});
  Future<List<LogModel>> getMoreLogs(String driverId, DocumentSnapshot lastDoc);

  // Location Pings
  Future<void> createLocationPing(LocationPingModel ping);
  Future<void> batchCreateLocationPings(List<LocationPingModel> pings);
}
```

**`packages/fleetfuel_core/lib/services/storage_service.dart`**

```dart
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload single image, return download URL
  // path example: 'companies/{companyId}/logs/{logId}/odometer.jpg'
  Future<String> uploadImage(String localPath, String storagePath);

  // Upload multiple images, return list of URLs
  Future<List<String>> uploadMultipleImages(
    List<String> localPaths,
    String storageBasePath,
    String filePrefix,
  );

  // Delete image by URL
  Future<void> deleteImage(String downloadUrl);
}
```

**`packages/fleetfuel_core/lib/services/sync_service.dart`**

This is critical. Implement exactly as described:

```dart
class SyncService {
  final Isar _isar;
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  SyncService(this._isar, this._firestoreService, this._storageService);

  // Call this on app start and on connectivity restored
  Future<void> syncAll() async {
    await _syncPendingLogs();
    await _syncPendingPings();
  }

  // Sync one pending log:
  // 1. Upload local images → get Storage URLs
  // 2. Update local log with URLs
  // 3. Write Firestore document
  // 4. Mark local log as synced
  // Retry on failure up to 5 times with exponential backoff
  Future<void> _syncPendingLogs();

  // Batch upload pending pings to Firestore
  // Use Firestore batch writes (max 500 per batch)
  Future<void> _syncPendingPings();

  // Save a new log locally (called when driver submits)
  Future<void> saveLogLocally(LocalLog log);

  // Save a new ping locally (called by GPS service)
  Future<void> savePingLocally(LocalLocationPing ping);
}
```

### 3.5 Utils

**`packages/fleetfuel_core/lib/utils/constants.dart`**
```dart
class AppConstants {
  static const String appName = 'FleetFuel360';
  static const String driverAppId = 'com.fleetfuel360.driver';
  static const int locationPingIntervalSeconds = 60;
  static const int maxSyncAttempts = 5;
  static const int maxImageSizeBytes = 800 * 1024; // 800KB
  static const int maxImageWidthPx = 1024;
  static const String defaultCurrency = 'INR';
  static const String defaultTimezone = 'Asia/Kolkata';
}
```

**`packages/fleetfuel_core/lib/utils/formatters.dart`**
```dart
class AppFormatters {
  // Format amount from paise to display: 150000 → "₹1,500.00"
  static String formatAmount(int paise, {String currency = 'INR'});
  
  // Format DateTime to display: "15 Jan 2025, 3:45 PM"
  static String formatDateTime(DateTime dt);
  
  // Format DateTime to relative: "2 hours ago", "Yesterday"
  static String formatRelative(DateTime dt);
  
  // Format km reading: 45230 → "45,230 km"
  static String formatOdometer(int reading);
  
  // Format litres: 35.5 → "35.5 L"
  static String formatLitres(double litres);
}
```

After building the core package, run:
```bash
cd packages/fleetfuel_core
dart run build_runner build --delete-conflicting-outputs
```

Verify generated files exist for all Freezed models and Isar collections.

---

## STEP 4 — Build Driver App

### 4.1 App Entry Point

**`apps/driver_app/lib/main.dart`**
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Isar
  final isar = await Isar.open([
    LocalLogSchema,
    LocalLocationPingSchema,
  ]);
  
  // Background Geolocation — configure but don't start yet
  await BackgroundGeolocation.ready(Config(
    desiredAccuracy: Config.DESIRED_ACCURACY_HIGH,
    distanceFilter: 50,
    stopOnTerminate: false,
    startOnBoot: true,
    enableHeadless: true,
    heartbeatInterval: 60,
    preventSuspend: true,
    logLevel: Config.LOG_LEVEL_WARNING,
    backgroundPermissionRationale: PermissionRationale(
      title: "Allow FleetFuel360 to track your location",
      message: "Required so your manager can see trip logs and verify expense locations.",
      positiveAction: "Allow Always",
      negativeAction: "Cancel",
    ),
  ));
  
  // Register headless task
  BackgroundGeolocation.registerHeadlessTask(headlessTask);
  
  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const DriverApp(),
    ),
  );
}

// Headless task — runs when app is killed
@pragma('vm:entry-point')
void headlessTask(HeadlessEvent headlessEvent) async {
  if (headlessEvent.name == Event.LOCATION) {
    final location = headlessEvent.event as bg.Location;
    // Save ping to Isar, attempt Firestore write
    // Implementation in tracking feature
  }
}
```

### 4.2 App Router (GoRouter)

**`apps/driver_app/lib/core/router/app_router.dart`**

Routes:
```dart
/ → SplashScreen
/login → LoginScreen
/kyc → KYCScreen
/company-join → CompanyJoinScreen
/home → HomeScreen (ShellRoute with bottom nav)
  /home/logs → LogsListScreen
  /home/vehicle → VehicleScreen
  /home/ledger → LedgerScreen
/log/add → AddLogFlow (step 1)
/log/add/media → AddLogMediaScreen (step 2)
/log/add/details → AddLogDetailsScreen (step 3)
/log/add/review → AddLogReviewScreen (step 4)
/log/:logId → LogDetailScreen
/log/:logId/edit → EditLogScreen
/settings → SettingsScreen
```

Redirect logic:
```dart
redirect: (context, state) {
  final authState = ref.read(authStateProvider);
  final user = ref.read(currentUserProvider);
  
  if (authState == AuthState.loading) return '/'; // stay on splash
  if (authState == AuthState.unauthenticated) return '/login';
  if (!user.kycCompleted) return '/kyc';
  if (user.companyId == null) return '/company-join';
  return null; // allow navigation
}
```

### 4.3 Theme

**`apps/driver_app/lib/core/theme/app_theme.dart`**

```dart
class AppTheme {
  static const Color primary = Color(0xFF1A73E8);
  static const Color accent = Color(0xFFFF6B35);
  static const Color expense = Color(0xFFE53935);
  static const Color income = Color(0xFF43A047);
  static const Color fuel = Color(0xFF1565C0);
  static const Color neutral = Color(0xFF757575);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
    // Configure AppBar, Card, BottomNavBar, FloatingActionButton, InputDecoration
    // All themed consistently
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
  );
}
```

### 4.4 Riverpod Providers

**`apps/driver_app/lib/core/di/providers.dart`**

Define all global providers:
```dart
// Isar instance
final isarProvider = Provider<Isar>((ref) => throw UnimplementedError());

// Services
final firestoreServiceProvider = Provider((ref) => FirestoreService());
final storageServiceProvider = Provider((ref) => StorageService());
final syncServiceProvider = Provider((ref) => SyncService(
  ref.watch(isarProvider),
  ref.watch(firestoreServiceProvider),
  ref.watch(storageServiceProvider),
));
final authServiceProvider = Provider((ref) => AuthService());

// Auth state
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// Current user from Firestore
final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);
      return ref.watch(firestoreServiceProvider).watchUser(user.uid);
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});

// Connectivity
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged;
});

// Trigger sync on connectivity change
final syncTriggerProvider = Provider((ref) {
  ref.listen(connectivityProvider, (previous, next) {
    next.whenData((result) {
      if (result != ConnectivityResult.none) {
        ref.read(syncServiceProvider).syncAll();
      }
    });
  });
});
```

---

## STEP 5 — Build Each Screen

Build screens in this exact order. Complete each screen fully before moving to the next.

### Order:
1. SplashScreen
2. LoginScreen
3. KYCScreen
4. CompanyJoinScreen
5. HomeScreen (shell + bottom nav)
6. Add Log Flow (all 4 steps)
7. LogsListScreen
8. LogDetailScreen
9. EditLogScreen
10. VehicleScreen
11. LedgerScreen
12. SettingsScreen

### Screen Implementation Rules:
- Each screen in `features/{feature}/presentation/{screen_name}.dart`
- Each screen has a corresponding Riverpod provider/notifier in `features/{feature}/data/`
- Use `ConsumerWidget` or `ConsumerStatefulWidget` — never `StatefulWidget` alone
- Show `CircularProgressIndicator` while loading
- Show error widget with retry button on errors
- Show empty state widget when list is empty
- All amounts displayed via `AppFormatters.formatAmount()`
- All dates via `AppFormatters.formatRelative()`
- All network images via `CachedNetworkImage` with shimmer placeholder

---

## STEP 6 — Build Add Log Flow (Most Critical Feature)

### State — `AddLogNotifier`

```dart
@riverpod
class AddLogNotifier extends _$AddLogNotifier {
  @override
  AddLogState build() => const AddLogState();

  void selectLogType(LogType type) => state = state.copyWith(logType: type);
  void setOdometerImagePath(String path) => ...;
  void setFuelMeterImagePath(String path) => ...;
  void addReceiptImagePath(String path) => ...;
  void setVehicleImagePath(String path) => ...;
  void setAmount(int paise) => ...;
  void setOdometerReading(int km) => ...;
  void setFuelQuantity(double litres) => ...;
  void setFuelPrice(double pricePerLitre) => ...;
  void setCategory(LogCategory category) => ...;
  void setDescription(String desc) => ...;
  void setNotes(String notes) => ...;
  void setPaidBy(PaidBy paidBy) => ...;
  void setPaymentMode(PaymentMode mode) => ...;

  Future<void> submit() async {
    state = state.copyWith(isSubmitting: true, error: null);
    
    try {
      // 1. Get GPS location (timeout 10 seconds)
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10),
        );
      } catch (e) {
        // GPS failed — log without location, set warning
        position = Position(...zeros...);
        state = state.copyWith(locationWarning: 'Could not get GPS location');
      }

      // 2. Reverse geocode
      String address = '';
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
        );
        address = _formatAddress(placemarks.first);
      } catch (_) {}

      // 3. Get device context
      final battery = await Battery().batteryLevel;
      final isCharging = await Battery().batteryState == BatteryState.charging;
      final connectivity = await Connectivity().checkConnectivity();

      // 4. Build LocalLog
      final localLog = LocalLog()
        ..localId = const Uuid().v4()
        ..driverId = ref.read(currentUserProvider).value!.userId
        ..vehicleId = ref.read(currentAssignmentProvider).value!.vehicleId
        ..companyId = ref.read(currentUserProvider).value!.companyId!
        ..assignmentId = ref.read(currentAssignmentProvider).value!.assignmentId
        ..logType = state.logType!.name
        ..category = state.category.name
        ..amount = state.amount
        ..currency = 'INR'
        ..paidBy = state.paidBy.name
        ..paymentMode = state.paymentMode.name
        ..description = state.description
        ..notes = state.notes
        ..localReceiptImagePaths = state.receiptImagePaths
        ..localOdometerImagePath = state.odometerImagePath
        ..localFuelMeterImagePath = state.fuelMeterImagePath
        ..localVehicleImagePath = state.vehicleImagePath
        ..receiptImageUrls = []
        ..odometerReading = state.odometerReading
        ..fuelQuantityLitres = state.fuelQuantityLitres
        ..fuelPricePerLitre = state.fuelPricePerLitre
        ..latitude = position.latitude
        ..longitude = position.longitude
        ..accuracy = position.accuracy
        ..address = address
        ..geohash = Geohash.encode(position.latitude, position.longitude)
        ..speed = position.speed
        ..bearing = position.heading
        ..altitude = position.altitude
        ..batteryLevel = battery
        ..isCharging = isCharging
        ..networkType = connectivity.name
        ..syncStatus = SyncStatus.pending
        ..syncAttempts = 0
        ..isEdited = false
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      // 5. Save to Isar
      await ref.read(syncServiceProvider).saveLogLocally(localLog);

      // 6. If online, attempt immediate sync
      if (connectivity != ConnectivityResult.none) {
        ref.read(syncServiceProvider).syncAll(); // don't await — let it run
      }

      state = state.copyWith(isSubmitting: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
    }
  }
}
```

### Step 1 Screen — Log Type Selection
- Display 6 cards in a 2x3 grid
- Each card: colored icon + label + brief description
- No Next button — tapping a card immediately advances to Step 2
- Show progress: step 1 of 4

### Step 2 Screen — Media Capture
- Show/hide sections based on logType:
  - Odometer: always shown
  - Fuel Meter: only for `fuelFill`
  - Receipts: for `cashExpense`, `paymentReceived`
  - Vehicle: shown as optional for all types
- Each section: large dashed-border capture area
  - Tap → show bottom sheet: "Camera" / "Gallery" 
  - After capture: show thumbnail with X to remove
- Compress image immediately on capture
- "Continue" button at bottom — active even if no photos taken
- If no photos: show warning "Adding photos helps verify your log"
- Progress: step 2 of 4

### Step 3 Screen — Details Form
- Dynamic based on logType (see SPEC section 7.3)
- Amount field: numeric keyboard, shows ₹ prefix
- All fields validated before Next
- "Continue" button — disabled until required fields filled
- Progress: step 3 of 4

### Step 4 Screen — Review & Submit
- Show all entered data in clean summary cards
- Show photo thumbnails (tap to expand)
- Show "Detecting location..." spinner → resolve to address
- Large "Submit Log" button
- If submitting: show loading overlay
- On success: navigate to Home, show success toast
- On failure: show error, allow retry
- Progress: step 4 of 4

---

## STEP 7 — Background GPS Tracking Service

**`apps/driver_app/lib/features/tracking/tracking_service.dart`**

```dart
class TrackingService {
  final SyncService _syncService;
  final FirestoreService _firestoreService;
  final Isar _isar;

  TrackingService(this._syncService, this._firestoreService, this._isar);

  Future<void> startTracking() async {
    // Check permissions first
    final status = await Permission.locationAlways.status;
    if (!status.isGranted) {
      await Permission.locationAlways.request();
    }

    BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
    BackgroundGeolocation.onHeartbeat(_onHeartbeat);
    BackgroundGeolocation.onConnectivityChange(_onConnectivity);

    await BackgroundGeolocation.start();
  }

  Future<void> stopTracking() async {
    await BackgroundGeolocation.stop();
  }

  void _onLocation(bg.Location location) async {
    final ping = _buildPing(location);
    await _syncService.savePingLocally(ping);
    
    // Attempt immediate sync if connected
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      await _syncService.syncAll();
    }
  }

  void _onHeartbeat(bg.HeartbeatEvent event) {
    // Force a location reading on heartbeat
    BackgroundGeolocation.getCurrentPosition(
      samples: 1,
      persist: true,
    );
  }

  void _onConnectivity(bg.ConnectivityChangeEvent event) {
    if (event.connected) {
      _syncService.syncAll();
    }
  }

  void _onLocationError(bg.LocationError error) {
    // Log error, do not crash
    debugPrint('Location error: ${error.code} - ${error.message}');
  }

  LocalLocationPing _buildPing(bg.Location location) {
    // Build LocalLocationPing from bg.Location
    // Pull driverId, vehicleId, companyId, assignmentId from Isar cached user data
    // These must be stored locally so headless task can access them without Firestore
  }
}
```

**IMPORTANT:** Store driver/vehicle/company/assignment IDs in Isar when user logs in so the headless task (running without app context) can access them.

---

## STEP 8 — Home Screen Implementation

```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final vehicle = ref.watch(assignedVehicleProvider);
    final recentLogs = ref.watch(recentLogsProvider);
    final balance = ref.watch(driverBalanceProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // Company name center, avatar right
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              VehicleCard(vehicle: vehicle.value),
              const SizedBox(height: 16),
              BalanceCard(balance: balance.value),
              const SizedBox(height: 16),
              QuickActionsRow(onAddFuel: ..., onAddExpense: ..., onAddPayment: ..., onViewLogs: ...),
              const SizedBox(height: 16),
              RecentActivitySection(logs: recentLogs.value ?? []),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/log/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Log'),
        backgroundColor: AppTheme.accent,
      ),
    );
  }
}
```

**`driverBalanceProvider`** — derived from logs:
```dart
final driverBalanceProvider = StreamProvider<int>((ref) {
  // Returns running balance in paise
  // = SUM(cash_expense where paidBy==driver) - SUM(payment_received) - SUM(advance)
  // Subscribe to logs stream, compute on each emit
});
```

---

## STEP 9 — Ledger Screen

**Ledger logic:**
```dart
// Each ledger entry is derived from a LogModel
// DR entries: logType == cashExpense && paidBy == driver
// CR entries: logType == paymentReceived || logType == advance
// Running balance computed sequentially, sorted by createdAt ASC
```

Display as a list where each item shows:
- Date
- Description / category
- DR amount (red) or CR amount (green)
- Running balance after this entry

Summary card at top: total DR, total CR, net balance.

---

## STEP 10 — Firebase Configuration Files

### `firebase/firestore.rules`
Paste exact rules from SPEC section 11.

### `firebase/storage.rules`
Paste exact rules from SPEC section 11.

### `firebase/firestore.indexes.json`
Paste exact indexes from SPEC section 5.7.

### `firebase/functions/src/index.ts`
```typescript
import * as functions from 'firebase-functions';

// STUB — Phase 2 will implement image extraction here
export const onLogImageUploaded = functions.storage
  .object()
  .onFinalize(async (object) => {
    // TODO Phase 2: Call Vision API for OCR extraction
    // Object path pattern: companies/{companyId}/logs/{logId}/{filename}
    console.log('Image uploaded:', object.name);
  });
```

---

## STEP 11 — Permissions & Android Configuration

### `apps/driver_app/android/app/src/main/AndroidManifest.xml`
Add all permissions from SPEC section 13.

Add background location service:
```xml
<service
  android:name="com.transistorsoft.locationmanager.service.TrackingService"
  android:foregroundServiceType="location" />
```

### Battery Optimization
Guide user to disable battery optimization on first launch:
```dart
Future<void> requestBatteryOptimizationExemption() async {
  if (Platform.isAndroid) {
    final status = await Permission.ignoreBatteryOptimizations.status;
    if (!status.isGranted) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }
}
```

---

## STEP 12 — Offline Sync Verification

Write a test flow to verify offline sync works:

1. Enable airplane mode
2. Create a log entry
3. Verify log appears in Isar with `SyncStatus.pending`
4. Verify log appears in home screen (read from Isar, not Firestore)
5. Disable airplane mode
6. Verify sync triggers automatically
7. Verify log in Firestore console
8. Verify local log `syncStatus` updated to `SyncStatus.synced`

---

## STEP 13 — Manager App Placeholder

`apps/manager_app/lib/main.dart`:
```dart
import 'package:flutter/material.dart';

void main() => runApp(const ManagerPlaceholderApp());

class ManagerPlaceholderApp extends StatelessWidget {
  const ManagerPlaceholderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FleetFuel360 Companies',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('FleetFuel360 Companies', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              const Text('Phase 2 — Coming Soon'),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Critical Rules for the Agent

1. **Never invent package APIs.** If unsure of an exact method signature, check pub.dev documentation.
2. **Never skip error handling.** Every `Future` must have a `try/catch`. Every stream must handle errors.
3. **Never hardcode user IDs or company IDs.** Always read from providers.
4. **Never write to Firestore directly from a screen.** Always go through service classes.
5. **Always save to Isar before attempting Firestore write.** Offline safety first.
6. **Never assume internet is available.** Check connectivity before every Firestore operation.
7. **All money amounts are integers (paise).** Never use `double` for amounts. Convert on display only.
8. **All Timestamps from Firestore must be converted to `DateTime` in `fromFirestore()`.** Never pass raw `Timestamp` objects to the UI layer.
9. **Run `build_runner` after every change to Freezed or Isar models.** Never commit generated files with stale code.
10. **Every screen must handle 3 states: loading, error, data.** No exceptions.

---

## Build Order Summary

```
1. Scaffold monorepo structure ✓
2. Configure all pubspec.yaml files ✓
3. Build fleetfuel_core models (Freezed + Isar) ✓
4. Run build_runner ✓
5. Build service classes ✓
6. Configure Firebase in driver_app ✓
7. Build GoRouter ✓
8. Build AppTheme ✓
9. Build all Riverpod providers ✓
10. Build SplashScreen ✓
11. Build LoginScreen + AuthService ✓
12. Build KYCScreen ✓
13. Build CompanyJoinScreen ✓
14. Build HomeScreen shell + bottom nav ✓
15. Build Add Log Flow (4 steps) ✓
16. Build LogsListScreen ✓
17. Build LogDetailScreen ✓
18. Build EditLogScreen ✓
19. Build VehicleScreen ✓
20. Build LedgerScreen ✓
21. Build SettingsScreen ✓
22. Build TrackingService ✓
23. Build SyncService ✓
24. Configure Firebase rules + indexes ✓
25. Configure AndroidManifest permissions ✓
26. Scaffold manager_app placeholder ✓
27. Verify offline sync flow ✓
```

When complete, the driver app must satisfy every item in the Definition of Done (SPEC section 17).
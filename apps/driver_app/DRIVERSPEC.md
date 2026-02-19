# FleetFuel360 — Master Specification Document
**Version:** 1.0  
**Last Updated:** February 2026  
**Scope:** Driver App (Phase 1) + Shared Backend  
**Read this entire document before writing a single line of code.**

---

## 1. Product Overview

FleetFuel360 is a dual-app fleet management system:
- **FleetFuel360 Drivers** — Used by drivers to log fuel, expenses, and track their activity
- **FleetFuel360 Companies** — Used by fleet managers to monitor drivers, vehicles, logs, and finances

**Phase 1 builds:** Shared Firebase backend + Driver App only.  
**Phase 2 builds:** Manager App (after Driver App is complete and tested).

The apps are separate Flutter projects inside a monorepo, sharing a common Dart package.

---

## 2. Monorepo Folder Structure

```
fleetfuel360/
│
├── apps/
│   ├── driver_app/               ← FleetFuel360 Drivers (Play Store)
│   │   ├── android/
│   │   ├── ios/
│   │   ├── lib/
│   │   │   ├── main.dart
│   │   │   ├── app.dart
│   │   │   ├── core/
│   │   │   │   ├── di/           ← Dependency injection (Riverpod providers)
│   │   │   │   ├── router/       ← GoRouter configuration
│   │   │   │   ├── theme/        ← AppTheme, colors, text styles
│   │   │   │   └── constants/    ← App-wide constants
│   │   │   └── features/
│   │   │       ├── auth/
│   │   │       │   ├── data/
│   │   │       │   ├── domain/
│   │   │       │   └── presentation/
│   │   │       ├── home/
│   │   │       ├── add_log/
│   │   │       ├── logs/
│   │   │       ├── vehicle/
│   │   │       ├── ledger/
│   │   │       ├── settings/
│   │   │       └── tracking/     ← Background GPS service
│   │   └── pubspec.yaml
│   │
│   └── manager_app/              ← Phase 2, scaffold only in Phase 1
│       ├── lib/
│       │   └── main.dart         ← Placeholder only
│       └── pubspec.yaml
│
├── packages/
│   └── fleetfuel_core/           ← Shared Dart package
│       ├── lib/
│       │   ├── models/           ← All Firestore data models
│       │   ├── services/         ← FirestoreService, StorageService, AuthService
│       │   ├── utils/            ← Formatters, validators, constants
│       │   └── fleetfuel_core.dart  ← Barrel export file
│       └── pubspec.yaml
│
├── firebase/
│   ├── firestore.rules
│   ├── storage.rules
│   ├── firestore.indexes.json
│   └── functions/
│       ├── src/
│       │   └── index.ts          ← Cloud Functions (Phase 1: empty stubs)
│       └── package.json
│
├── SPEC.md                       ← This file
├── .gitignore
└── README.md
```

---

## 3. Tech Stack — Locked, Do Not Deviate

### Flutter & Dart
- Flutter: stable channel, latest stable version
- Dart: bundled with Flutter

### Firebase Services Used
| Service | Purpose |
|---|---|
| Firebase Auth | Google Sign-In (Phone Auth in future) |
| Cloud Firestore | All structured data |
| Firebase Storage | All images (receipts, odometer, vehicle photos) |
| Cloud Functions | Background triggers (stubs in Phase 1) |
| FCM | Push notifications |
| Remote Config | Feature flags |

### Flutter Packages — Driver App
```yaml
# State Management
flutter_riverpod: ^2.x
riverpod_annotation: ^2.x

# Navigation
go_router: ^13.x

# Firebase
firebase_core: ^3.x
firebase_auth: ^5.x
cloud_firestore: ^5.x
firebase_storage: ^12.x
firebase_messaging: ^15.x

# Google Sign-In
google_sign_in: ^6.x

# Background GPS (CRITICAL)
flutter_background_geolocation: ^4.x   # Paid plugin — use transistorsoft version
# Fallback if above not available: background_locator_2

# Maps
google_maps_flutter: ^2.x
geolocator: ^12.x
geocoding: ^3.x

# Local Database (offline queue)
isar: ^3.x
isar_flutter_libs: ^3.x
path_provider: ^2.x

# Image
image_picker: ^1.x
flutter_image_compress: ^2.x
cached_network_image: ^3.x

# UI & Utilities
intl: ^0.19.x
shimmer: ^3.x
lottie: ^3.x
connectivity_plus: ^6.x
device_info_plus: ^10.x
battery_plus: ^6.x
permission_handler: ^11.x
package_info_plus: ^8.x
url_launcher: ^6.x
share_plus: ^9.x

# Code Generation
build_runner: ^2.x
riverpod_generator: ^2.x
isar_generator: ^3.x
json_annotation: ^4.x
json_serializable: ^6.x
freezed_annotation: ^2.x
freezed: ^2.x
```

### Shared Package (`fleetfuel_core`) Dependencies
```yaml
dependencies:
  cloud_firestore: ^5.x
  firebase_storage: ^12.x
  firebase_auth: ^5.x
  freezed_annotation: ^2.x
  json_annotation: ^4.x
  isar: ^3.x
```

---

## 4. Firebase Project Configuration

- **One Firebase project** for both apps
- **Two Android apps** registered in the project:
  - `com.fleetfuel360.driver`
  - `com.fleetfuel360.manager` (registered now, app built in Phase 2)
- **Two iOS apps** registered similarly
- Each Flutter app has its own `google-services.json` and `GoogleService-Info.plist`

---

## 5. Firestore Database Schema

> **RULE:** Every document must have `createdAt`, `updatedAt` as Firestore Timestamps.  
> **RULE:** No nested subcollections unless specified. Use flat collections with IDs for references.  
> **RULE:** All amounts are stored in the smallest currency unit (paise for INR, cents for USD). Display layer converts.

### 5.1 `/companies/{companyId}`
```
{
  companyId: string,           // Auto-generated Firestore ID
  name: string,
  companyCode: string,         // 6-character unique join code (uppercase)
  managerId: string,           // userId of the owner
  memberDriverIds: string[],   // Array of driver userIds
  vehicleIds: string[],        // Array of vehicleIds
  currency: string,            // "INR" default
  timezone: string,            // "Asia/Kolkata" default
  isActive: boolean,
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

### 5.2 `/users/{userId}`
```
{
  userId: string,              // Firebase Auth UID
  name: string,
  email: string,
  phoneNumber: string,         // Driver's phone — becomes their visible Driver ID
  profileImageUrl: string,
  role: "driver" | "manager",
  companyId: string,           // null until they join a company
  companyCode: string,         // code used to join
  licenseNumber: string,
  licenseImageUrl: string,
  kycCompleted: boolean,
  isActive: boolean,
  fcmToken: string,            // Updated on every app open
  appVersion: string,
  deviceInfo: {
    model: string,
    os: string,
    osVersion: string
  },
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

### 5.3 `/vehicles/{vehicleId}`
```
{
  vehicleId: string,
  companyId: string,
  registrationNumber: string,  // e.g. "MH12AB1234"
  make: string,                // e.g. "Tata"
  model: string,               // e.g. "Ace"
  year: number,
  fuelType: "petrol" | "diesel" | "cng" | "electric",
  vehicleType: "truck" | "van" | "car" | "bike" | "other",
  vehicleImageUrl: string,
  currentDriverId: string,     // null if unassigned
  currentAssignmentId: string, // null if unassigned
  tankCapacityLitres: number,
  isActive: boolean,
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

### 5.4 `/vehicleAssignments/{assignmentId}`
```
{
  assignmentId: string,
  vehicleId: string,
  driverId: string,
  companyId: string,
  startDate: Timestamp,
  endDate: Timestamp,         // null if currently active
  isActive: boolean,
  assignedByManagerId: string,
  startOdometerReading: number,
  endOdometerReading: number, // null if active
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

### 5.5 `/logs/{logId}` — CORE COLLECTION
```
{
  logId: string,
  driverId: string,
  vehicleId: string,
  companyId: string,
  assignmentId: string,

  // Log Classification
  logType: "fuel_fill" | "cash_expense" | "payment_received" | "advance" | "loan" | "other",
  category: "fuel" | "repair" | "food" | "toll" | "tyre" | "oil" | "cleaning" | "fine" | "other",
  
  // Money
  amount: number,              // In paise/cents
  currency: string,            // "INR"
  paidBy: "driver" | "company",
  paymentMode: "cash" | "upi" | "card" | "fuel_card" | "other",
  
  // Description
  description: string,
  notes: string,

  // Images — all optional except one is recommended
  receiptImageUrls: string[],        // Array of Firebase Storage URLs
  odometerImageUrl: string,          // URL or null
  fuelMeterImageUrl: string,         // URL or null (fuel logs)
  vehicleImageUrl: string,           // URL or null

  // Readings — manually entered by driver
  odometerReading: number,           // km reading at time of log
  fuelQuantityLitres: number,        // For fuel logs
  fuelPricePerLitre: number,         // For fuel logs

  // Location — auto-captured, never manual
  location: {
    latitude: number,
    longitude: number,
    accuracy: number,                // metres
    address: string,                 // Reverse geocoded string
    geohash: string                  // For geo queries
  },

  // Device context — auto-captured
  deviceContext: {
    speed: number,                   // km/h at time of log
    bearing: number,
    altitude: number,
    batteryLevel: number,            // 0-100
    isCharging: boolean,
    networkType: "wifi" | "mobile" | "none",
    signalStrength: string
  },

  // V2 Extraction Fields — null in MVP, filled by Cloud Function in V2
  odometerReadingExtracted: number,  // null
  fuelLevelExtracted: number,        // null
  receiptAmountExtracted: number,    // null
  extractionConfidence: number,      // null

  // Edit History
  isEdited: boolean,
  editHistory: [                     // Append-only array
    {
      editedAt: Timestamp,
      editedByDriverId: string,
      previousValues: {},            // Snapshot of changed fields before edit
      reason: string
    }
  ],

  // Sync State (managed locally, not sent to Firestore)
  // See Isar local model for offline tracking

  status: "active" | "deleted",
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

### 5.6 `/locationPings/{pingId}` — HIGH VOLUME COLLECTION
```
{
  pingId: string,
  driverId: string,
  vehicleId: string,
  companyId: string,
  assignmentId: string,

  location: {
    latitude: number,
    longitude: number,
    accuracy: number,
    altitude: number,
    speed: number,               // m/s — convert to km/h in display
    bearing: number,
    geohash: string
  },

  activity: "driving" | "stationary" | "walking" | "unknown",
  isMoving: boolean,

  deviceContext: {
    batteryLevel: number,
    isCharging: boolean,
    networkType: "wifi" | "mobile" | "none"
  },

  recordedAt: Timestamp,         // When GPS captured it
  syncedAt: Timestamp,           // When it was written to Firestore
  createdAt: Timestamp
}
```

> **Index required:** `(driverId, recordedAt DESC)` and `(companyId, recordedAt DESC)`  
> **Retention:** Pings older than 90 days archived via Cloud Function (Phase 2)

### 5.7 Firestore Indexes (firestore.indexes.json)
```json
{
  "indexes": [
    {
      "collectionGroup": "logs",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "driverId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "logs",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "vehicleId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "logs",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyId", "order": "ASCENDING" },
        { "fieldPath": "logType", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "locationPings",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "driverId", "order": "ASCENDING" },
        { "fieldPath": "recordedAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "vehicleAssignments",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "driverId", "order": "ASCENDING" },
        { "fieldPath": "isActive", "order": "ASCENDING" },
        { "fieldPath": "startDate", "order": "DESCENDING" }
      ]
    }
  ]
}
```

---

## 6. Offline-First Architecture

**The app must work fully without internet.** Logs created offline must sync when internet returns. GPS pings captured offline must batch-sync when internet returns.

### Local Database (Isar)

Two local collections:

#### `LocalLog` (Isar)
```dart
@collection
class LocalLog {
  Id isarId = Isar.autoIncrement;
  
  String? firestoreId;          // null until synced
  String localId;               // UUID generated on device
  String driverId;
  String vehicleId;
  String companyId;
  String assignmentId;
  
  String logType;
  String category;
  int amount;
  String currency;
  String paidBy;
  String paymentMode;
  String description;
  String notes;
  
  // Local image paths (before upload)
  List<String> localReceiptImagePaths;
  String? localOdometerImagePath;
  String? localFuelMeterImagePath;
  String? localVehicleImagePath;
  
  // Firebase Storage URLs (after upload)
  List<String> receiptImageUrls;
  String? odometerImageUrl;
  String? fuelMeterImageUrl;
  String? vehicleImageUrl;
  
  int odometerReading;
  double fuelQuantityLitres;
  double fuelPricePerLitre;
  
  double latitude;
  double longitude;
  double accuracy;
  String address;
  String geohash;
  
  double speed;
  double bearing;
  double altitude;
  int batteryLevel;
  bool isCharging;
  String networkType;
  
  // Sync state
  @enumerated
  SyncStatus syncStatus;        // pending | uploading | synced | failed
  int syncAttempts;
  String? syncError;
  
  DateTime createdAt;
  DateTime updatedAt;
}

enum SyncStatus { pending, uploading, synced, failed }
```

#### `LocalLocationPing` (Isar)
```dart
@collection
class LocalLocationPing {
  Id isarId = Isar.autoIncrement;
  
  String? firestoreId;
  String localId;
  String driverId;
  String vehicleId;
  String companyId;
  String assignmentId;
  
  double latitude;
  double longitude;
  double accuracy;
  double altitude;
  double speed;
  double bearing;
  String geohash;
  
  String activity;
  bool isMoving;
  int batteryLevel;
  bool isCharging;
  String networkType;
  
  @enumerated
  SyncStatus syncStatus;
  
  DateTime recordedAt;
  DateTime? syncedAt;
}
```

### Sync Service
- On app start: check connectivity, sync all `SyncStatus.pending` local records
- On connectivity change (ConnectivityPlus): trigger sync
- Sync order: upload images first → get URLs → write Firestore doc → update local `syncStatus` to `synced`
- Retry logic: exponential backoff, max 5 attempts, then mark `failed`
- Never delete local records after sync (keep for 30 days, then prune)

---

## 7. Driver App — Screen Inventory

### 7.1 Auth Flow

**Screen: SplashScreen**
- Show app logo + animated loading
- Check auth state via FirebaseAuth
- If logged in + KYC complete + company joined → go to Home
- If logged in + KYC incomplete → go to KYC
- If logged in + no company → go to CompanyJoin
- If not logged in → go to Login

**Screen: LoginScreen**
- Full screen with app logo and tagline
- Single button: "Continue with Google"
- Design: Clean, dark background, brand colors
- On success: check user doc in Firestore → route appropriately

**Screen: KYCScreen**
- Fields:
  - Full Name (text)
  - Phone Number (text, numeric, becomes Driver ID)
  - License Number (text)
  - License Photo (image picker)
- Validation: all fields required
- On submit: create `/users/{uid}` document, set `kycCompleted: true`

**Screen: CompanyJoinScreen**
- Single input: Company Code (6 characters, auto-uppercase)
- Button: "Join Company"
- On submit: query `/companies` where `companyCode == input`
- If found: add driverId to `company.memberDriverIds`, set `user.companyId`
- If not found: show error "Invalid company code"
- On success: go to Home

---

### 7.2 Home Screen

**Layout (bottom-up scroll):**

1. **Header Bar**
   - Left: App logo / hamburger
   - Center: Company name
   - Right: Driver avatar → taps to Settings

2. **Vehicle Card** (top of scroll)
   - Vehicle thumbnail image
   - Registration number (large, bold)
   - Make + Model + Year
   - Assigned since date
   - If no vehicle assigned: placeholder card "No vehicle assigned"

3. **Balance Card**
   - Driver's running balance (money owed to driver or paid)
   - Breakdown: "You are owed: ₹X" or "Company owes you: ₹X"
   - Calculated from: sum of `cash_expense` by driver MINUS sum of `payment_received`
   - Tap → go to Ledger

4. **Quick Actions Row**
   - 4 icon buttons: Add Fuel | Add Expense | Record Payment | View All Logs

5. **Recent Activity Feed**
   - Last 10 logs from Firestore (real-time listener)
   - Each log item shows:
     - Left: Map thumbnail (static Google Maps image at log's lat/lng, size 60x60)
     - Center: Log type label + category + description
     - Right: Amount (colored: red for expense, green for received)
     - Below: Timestamp + odometer reading
   - Footer: "View All Logs →" link

**FAB (Floating Action Button):**
- Bottom-right
- "+" icon
- Taps to Add Log flow (Step 1)

---

### 7.3 Add Log Flow (Multi-Step)

> This is the most critical feature. Each step is a separate screen pushed onto the navigation stack. A progress indicator (step 1 of 4) shows at top.

**Step 1: SelectLogTypeScreen**
- Title: "What are you logging?"
- Grid of options (2x3 cards with icon + label):
  - 🔴 Fuel Fill
  - 🟠 Cash Expense (Driver paid)
  - 🟢 Payment Received (Owner paid me)
  - 🔵 Advance Received
  - 🟣 Loan/Credit
  - ⚪ Other
- On select: store type, go to Step 2

**Step 2: CaptureMediaScreen**
- Title: "Capture Evidence"
- Subtitle: "Photos are proof. Take them clearly."
- Media capture sections (shown/hidden based on log type):
  - **Odometer Photo** [Camera button] + preview thumbnail (ALL log types)
  - **Fuel Meter Photo** [Camera button] + preview (fuel_fill only)
  - **Receipt Photo(s)** [Camera button] + [Gallery button] + previews (cash_expense, payment_received)
  - **Vehicle Front Photo** [Camera button] + preview (optional, all types)
- "Skip" option available per section (warn: "No photo = harder to verify")
- On Next: go to Step 3

**Step 3: FillDetailsScreen**
- Dynamic based on log type

  **For fuel_fill:**
  - Odometer Reading (numeric input, required)
  - Fuel Quantity in Litres (numeric)
  - Price per Litre (numeric)
  - Total Amount (auto-calculated, editable)
  - Payment Mode (segmented: Cash / UPI / Card / Fuel Card)
  - Paid By (segmented: Me / Company)
  - Notes (optional text)

  **For cash_expense:**
  - Odometer Reading (numeric input, required)
  - Category (dropdown: Repair / Food / Toll / Tyre / Oil / Cleaning / Fine / Other)
  - Amount (numeric, required)
  - Payment Mode (Cash / UPI / Card)
  - Description (text, required)
  - Notes (optional)

  **For payment_received:**
  - Amount Received (numeric, required)
  - Payment Mode (Cash / UPI / Bank Transfer)
  - Notes (optional)

  **For advance:**
  - Amount Received (numeric, required)
  - Payment Mode (Cash / UPI / Bank Transfer)
  - Notes (optional)

- All screens show: "Location will be auto-captured on submit" badge

**Step 4: ReviewAndSubmitScreen**
- Summary of everything entered
- Shows all captured photo thumbnails
- Shows detected location (reverse geocoded address)
- "Confirm & Submit" button
- "Go Back" button
- On Submit:
  1. Capture GPS (geolocator.getCurrentPosition, timeout 10s)
  2. Capture device context (battery, network)
  3. Compress images
  4. Save to Isar as `SyncStatus.pending`
  5. If online: begin upload (images → Storage, then log → Firestore)
  6. If offline: show "Saved offline. Will sync when connected." toast
  7. Navigate back to Home

---

### 7.4 Logs List Screen

**Header:**
- Title: "My Logs"
- Filter button (bottom sheet): date range, log type, vehicle

**Filter Bar (horizontal scroll chips):**
- All | Fuel | Expenses | Received | Advance

**List:**
- Chronological, newest first
- Paginated (20 per page, load more on scroll)
- Each item: same format as home screen recent activity
- Tap → Log Detail Screen

**Log Detail Screen:**
- Full detail view
- All photos (full-width carousel)
- Static map showing location
- All metadata fields
- Edit Log button (pencil icon)
- If edited: "Edited X times — tap to see history"

**Edit Log Screen:**
- Same as Step 3 (FillDetailsScreen) pre-filled
- On save: write new values + append to `editHistory` array in Firestore
- Manager will see edit history (display only, no approval in Phase 1)

---

### 7.5 Vehicle Screen

**Sections:**
1. **Current Vehicle** card (same as home) — large format
2. **Assignment Details:** Start date, start odometer, days assigned
3. **Assignment History** list: previous vehicles with dates
4. **Vehicle Logs** — same log list component filtered to this vehicle

---

### 7.6 Ledger Screen

**Title:** "Money Ledger"
**Subtitle:** Running financial summary between driver and company

**Summary Card at top:**
- Total Expenses by Driver: ₹X
- Total Received from Company: ₹X
- Net Balance (owed to driver): ₹X (colored green/red)

**Ledger Entries (table-style list):**
Each row:
- Date
- Type label (Expense / Received / Advance)
- Description
- Amount (DR in red / CR in green)
- Running balance

**Filter:** By date range

---

### 7.7 Settings Screen

**Sections:**

1. **Profile**
   - Driver name, phone (Driver ID), license number
   - Profile photo (editable)
   - Edit profile button

2. **Vehicle**
   - Current assignment info
   - Button: View Vehicle Details

3. **App**
   - Notifications (toggle)
   - Background tracking (toggle — with explanation)
   - App version

4. **Support**
   - Contact support (opens URL or email)
   - Terms of Service
   - Privacy Policy

5. **Account**
   - Sign Out (requires confirmation dialog)

---

## 8. Background GPS Tracking Service

**Package:** `flutter_background_geolocation` (transistorsoft)

**Configuration:**
```dart
BackgroundGeolocation.ready(Config(
  desiredAccuracy: Config.DESIRED_ACCURACY_HIGH,
  distanceFilter: 50,           // metres — trigger on movement
  stopOnTerminate: false,       // Keep running if app killed
  startOnBoot: true,            // Restart after phone reboot
  enableHeadless: true,         // Headless task support
  heartbeatInterval: 60,        // Ping every 60s even if not moving
  preventSuspend: true,         // iOS: prevent suspension
  backgroundPermissionRationale: PermissionRationale(
    title: "Allow FleetFuel360 to track location",
    message: "Required for accurate trip and fuel logs",
    positiveAction: "Allow always",
    negativeAction: "Cancel"
  ),
));
```

**On each location event:**
1. Build `LocalLocationPing` object
2. Save to Isar immediately (sync-safe)
3. If online: write to Firestore `/locationPings`
4. If offline: queue in Isar with `SyncStatus.pending`

**Headless Task (app killed, background sync):**
```dart
void headlessTask(HeadlessEvent headlessEvent) async {
  // Capture location, save to Isar, attempt Firestore write
}
```

**Permissions Required (request at startup):**
- `ACCESS_FINE_LOCATION`
- `ACCESS_BACKGROUND_LOCATION` (Android 10+)
- `REQUEST_INSTALL_PACKAGES` (no)
- Disable battery optimization: guide user to settings
- Motion & Fitness (iOS)

---

## 9. Image Handling

### Capture Flow
```
Camera capture (image_picker)
  → Compress to max 800KB, max 1024px wide (flutter_image_compress)
  → Save compressed file to local app directory
  → Store local path in Isar LocalLog
  → On sync: upload to Firebase Storage
  → Get download URL
  → Update Isar LocalLog with Storage URL
  → Write Firestore log doc with URLs
```

### Storage Path Convention
```
/companies/{companyId}/logs/{localLogId}/odometer.jpg
/companies/{companyId}/logs/{localLogId}/fuel_meter.jpg
/companies/{companyId}/logs/{localLogId}/receipt_0.jpg
/companies/{companyId}/logs/{localLogId}/receipt_1.jpg
/companies/{companyId}/logs/{localLogId}/vehicle.jpg
/companies/{companyId}/users/{userId}/profile.jpg
/companies/{companyId}/users/{userId}/license.jpg
```

### V2 Hook (Design now, implement later)
- Every image write to Storage will trigger a Cloud Function stub
- Stub is empty in Phase 1
- In Phase 2: call Google Cloud Vision / Gemini Vision API
- Write extracted values back to Firestore log doc fields:
  - `odometerReadingExtracted`
  - `fuelLevelExtracted`
  - `receiptAmountExtracted`

---

## 10. Log Types — Definitions

| logType | Description | Paid By | Money Direction |
|---|---|---|---|
| `fuel_fill` | Driver fills fuel | driver or company | Out (expense) |
| `cash_expense` | Driver pays for repair, food, toll etc from own pocket | driver | Out (driver owes reimbursement) |
| `payment_received` | Owner/manager pays driver (cash, UPI) | company | In (reduces what's owed) |
| `advance` | Advance amount given to driver before trip | company | In (advance, tracked separately) |
| `loan` | A loan given to driver | company | In (to be repaid) |
| `other` | Anything else | either | Either |

**Balance Calculation (Ledger):**
```
amountOwedToDriver = 
  SUM(cash_expense where paidBy == "driver") 
  - SUM(payment_received)
  - SUM(advance)
```

---

## 11. Security Rules

### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Users can only read/write their own user doc
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }

    // Company: members can read, only manager can write
    match /companies/{companyId} {
      allow read: if request.auth.uid in resource.data.memberDriverIds
                  || request.auth.uid == resource.data.managerId;
      allow write: if request.auth.uid == resource.data.managerId;
    }

    // Logs: driver can CRUD their own logs
    match /logs/{logId} {
      allow read: if request.auth.uid == resource.data.driverId
                  || isManagerOfCompany(resource.data.companyId);
      allow create: if request.auth.uid == request.resource.data.driverId;
      allow update: if request.auth.uid == resource.data.driverId;  // Driver can edit own logs
      allow delete: if false;  // Soft delete only via status field
    }

    // Location pings: driver write own, manager read all in company
    match /locationPings/{pingId} {
      allow create: if request.auth.uid == request.resource.data.driverId;
      allow read: if request.auth.uid == resource.data.driverId
                  || isManagerOfCompany(resource.data.companyId);
    }

    // Vehicles: company members read, manager write
    match /vehicles/{vehicleId} {
      allow read: if isCompanyMember(resource.data.companyId);
      allow write: if isManagerOfCompany(resource.data.companyId);
    }

    match /vehicleAssignments/{assignmentId} {
      allow read: if isCompanyMember(resource.data.companyId);
      allow write: if isManagerOfCompany(resource.data.companyId);
    }

    function isManagerOfCompany(companyId) {
      return get(/databases/$(database)/documents/companies/$(companyId)).data.managerId
             == request.auth.uid;
    }

    function isCompanyMember(companyId) {
      return request.auth.uid in get(/databases/$(database)/documents/companies/$(companyId)).data.memberDriverIds
             || isManagerOfCompany(companyId);
    }
  }
}
```

### Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /companies/{companyId}/logs/{logId}/{filename} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;  // Tighten in Phase 2
    }
    match /companies/{companyId}/users/{userId}/{filename} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

---

## 12. Design System

### Theme
- Style: Modern, clean — inspired by Swiggy/Zomato/Uber
- Mode: Support both light and dark mode
- Navigation: Bottom navigation bar (4 tabs: Home, Logs, Vehicle, Ledger) + Settings via avatar

### Colors
```dart
// Primary
primaryColor: Color(0xFF1A73E8)       // Blue — trust, tech
accentColor: Color(0xFFFF6B35)        // Orange — CTAs, alerts

// Status
expenseColor: Color(0xFFE53935)       // Red
incomeColor: Color(0xFF43A047)        // Green
fuelColor: Color(0xFF1565C0)          // Dark blue
neutralColor: Color(0xFF757575)       // Grey

// Background
backgroundLight: Color(0xFFF5F5F5)
backgroundDark: Color(0xFF121212)
cardLight: Color(0xFFFFFFFF)
cardDark: Color(0xFF1E1E1E)
```

### Typography
- Font: Inter (Google Fonts)
- H1: 24sp Bold
- H2: 20sp SemiBold
- H3: 16sp SemiBold
- Body: 14sp Regular
- Caption: 12sp Regular

### Components (reusable widgets)
- `LogCard` — used in home feed, logs list, vehicle screen
- `BalanceCard` — home screen + ledger
- `VehicleCard` — home + vehicle screen
- `MediaCaptureSection` — reused in add log step 2
- `SyncStatusBadge` — shown on unsynced logs
- `AmountDisplay` — colored amount with currency symbol
- `StaticMapThumbnail` — Google Static Maps API thumbnail

### Navigation
- Bottom nav: Home | Logs | Vehicle | Ledger
- FAB overlaid on bottom nav center
- Settings: top-right avatar → push Settings screen
- Add Log: FAB → full-screen modal flow (steps 1-4)

---

## 13. Permissions Required

### Android (`AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

### iOS (`Info.plist`)
```xml
NSLocationAlwaysAndWhenInUseUsageDescription
NSLocationWhenInUseUsageDescription
NSCameraUsageDescription
NSPhotoLibraryUsageDescription
NSMotionUsageDescription
UIBackgroundModes: location, fetch, remote-notification
```

---

## 14. Error Handling Philosophy

- **Never crash silently.** All errors caught, logged, and shown to user.
- **Offline is not an error.** Show sync status clearly.
- **Failed upload is not lost data.** Always saved locally first.
- **Image upload failure:** Save log without image URLs, mark images as `pendingUpload`, retry separately.
- **GPS timeout:** Log without location, show warning. Driver can re-submit.
- **Firebase write failure:** Retry with exponential backoff. Show badge on log card.

---

## 15. What Phase 2 (Manager App) Will Need from This Data

Design these now so the manager app works on Day 1:

- All location pings stored with `companyId` → manager can query all drivers in company
- All logs have `companyId` + `driverId` → manager can filter by either
- Edit history in log doc → manager can see changes without separate collection
- `vehicleAssignments` has full history → manager can see who drove what when
- Balance calculation is derived (not stored) → manager computes same formula
- No manager-approval step in Phase 1, but `status` field exists for future

---

## 16. Out of Scope for Phase 1 (Do Not Build)

- Manager App screens (only scaffold `main.dart`)
- Image data extraction (OCR, Vision API)
- Salary / payroll
- Log approval / rejection by manager
- Analytics and reports
- Multi-company support (one driver = one company)
- Expense limits / policies
- Export to CSV/PDF
- In-app chat

---

## 17. Definition of Done — Driver App

Phase 1 is complete when:

- [ ] Driver can sign in with Google
- [ ] Driver completes KYC and joins company via code
- [ ] Driver can see their assigned vehicle and balance on home screen
- [ ] Driver can add a Fuel log with photos, GPS, readings — online and offline
- [ ] Driver can add a Cash Expense log with photos — online and offline
- [ ] Driver can add a Payment Received log — online and offline
- [ ] Offline logs sync automatically when internet returns
- [ ] GPS pings are sent every 60 seconds in background, including when app is killed
- [ ] Driver can view all their logs with photos and location map
- [ ] Driver can edit a log (edit history is preserved)
- [ ] Driver can see their money ledger
- [ ] Driver can see vehicle assignment history
- [ ] All data written to Firestore is readable by the Firebase console
- [ ] App does not crash on no internet
- [ ] App requests all required permissions with explanations
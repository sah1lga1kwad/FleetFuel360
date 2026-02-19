# FleetFuel360 — Manager App Specification
**Version:** 1.0  
**Phase:** 2  
**Depends on:** Driver App (Phase 1) — assumed 90% complete, Firebase data in production  
**Read this entire document before writing a single line of code.**

---

## 1. What This App Is

FleetFuel360 Companies is used by the **owner or manager of a fleet business**. Their daily reality:

- They are not in the vehicle. They are at an office, at home, or on their phone.
- They need to know: where are my drivers right now? What are they spending? How much do I owe them?
- They have multiple vehicles, multiple drivers. They cannot call each one.
- They want to catch problems early — fuel anomalies, unexplained stops, excessive expenses.
- They want to pay drivers correctly based on what was actually spent.

**This app is their command center.** It must answer these questions instantly without them digging.

---

## 2. Critical Pre-Work: Study the Driver App Firebase Structure

Before building a single manager screen, the agent must:

1. Read `apps/driver_app/lib/` entirely to understand the current data models
2. Read `packages/fleetfuel_core/lib/models/` for all Firestore model definitions
3. Read `packages/fleetfuel_core/lib/services/firestore_service.dart` for existing queries
4. Read `firebase/firestore.rules` and `firebase/firestore.indexes.json`
5. Run the driver app and observe what data is actually written to Firestore

**Do not assume the original SPEC.md models are exactly what was implemented.** The driver app went through changes. Read what actually exists in the codebase, not what was originally planned.

**Where the manager app may need driver app fixes:**
- Ensure every log written by driver has `companyId` populated — if not, fix the driver app log creation
- Ensure `locationPings` have `companyId` — if not, fix the headless task
- Ensure `vehicleAssignments` has `isActive` correctly toggled — manager depends on this
- If any of these are broken in the driver app, **fix them as part of this phase**

---

## 3. Tech Stack — Manager App

Identical to driver app except:
- No `flutter_background_geolocation` (manager app never needs background GPS)
- No `isar` / offline-first (manager app requires internet — show error screen if offline)
- Add `fl_chart` for analytics charts
- Add `syncfusion_flutter_charts` (optional, only if fl_chart insufficient)

### Manager App `pubspec.yaml` additions vs driver app
```yaml
dependencies:
  fleetfuel_core:
    path: ../../packages/fleetfuel_core

  # All firebase packages same as driver app
  firebase_core: ^3.x
  firebase_auth: ^5.x
  cloud_firestore: ^5.x
  firebase_storage: ^12.x

  google_sign_in: ^6.x
  flutter_riverpod: ^2.x
  riverpod_annotation: ^2.x
  go_router: ^14.x
  google_maps_flutter: ^2.x
  geolocator: ^12.x
  cached_network_image: ^3.x
  google_fonts: ^6.x
  shimmer: ^3.x
  intl: ^0.19.x
  connectivity_plus: ^6.x
  permission_handler: ^11.x

  # Charts
  fl_chart: ^0.69.0

  # Additional UI
  photo_view: ^0.15.0        # Full screen image viewer for log receipts
  timeline_tile: ^2.0.0      # Driver activity timeline
  data_table_2: ^2.5.0       # Sortable tables for logs/ledger
```

---

## 4. App Architecture

### Authentication
Manager logs in with **Google Sign-In** — same Firebase Auth as driver app.  
On first login: if no company doc exists for this user → show **Company Setup** screen.  
If company exists (user is `managerId`) → go to Dashboard.

A manager cannot join as a driver and vice versa. If user doc has `role: "driver"`, show error: "This account is registered as a driver. Please use the Driver app."

### Navigation Structure
```
Bottom Navigation Bar (4 tabs):
  Tab 1: Dashboard (home icon)
  Tab 2: Live Map (map icon)
  Tab 3: Fleet (vehicles + drivers — two sub-tabs)
  Tab 4: Finance (logs + ledger)

Top-right: Notifications bell + Company avatar → Settings
```

### Offline Handling
Manager app requires internet. On connectivity loss:
- Show a persistent banner: "You're offline — data may be outdated"
- Do not crash, show last cached data if available
- Retry automatically when internet returns

---

## 5. Firestore Queries the Manager App Needs

All queries scoped to `companyId` from the manager's user document.

```dart
// All drivers in the company
.collection('users')
.where('companyId', isEqualTo: companyId)
.where('role', isEqualTo: 'driver')

// All vehicles in the company
.collection('vehicles')
.where('companyId', isEqualTo: companyId)

// All active assignments
.collection('vehicleAssignments')
.where('companyId', isEqualTo: companyId)
.where('isActive', isEqualTo: true)

// All logs for company (paginated, newest first)
.collection('logs')
.where('companyId', isEqualTo: companyId)
.orderBy('createdAt', descending: true)
.limit(50)

// Logs for specific driver
.collection('logs')
.where('driverId', isEqualTo: driverId)
.where('companyId', isEqualTo: companyId)
.orderBy('createdAt', descending: true)

// Location pings for specific driver (last 24 hours)
.collection('locationPings')
.where('driverId', isEqualTo: driverId)
.where('companyId', isEqualTo: companyId)
.where('recordedAt', isGreaterThan: yesterday)
.orderBy('recordedAt', descending: true)

// Latest ping per driver (for live map)
// Run as separate query per driver, or use a 'latestPing' denormalized field on user doc
// RECOMMENDATION: Add a 'lastKnownLocation' map to user doc, updated by driver app on each ping
// This avoids expensive multi-query for the live map
```

**Denormalization recommendation — fix in driver app:**  
Add `lastKnownLocation` to `/users/{driverId}`:
```
lastKnownLocation: {
  latitude: double,
  longitude: double,
  speed: double,
  activity: string,
  batteryLevel: int,
  recordedAt: Timestamp
}
```
Update this field in the driver app's `TrackingService._onLocation()`. This gives the manager app a single query for all driver positions instead of N queries.

---

## 6. Manager App Screens — Complete Inventory

---

### 6.1 Company Setup Screen (First-time only)

Shown when manager logs in and no company document exists.

**Fields:**
- Company Name
- Industry / Fleet Type (dropdown: Logistics, Food Delivery, Construction, Taxi, Other)
- Number of Vehicles (approximate, for display)
- Phone number of manager

**On Submit:**
1. Create `/companies/{newId}` with `managerId: uid`, generate 6-char `companyCode`
2. Create `/users/{uid}` with `role: "manager"`
3. Show the company code prominently: "Share this code with your drivers: **AB12XY**"
4. Go to Dashboard

---

### 6.2 Dashboard Screen (Tab 1 — Home)

**The manager opens the app here. In 5 seconds they must know: is everything okay?**

**Layout:**

**Section 1 — Header**
- Greeting: "Good morning, Ravi"
- Company name + small avatar
- Date

**Section 2 — Status Row (horizontal scroll cards, 4 cards)**
```
Card 1: Active Drivers Today
  → Number (e.g. "4/6")
  → Subtitle: "2 not started"
  → Color: green if all active, amber if some inactive

Card 2: Total Spend Today
  → Amount (e.g. "₹8,240")
  → Subtitle: "across 6 logs"
  → Tap → Finance tab filtered to today

Card 3: Fuel This Week
  → Litres + Amount (e.g. "142L / ₹18,600")
  → Tap → Finance filtered to fuel logs this week

Card 4: Pending Balance
  → Total amount company owes drivers
  → "₹4,200 owed to 3 drivers"
  → Tap → Ledger
```

**Section 3 — Mini Live Map**
- Height: 220px
- Shows all active drivers as animated marker dots on Google Maps
- Each marker: driver initials inside colored circle
- "View Full Map →" button in top-right corner
- Tapping a marker shows a bottom card: driver name, vehicle, last ping time, speed

**Section 4 — Today's Activity Feed**
- Title: "Recent Activity"
- Live-updating list (Firestore real-time listener)
- Each item:
  - Driver avatar + name
  - Log type icon + category
  - Amount
  - Time (relative: "12 min ago")
  - Location address (short)
- Show last 15 items
- "View All →" → Finance tab

**Section 5 — Alerts Panel** (show only if alerts exist)
- Highlighted cards for:
  - Driver offline for >2 hours during active assignment
  - Unusually high single expense (>₹5,000 by default, configurable)
  - Driver has not submitted any log today despite active assignment
  - Fuel log with no odometer photo
- Each alert: dismiss button, tap → relevant screen

---

### 6.3 Live Map Screen (Tab 2)

**Full-screen Google Maps experience.**

**Map Layer:**
- Google Maps in normal mode
- All active drivers shown as custom markers
  - Marker: circular avatar with driver's initials
  - Color: green (moving) / amber (idle >10 min) / grey (offline >30 min)
  - Marker rotates toward bearing direction (like Uber driver icon)

**Driver Info Card (bottom sheet, appears on marker tap):**
```
[Driver Avatar] Ravi Kumar                    ● Active
MH12AB1234 • Tata Ace
Speed: 42 km/h  |  Battery: 68%  |  Last ping: 45s ago
[View Driver]  [Call Driver]
```

**Bottom Sheet — Driver Trail (on "View Driver" tap):**
- Draws polyline on map showing driver's last 30 minutes of pings
- Color gradient: darker = more recent
- Timeline chips at bottom: "30 min" / "1 hr" / "Today"
- Shows all log entries made during the visible trail period as pin markers
  - Tap log pin → shows log summary card

**Filter Bar (top):**
- All Drivers | Moving | Idle | Offline
- Chips to show/hide specific vehicles

**Refresh:**
- Firestore real-time listener on `lastKnownLocation` field in user docs
- Map updates without user action

---

### 6.4 Fleet Screen (Tab 3)

Two sub-tabs: **Vehicles** and **Drivers**

---

#### 6.4.1 Vehicles Sub-tab

**List view, each vehicle card:**
```
[Vehicle Image]  MH12AB1234
                 Tata Ace 2022 • Diesel
                 Driver: Ravi Kumar  ●  Active
                 Odometer: 45,230 km  |  Last log: 2 hrs ago
```
- Status indicator: green (active + driver assigned) / amber (assigned, no recent ping) / grey (unassigned)
- Filter: All | Active | Idle | Unassigned
- Search bar by registration number

**Vehicle Detail Page:**

Pull-to-refresh. Sections:

**Header Card:**
- Vehicle image (full width)
- Registration number, make, model, year, fuel type
- Current driver name + assignment start date
- Current odometer reading
- Live location mini-map (if driver active)

**Stats Row (4 metrics, this month):**
```
Total Spend  |  Fuel Cost  |  Fuel Litres  |  Km Driven
₹24,500      |  ₹18,200    |  142 L        |  1,840 km
```

**Fuel Efficiency Card:**
- Calculated: km driven / litres consumed = km/L
- Chart: line chart of fuel efficiency over last 8 logs
- Trend: "↑ Better than last month" or "↓ Worse than last month"

**Expense Breakdown (donut chart):**
- Fuel / Repair / Food / Toll / Other
- This month vs last month toggle

**Odometer Progression (line chart):**
- X-axis: date of each fuel log
- Y-axis: odometer reading
- Shows vehicle usage over time

**Log History:**
- All logs for this vehicle
- Same log card component as driver app
- Filter: Fuel / Expense / All
- Tap log → Log Detail

**Assignment History:**
- Timeline list: who drove this vehicle, from when to when

---

#### 6.4.2 Drivers Sub-tab

**List view, each driver card:**
```
[Driver Avatar]  Ravi Kumar                 ● Online
                 ID: +91 98765 43210
                 MH12AB1234 • Tata Ace
                 Balance: ₹2,400 owed  |  Today: 3 logs
```
- Color dot: green (pinged <5 min) / amber (5-30 min) / grey (>30 min or no active assignment)
- Filter: All | Online | Offline | No Vehicle
- Search by name or phone

**Driver Detail Page:**

**Header Card:**
- Driver avatar + name + phone (Driver ID)
- License number
- Current vehicle + assignment start date
- Balance owed to driver (prominent, colored)
- "Mark as Paid" quick action button → opens payment entry

**Live Location Section:**
- Mini Google Map (height 200px)
- Shows current position + last 1 hour trail
- Last seen: "2 minutes ago at Andheri East"
- Speed + activity status
- "Full Map →" → opens Live Map tab focused on this driver

**Today's Summary:**
```
Logs Today: 4  |  Distance: 42 km  |  Expenses: ₹1,200  |  Fuel: 18L
```

**Activity Timeline (today):**
- Vertical timeline using `timeline_tile`
- Each node: time + event (log submitted / ping started / ping stopped)
- Color coded by log type
- Tap event node → log detail

**All Logs by This Driver:**
- Same paginated log list
- Filter: date range, log type
- Each log shows edit history badge if edited

**Financial Summary:**
- Running ledger for this driver
- DR (expenses by driver) / CR (payments to driver)
- Net balance
- "Record Payment" button → opens Add Payment flow

---

### 6.5 Finance Screen (Tab 4)

Two sub-tabs: **Logs** and **Ledger**

---

#### 6.5.1 Logs Sub-tab

**The manager's view of everything submitted.**

**Filter Bar (persistent, collapsible):**
- Date range picker
- Driver (multi-select)
- Vehicle (multi-select)
- Log type (multi-select chips)
- Amount range slider

**Summary Row (above list, updates with filter):**
```
Total: ₹42,300  |  Logs: 48  |  Fuel: ₹28,000  |  Expenses: ₹14,300
```

**Log List:**
- Same log card design as driver app but with driver name + vehicle number added
- Tap → Log Detail Modal (full screen bottom sheet, not separate page)

**Log Detail Modal:**
- Full log info
- Photo carousel (tap to full-screen with `photo_view`)
- Static Google Map at log location
- If log was edited: "⚠ Edited 1 time — tap to see history"
  - Expand → shows each edit: what changed, when, by whom
- Driver name + vehicle linkable (tap → go to that driver/vehicle page)

**Export (top-right icon):**
- Date range selector
- Format: PDF summary / CSV data
- Phase 1: share as text summary
- Phase 2: proper PDF

---

#### 6.5.2 Ledger Sub-tab

**Company-wide financial picture.**

**Top Summary Card:**
```
Company spent this month:   ₹1,24,500
Drivers have paid out:      ₹32,400 (from pocket)
Company has paid drivers:   ₹28,000
Total owed to drivers:      ₹4,400
```

**Per-Driver Ledger Cards:**
- One card per driver
- Shows: name, total expenses by driver, total paid to driver, net balance
- Green: company paid more (driver has advance/credit)
- Red: company owes driver
- Tap → opens full ledger for that driver (same as driver detail financial summary)

**Add Payment Button (FAB):**
- Manager can record that they paid a driver
- Opens bottom sheet:
  - Select driver
  - Amount
  - Payment mode (Cash / UPI / Bank Transfer)
  - Notes
  - On submit: creates a `payment_received` log on behalf of the driver
  - This log appears in the driver's app immediately

**Monthly Toggle:**
- View by month tabs: Jan / Feb / Mar etc.
- Each month shows that month's summary

---

### 6.6 Settings Screen

**Sections:**

**Company**
- Company name (editable)
- Company code — display prominently with copy button
- Industry type
- Default currency
- Alert thresholds (configurable):
  - High expense alert: ₹X per log (default ₹5,000)
  - Idle alert: minutes before driver marked idle (default 30)

**Fleet Management**
- Add Vehicle (bottom sheet form):
  - Registration number, make, model, year, fuel type, vehicle type
  - Upload vehicle image
  - Tank capacity in litres
- View All Vehicles → goes to Fleet tab vehicles
- Assign Vehicle to Driver (select vehicle + select driver + start date)
- Remove Driver from Company (confirmation required)

**Drivers**
- View All Drivers → goes to Fleet tab drivers
- Company Join Code — show prominently with share button
- "Driver joins by entering this code in their app"

**Account**
- Manager profile (name, email, photo)
- Sign out

---

## 7. Analytics Calculations

All analytics are **computed on the client from Firestore data**. No Cloud Functions needed for Phase 1.

### 7.1 Fuel Efficiency
```dart
// Per vehicle, between consecutive fuel logs
double kmPerLitre(LogModel fuelLog1, LogModel fuelLog2) {
  final kmDriven = fuelLog2.odometerReading - fuelLog1.odometerReading;
  final litresConsumed = fuelLog2.fuelQuantityLitres;
  if (litresConsumed <= 0) return 0;
  return kmDriven / litresConsumed;
}

// Average across all fuel logs for a vehicle
double averageFuelEfficiency(List<LogModel> fuelLogs) {
  // Sort by odometer reading ascending
  // Compute consecutive pairs
  // Return average
}
```

### 7.2 Driver Balance
```dart
// Same formula as driver app — computed identically
int driverBalance(List<LogModel> logs) {
  final expenses = logs
    .where((l) => l.logType == LogType.cashExpense && l.paidBy == PaidBy.driver)
    .fold(0, (sum, l) => sum + l.amount);
  
  final received = logs
    .where((l) => l.logType == LogType.paymentReceived || l.logType == LogType.advance)
    .fold(0, (sum, l) => sum + l.amount);
  
  return expenses - received; // positive = company owes driver
}
```

### 7.3 Expense Breakdown by Category
```dart
Map<LogCategory, int> expenseBreakdown(List<LogModel> logs) {
  return Map.fromEntries(
    LogCategory.values.map((cat) => MapEntry(
      cat,
      logs
        .where((l) => l.category == cat)
        .fold(0, (sum, l) => sum + l.amount),
    )),
  );
}
```

### 7.4 Km Driven (from odometer readings)
```dart
// Sort fuel logs by createdAt for a vehicle
// Take first and last odometerReading
// Difference = total km in time range
int kmDriven(List<LogModel> logsWithOdometer, DateRange range) {
  final filtered = logsWithOdometer
    .where((l) => l.odometerReading > 0)
    .where((l) => l.createdAt.isAfter(range.start) && l.createdAt.isBefore(range.end))
    .toList()
    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  
  if (filtered.length < 2) return 0;
  return filtered.last.odometerReading - filtered.first.odometerReading;
}
```

### 7.5 Daily Spend Chart Data
```dart
Map<DateTime, int> dailySpend(List<LogModel> logs, int lastNDays) {
  // Group logs by date (day)
  // Sum amounts per day
  // Return map of date → total spend
}
```

---

## 8. Manager App — Riverpod Providers

```dart
// Company data
final managerCompanyProvider = StreamProvider<CompanyModel?>((ref) { ... });

// All drivers in company
final companyDriversProvider = StreamProvider<List<UserModel>>((ref) { ... });

// All vehicles in company  
final companyVehiclesProvider = StreamProvider<List<VehicleModel>>((ref) { ... });

// All active assignments
final activeAssignmentsProvider = StreamProvider<List<VehicleAssignmentModel>>((ref) { ... });

// Logs with filter state
@riverpod
class LogsFilter extends _$LogsFilter {
  @override
  LogsFilterState build() => LogsFilterState.initial();
  
  void setDateRange(DateRange range) => ...;
  void toggleDriver(String driverId) => ...;
  void toggleLogType(LogType type) => ...;
}

final filteredLogsProvider = StreamProvider<List<LogModel>>((ref) {
  final filter = ref.watch(logsFilterProvider);
  return ref.watch(firestoreServiceProvider).watchLogsWithFilter(
    companyId: ref.watch(managerCompanyProvider).value!.companyId,
    filter: filter,
  );
});

// Live driver locations (from lastKnownLocation field)
final driverLocationsProvider = StreamProvider<Map<String, DriverLocation>>((ref) {
  // One real-time listener on all driver user docs
  // Map: driverId → DriverLocation
});

// Per-driver analytics
final driverAnalyticsProvider = FutureProvider.family<DriverAnalytics, String>((ref, driverId) async {
  final logs = await ref.watch(firestoreServiceProvider).getDriverLogs(driverId);
  return DriverAnalytics.compute(logs);
});

// Per-vehicle analytics
final vehicleAnalyticsProvider = FutureProvider.family<VehicleAnalytics, String>((ref, vehicleId) async {
  final logs = await ref.watch(firestoreServiceProvider).getVehicleLogs(vehicleId);
  return VehicleAnalytics.compute(logs);
});
```

---

## 9. FirestoreService Extensions for Manager App

Add these methods to `fleetfuel_core/lib/services/firestore_service.dart`. **Do not duplicate the class — extend it.**

```dart
// Get all drivers for a company
Stream<List<UserModel>> watchCompanyDrivers(String companyId);

// Get all vehicles for a company
Stream<List<VehicleModel>> watchCompanyVehicles(String companyId);

// Get logs with filter (used by Finance screen)
Stream<List<LogModel>> watchLogsWithFilter(String companyId, LogsFilterState filter);

// Get paginated logs for a vehicle
Future<List<LogModel>> getVehicleLogs(String vehicleId, {int limit = 100});

// Get all logs for a driver (for analytics)
Future<List<LogModel>> getDriverLogs(String driverId, {DateRange? range});

// Get location pings for a driver over a time range
Future<List<LocationPingModel>> getDriverPings(String driverId, DateRange range);

// Manager creates a payment on behalf of driver
Future<void> managerCreatePayment({
  required String driverId,
  required String vehicleId,
  required String companyId,
  required String assignmentId,
  required int amount,
  required String paymentMode,
  required String notes,
  required String managerId,
});

// Update lastKnownLocation on user doc (called from driver app, here for reference)
Future<void> updateDriverLastKnownLocation(String driverId, LocationData location);
```

---

## 10. Driver App Fixes Required

While building the manager app, make these fixes in the driver app. **Confirm each exists before fixing — don't fix what isn't broken.**

### Fix 1 — Ensure `lastKnownLocation` is written on each ping
In `apps/driver_app/lib/features/tracking/tracking_service.dart`, after saving the ping:
```dart
// Also update lastKnownLocation on user doc for fast manager map queries
await _firestoreService.updateDriverLastKnownLocation(
  driverId,
  LocationData(
    latitude: location.coords.latitude,
    longitude: location.coords.longitude,
    speed: location.coords.speed * 3.6, // m/s to km/h
    activity: location.activity.type,
    batteryLevel: location.battery.level,
    recordedAt: DateTime.now(),
  ),
);
```

### Fix 2 — Ensure all logs have `companyId`
In the driver app's `AddLogNotifier.submit()`, verify `companyId` is pulled from the current user and written to the log. If `companyId` is null at this point, log creation should fail with a clear error, not silently write a log without `companyId`.

### Fix 3 — Ensure headless pings have `companyId`
In the headless task, driver context (companyId, vehicleId, assignmentId) must be read from Isar (not Firestore, since headless has no auth context). Verify this is implemented. If driver context is missing from Isar, pings written by headless task will have empty `companyId` and the manager won't see them.

### Fix 4 — `vehicleAssignment.isActive` toggle
When a vehicle assignment is created, `isActive: true`. Verify this field is set correctly. Manager queries `isActive == true` to find current assignments.

---

## 11. Map Implementation Details

### Live Map — Driver Markers

```dart
// Custom marker: circle with driver initials
BitmapDescriptor _buildDriverMarker(String initials, DriverStatus status) {
  // Use canvas to draw circle + initials
  // Color based on status: green/amber/grey
  // Return as BitmapDescriptor.fromBytes
}

// Status determination
DriverStatus _getDriverStatus(DriverLocation location) {
  final age = DateTime.now().difference(location.recordedAt);
  if (age.inMinutes < 5) return DriverStatus.active;
  if (age.inMinutes < 30) return DriverStatus.idle;
  return DriverStatus.offline;
}
```

### Driver Trail — Polyline from Pings

```dart
// Fetch pings for selected time range
// Build polyline from coordinates
// Gradient: opacity decreases for older pings
List<LatLng> _buildTrail(List<LocationPingModel> pings) {
  return pings
    .sorted((a, b) => a.recordedAt.compareTo(b.recordedAt))
    .map((p) => LatLng(p.location.latitude, p.location.longitude))
    .toList();
}
```

---

## 12. Design System — Manager App

**Identical to driver app** (same AppTheme, same colors, same typography).  
This is intentional — the two apps feel like one product family.

The only difference: manager app uses a **lighter, more data-dense layout** in some screens (ledger, log tables) since managers are more comfortable reading data.

### Component Reuse from `fleetfuel_core`
These UI components should be moved to the core package and shared:
- `LogCard` widget
- `AmountDisplay` widget
- `AppFormatters` (already in core)
- `VehicleCard` widget
- `SyncStatusBadge`

Both apps import them from `fleetfuel_core`.

### Manager-Specific Components (in manager_app only)
- `DriverMarker` — custom Google Maps marker
- `AnalyticsCard` — metric card with trend indicator
- `MiniMapWidget` — reusable small Google Map with a single driver
- `LogDetailModal` — bottom sheet log viewer with photos
- `DriverStatusDot` — colored dot indicating online/offline
- `BalanceSummaryCard` — per-driver balance card for ledger
- `SpendChart` — fl_chart bar chart for daily spend
- `FuelEfficiencyChart` — fl_chart line chart

---

## 13. Screen Navigation Map

```
/                 → SplashScreen (auth check)
/login            → LoginScreen
/company-setup    → CompanySetupScreen (first time)

/dashboard        → DashboardScreen (Tab 1)
/map              → LiveMapScreen (Tab 2)
  /map/driver/:id → LiveMapScreen focused on driver (same screen, panned)

/fleet            → FleetScreen shell (Tab 3)
  /fleet/vehicles → VehiclesListScreen
  /fleet/vehicles/:vehicleId → VehicleDetailScreen
  /fleet/drivers  → DriversListScreen
  /fleet/drivers/:driverId → DriverDetailScreen

/finance          → FinanceScreen shell (Tab 4)
  /finance/logs   → LogsListScreen
  /finance/ledger → LedgerScreen

/log/:logId       → LogDetailModal (shown from any tab)
/settings         → SettingsScreen
/settings/add-vehicle → AddVehicleScreen
/settings/assign  → AssignVehicleScreen
```

---

## 14. Definition of Done — Manager App

Phase 2 is complete when:

- [ ] Manager can sign in with Google and set up a company
- [ ] Manager sees live driver positions on the dashboard mini-map
- [ ] Manager sees all active drivers and their status on the full Live Map
- [ ] Tapping a driver on the map shows their info card and trail
- [ ] Manager can view all vehicles with current driver and stats
- [ ] Vehicle detail shows fuel efficiency chart and expense breakdown
- [ ] Manager can view all drivers with online/offline status
- [ ] Driver detail shows live location map + today's activity timeline
- [ ] Manager can see all logs submitted by all drivers in Finance tab
- [ ] Manager can filter logs by driver, date, type
- [ ] Manager can see log photos in full screen
- [ ] Manager can see edit history on edited logs
- [ ] Ledger shows per-driver balance correctly
- [ ] Manager can record a payment to a driver (creates a log in driver app)
- [ ] Settings allows adding a vehicle and assigning it to a driver
- [ ] Company join code is visible and shareable
- [ ] Dashboard alerts show anomalies (idle driver, high expense)
- [ ] App shows offline banner when internet is unavailable
- [ ] All data is scoped to the manager's `companyId` — no cross-company data leaks
- [ ] Driver app fixes (Section 10) are verified and applied
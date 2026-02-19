# FleetFuel360

A dual-app fleet management system for commercial vehicle fleets.

## Apps

- **FleetFuel360 Drivers** (`apps/driver_app`) — Fuel and expense tracking for drivers
- **FleetFuel360 Companies** (`apps/manager_app`) — Fleet management dashboard (Phase 2)

## Shared Package

- **fleetfuel_core** (`packages/fleetfuel_core`) — Shared models, services, and utilities

## Project Structure

```
fleetfuel360/
├── apps/
│   ├── driver_app/       # Phase 1 — Driver app
│   └── manager_app/      # Phase 2 — Manager app (placeholder)
├── packages/
│   └── fleetfuel_core/   # Shared Dart package
├── firebase/             # Firebase config and rules
└── README.md
```

## Setup

### Prerequisites
- Flutter (stable channel)
- Firebase CLI
- Android Studio / Xcode

### Getting Started

1. **Clone the repo**

2. **Add Firebase config files**
   - `apps/driver_app/android/app/google-services.json`
   - `apps/driver_app/ios/Runner/GoogleService-Info.plist`

3. **Install dependencies**
   ```bash
   cd packages/fleetfuel_core && flutter pub get
   cd apps/driver_app && flutter pub get
   ```

4. **Run code generation**
   ```bash
   cd packages/fleetfuel_core && dart run build_runner build --delete-conflicting-outputs
   cd apps/driver_app && dart run build_runner build --delete-conflicting-outputs
   ```

5. **Run the driver app**
   ```bash
   cd apps/driver_app && flutter run
   ```

## Tech Stack

- Flutter + Dart
- Firebase (Auth, Firestore, Storage, FCM)
- Riverpod (state management)
- GoRouter (navigation)
- Isar (local database / offline-first)
- flutter_background_geolocation (background GPS)

## Phase 1 Scope

- Driver authentication (Google Sign-In)
- KYC + company join flow
- Fuel fill logging with photos + GPS
- Cash expense logging
- Payment received logging
- Offline-first with auto-sync
- Background GPS tracking (every 60s)
- Logs list with photos and map
- Ledger (money balance)
- Vehicle assignment tracking

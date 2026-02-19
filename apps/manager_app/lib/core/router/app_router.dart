import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/company/presentation/company_setup_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/map/presentation/live_map_screen.dart';
import '../../features/fleet/presentation/fleet_screen.dart';
import '../../features/fleet/presentation/vehicle_detail_screen.dart';
import '../../features/fleet/presentation/driver_detail_screen.dart';
import '../../features/finance/presentation/finance_screen.dart';
import '../../features/log/presentation/log_detail_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settings/presentation/add_vehicle_screen.dart';
import '../../features/settings/presentation/assign_vehicle_screen.dart';
import '../di/providers.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);
  final manager = ref.watch(currentManagerProvider);
  final company = ref.watch(managerCompanyProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      if (auth.isLoading) return null;

      final user = auth.valueOrNull;
      final isLogin = state.matchedLocation == '/login';
      final isSetup = state.matchedLocation == '/company-setup';

      if (user == null) {
        return isLogin ? null : '/login';
      }

      if (manager.isLoading) return null;
      final managerUser = manager.valueOrNull;

      if (managerUser != null && managerUser.role == 'driver') {
        await FirebaseAuth.instance.signOut();
        return '/login?driverAccount=true';
      }

      if (managerUser == null ||
          managerUser.companyId == null ||
          managerUser.companyId!.isEmpty) {
        return isSetup ? null : '/company-setup';
      }

      if (company.isLoading) return null;

      if (isLogin || isSetup || state.matchedLocation == '/') {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, state) => LoginScreen(
          showDriverError: state.uri.queryParameters['driverAccount'] == 'true',
        ),
      ),
      GoRoute(
        path: '/company-setup',
        builder: (_, __) => const CompanySetupScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => _ManagerShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/map',
            builder: (_, __) => const LiveMapScreen(),
          ),
          GoRoute(
            path: '/fleet',
            builder: (_, __) => const FleetScreen(),
          ),
          GoRoute(
            path: '/finance',
            builder: (_, __) => const FinanceScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/fleet/vehicles/:id',
        builder: (_, state) => VehicleDetailScreen(
          vehicleId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/fleet/drivers/:id',
        builder: (_, state) => DriverDetailScreen(
          driverId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/log/:logId',
        builder: (_, state) =>
            LogDetailScreen(logId: state.pathParameters['logId']!),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings/add-vehicle',
        builder: (_, __) => const AddVehicleScreen(),
      ),
      GoRoute(
        path: '/settings/assign-vehicle',
        builder: (_, __) => const AssignVehicleScreen(),
      ),
    ],
  );
});

class _ManagerShell extends StatelessWidget {
  const _ManagerShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    var currentIndex = 0;
    if (location.startsWith('/map')) currentIndex = 1;
    if (location.startsWith('/fleet')) currentIndex = 2;
    if (location.startsWith('/finance')) currentIndex = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/dashboard');
              break;
            case 1:
              context.go('/map');
              break;
            case 2:
              context.go('/fleet');
              break;
            case 3:
              context.go('/finance');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Map'),
          NavigationDestination(
              icon: Icon(Icons.local_shipping_outlined), label: 'Fleet'),
          NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Finance'),
        ],
      ),
    );
  }
}

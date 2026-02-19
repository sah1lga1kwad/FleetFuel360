import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/kyc_screen.dart';
import '../../features/auth/presentation/company_join_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/logs/presentation/logs_list_screen.dart';
import '../../features/logs/presentation/log_detail_screen.dart';
import '../../features/logs/presentation/edit_log_screen.dart';
import '../../features/vehicle/presentation/vehicle_screen.dart';
import '../../features/ledger/presentation/ledger_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/permissions/presentation/tracking_permissions_screen.dart';
import '../../features/add_log/presentation/select_log_type_screen.dart';
import '../../features/add_log/presentation/capture_media_screen.dart';
import '../../features/add_log/presentation/fill_details_screen.dart';
import '../../features/add_log/presentation/review_submit_screen.dart';
import '../di/providers.dart';
import '../../features/add_log/presentation/add_log_flow_notifier.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authAsync = ref.watch(authStateStreamProvider);
  final userAsync = ref.watch(currentUserStreamProvider);
  final permissionsAsync = ref.watch(trackingPermissionStatusProvider);

  final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Still loading
      if (authAsync.isLoading) return null;

      final firebaseUser = authAsync.valueOrNull;

      // Not logged in → login
      if (firebaseUser == null) {
        if (state.fullPath == '/login') return null;
        return '/login';
      }

      // User document still loading
      if (userAsync.isLoading) return null;
      final user = userAsync.valueOrNull;

      // Logged in but user doc missing → onboarding/KYC
      if (user == null) {
        if (state.fullPath == '/kyc') return null;
        return '/kyc';
      }

      // KYC not done
      if (!user.kycCompleted) {
        if (state.fullPath == '/kyc') return null;
        return '/kyc';
      }

      // Company not joined
      if (user.companyId == null) {
        if (state.fullPath == '/company-join') return null;
        return '/company-join';
      }

      if (permissionsAsync.isLoading) return null;
      final permissionStatus = permissionsAsync.valueOrNull;
      final permissionsReady = permissionStatus?.allGranted ?? false;

      if (!permissionsReady) {
        if (state.fullPath == '/permissions') return null;
        return '/permissions';
      }

      // Fully set up — redirect away from auth screens
      if (state.fullPath == '/' ||
          state.fullPath == '/login' ||
          state.fullPath == '/kyc' ||
          state.fullPath == '/company-join') {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/kyc',
        builder: (context, state) => const KYCScreen(),
      ),
      GoRoute(
        path: '/company-join',
        builder: (context, state) => const CompanyJoinScreen(),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const TrackingPermissionsScreen(),
      ),
      // ─── Main Shell ───────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/logs',
            builder: (context, state) => const LogsListScreen(),
          ),
          GoRoute(
            path: '/vehicle',
            builder: (context, state) => const VehicleScreen(),
          ),
          GoRoute(
            path: '/ledger',
            builder: (context, state) => const LedgerScreen(),
          ),
        ],
      ),
      // ─── Add Log Flow ─────────────────────────────────────────────────────
      GoRoute(
        path: '/log/add',
        builder: (context, state) => const SelectLogTypeScreen(),
      ),
      GoRoute(
        path: '/log/add/media',
        builder: (context, state) => const CaptureMediaScreen(),
      ),
      GoRoute(
        path: '/log/add/details',
        builder: (context, state) => const FillDetailsScreen(),
      ),
      GoRoute(
        path: '/log/add/review',
        builder: (context, state) => const ReviewSubmitScreen(),
      ),
      // ─── Log Detail & Edit ────────────────────────────────────────────────
      GoRoute(
        path: '/log/:logId',
        builder: (context, state) =>
            LogDetailScreen(logId: state.pathParameters['logId']!),
      ),
      GoRoute(
        path: '/log/:logId/edit',
        builder: (context, state) =>
            EditLogScreen(logId: state.pathParameters['logId']!),
      ),
      // ─── Settings ─────────────────────────────────────────────────────────
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
  return router;
});

// ─── Main Shell with Bottom Navigation ───────────────────────────────────────

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _BottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(addLogFlowProvider.notifier).reset();
          context.push('/log/add');
        },
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _BottomNav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).fullPath ?? '/home';

    int currentIndex = 0;
    if (location.startsWith('/logs')) currentIndex = 1;
    if (location.startsWith('/vehicle')) currentIndex = 2;
    if (location.startsWith('/ledger')) currentIndex = 3;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => context.go('/home'),
          ),
          _NavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long,
            label: 'Logs',
            isActive: currentIndex == 1,
            onTap: () => context.go('/logs'),
          ),
          const SizedBox(width: 40), // FAB gap
          _NavItem(
            icon: Icons.directions_car_outlined,
            activeIcon: Icons.directions_car,
            label: 'Vehicle',
            isActive: currentIndex == 2,
            onTap: () => context.go('/vehicle'),
          ),
          _NavItem(
            icon: Icons.account_balance_wallet_outlined,
            activeIcon: Icons.account_balance_wallet,
            label: 'Ledger',
            isActive: currentIndex == 3,
            onTap: () => context.go('/ledger'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isActive ? activeIcon : icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }
}

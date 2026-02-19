import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../add_log/presentation/add_log_flow_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final company = ref.watch(currentCompanyProvider);
    final vehicle = ref.watch(assignedVehicleProvider);
    final recentLogs = ref.watch(recentLogsStreamProvider);
    final ledgerLogs = ref.watch(ledgerLogsProvider);
    final localUnsyncedLogs = ref.watch(localUnsyncedLogsStreamProvider);
    final mergedLedgerLogs = <LogModel>[
      ...(ledgerLogs.valueOrNull ?? const <LogModel>[]),
      ...(localUnsyncedLogs.valueOrNull ?? const <LogModel>[]),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset('assets/icon/icon.png',
              errorBuilder: (_, __, ___) => const Icon(Icons.local_gas_station,
                  color: AppColors.primary)),
        ),
        title: Text(company?.name ?? 'FleetFuel360'),
        actions: [
          GestureDetector(
            onTap: () => context.push('/settings'),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: user?.profileImageUrl.isNotEmpty == true
                    ? CachedNetworkImage(
                        imageUrl: user!.profileImageUrl,
                        imageBuilder: (_, img) => CircleAvatar(
                          radius: 18,
                          backgroundImage: img,
                        ),
                        placeholder: (_, __) =>
                            const Icon(Icons.person, size: 20),
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.person, size: 20),
                      )
                    : const Icon(Icons.person,
                        size: 20, color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(recentLogsStreamProvider);
          ref.invalidate(assignedVehicleStreamProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Card
              _VehicleCard(vehicle: vehicle),
              const SizedBox(height: 16),

              // Balance Card
              _BalanceCard(logs: mergedLedgerLogs),
              const SizedBox(height: 16),

              // Quick Actions
              _QuickActionsRow(onAddLog: (type) {
                ref.read(addLogFlowProvider.notifier)
                  ..reset()
                  ..setLogType(type);
                context.push('/log/add/media');
              }),
              const SizedBox(height: 24),

              // Recent Activity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Activity',
                      style: Theme.of(context).textTheme.displaySmall),
                  TextButton(
                    onPressed: () => context.go('/logs'),
                    child: const Text('View All →'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              recentLogs.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
                data: (logs) => logs.isEmpty
                    ? _EmptyActivity()
                    : Column(
                        children:
                            logs.map((log) => _LogCard(log: log)).toList(),
                      ),
              ),
              const SizedBox(height: 80), // FAB clearance
            ],
          ),
        ),
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final VehicleModel? vehicle;
  const _VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    if (vehicle == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.neutral.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.directions_car_outlined,
                    color: AppColors.neutral, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No Vehicle Assigned',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('Contact your manager to get a vehicle assigned.',
                        style:
                            TextStyle(color: AppColors.neutral, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: vehicle!.vehicleImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: vehicle!.vehicleImageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => _vehicleIcon(),
                    )
                  : _vehicleIcon(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vehicle!.registrationNumber,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text('${vehicle!.make} ${vehicle!.model} · ${vehicle!.year}',
                      style: const TextStyle(
                          color: AppColors.neutral, fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.fuel.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      vehicle!.fuelType.name.toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.fuel,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleIcon() => Container(
        width: 72,
        height: 72,
        color: AppColors.backgroundLight,
        child: const Icon(Icons.directions_car,
            size: 40, color: AppColors.neutral),
      );
}

class _BalanceCard extends StatelessWidget {
  final List<LogModel> logs;
  const _BalanceCard({required this.logs});

  @override
  Widget build(BuildContext context) {
    int totalExpenses = 0;
    int totalReceived = 0;
    for (final log in logs) {
      if ((log.logType == LogType.cashExpense ||
              log.logType == LogType.fuelFill) &&
          log.paidBy == PaidBy.driver) {
        totalExpenses += log.amount;
      } else if (log.logType == LogType.paymentReceived ||
          log.logType == LogType.advance ||
          log.logType == LogType.loan) {
        totalReceived += log.amount;
      }
    }
    final balance = totalExpenses - totalReceived;
    final isOwed = balance > 0;

    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/ledger'),
      child: Card(
        color: isOwed
            ? AppColors.income.withValues(alpha: 0.08)
            : AppColors.neutral.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                isOwed ? Icons.account_balance_wallet : Icons.check_circle,
                color: isOwed ? AppColors.income : AppColors.neutral,
                size: 36,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOwed ? 'Company owes you' : 'Balance settled',
                      style: TextStyle(color: AppColors.neutral, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppFormatters.formatAmount(balance.abs()),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isOwed ? AppColors.income : AppColors.neutral,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.neutral),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  final void Function(LogType) onAddLog;
  const _QuickActionsRow({required this.onAddLog});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.local_gas_station,
          label: 'Fuel',
          color: AppColors.fuel,
          onTap: () => onAddLog(LogType.fuelFill),
        ),
        _ActionButton(
          icon: Icons.receipt_long,
          label: 'Expense',
          color: AppColors.expense,
          onTap: () => onAddLog(LogType.cashExpense),
        ),
        _ActionButton(
          icon: Icons.payments,
          label: 'Received',
          color: AppColors.income,
          onTap: () => onAddLog(LogType.paymentReceived),
        ),
        _ActionButton(
          icon: Icons.list_alt,
          label: 'All Logs',
          color: AppColors.neutral,
          onTap: () => GoRouter.of(context).go('/logs'),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 6),
            Text(label,
                style: const TextStyle(fontSize: 11, color: AppColors.neutral)),
          ],
        ),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final LogModel log;
  const _LogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    final isExpense =
        log.logType == LogType.cashExpense || log.logType == LogType.fuelFill;
    final amountColor = isExpense ? AppColors.expense : AppColors.income;
    final amountPrefix = isExpense ? '-' : '+';

    return GestureDetector(
      onTap: () => context.push('/log/${log.logId}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Map thumbnail placeholder
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_logTypeIcon(log.logType),
                  color: AppColors.neutral, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _logTypeLabel(log.logType),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  if (log.description.isNotEmpty)
                    Text(
                      log.description,
                      style: const TextStyle(
                          color: AppColors.neutral, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),
                  Text(
                    AppFormatters.formatRelative(log.createdAt),
                    style:
                        const TextStyle(color: AppColors.neutral, fontSize: 11),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$amountPrefix${AppFormatters.formatAmount(log.amount)}',
                  style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                if (log.odometerReading > 0)
                  Text(
                    AppFormatters.formatOdometer(log.odometerReading),
                    style:
                        const TextStyle(color: AppColors.neutral, fontSize: 11),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _logTypeIcon(LogType type) {
    switch (type) {
      case LogType.fuelFill:
        return Icons.local_gas_station;
      case LogType.cashExpense:
        return Icons.receipt_long;
      case LogType.paymentReceived:
        return Icons.payments;
      case LogType.advance:
        return Icons.account_balance_wallet;
      default:
        return Icons.notes;
    }
  }

  String _logTypeLabel(LogType type) {
    switch (type) {
      case LogType.fuelFill:
        return 'Fuel Fill';
      case LogType.cashExpense:
        return 'Cash Expense';
      case LogType.paymentReceived:
        return 'Payment Received';
      case LogType.advance:
        return 'Advance';
      case LogType.loan:
        return 'Loan';
      default:
        return 'Other';
    }
  }
}

class _EmptyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.neutral),
          SizedBox(height: 12),
          Text(
            'No logs yet',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.neutral),
          ),
          SizedBox(height: 4),
          Text(
            'Tap + to add your first fuel or expense log.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.neutral, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

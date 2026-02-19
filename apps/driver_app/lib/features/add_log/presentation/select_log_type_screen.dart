import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import 'add_log_flow_notifier.dart';
import '../../../core/theme/app_theme.dart';

class SelectLogTypeScreen extends ConsumerWidget {
  const SelectLogTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 1 of 4 — Log Type'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What are you logging?',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Select the type of log to continue.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.neutral,
                  ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _LogTypeCard(
                    icon: Icons.local_gas_station,
                    label: 'Fuel Fill',
                    color: AppColors.fuel,
                    type: LogType.fuelFill,
                  ),
                  _LogTypeCard(
                    icon: Icons.receipt_long,
                    label: 'Cash Expense',
                    color: AppColors.expense,
                    type: LogType.cashExpense,
                  ),
                  _LogTypeCard(
                    icon: Icons.payments,
                    label: 'Payment Received',
                    color: AppColors.income,
                    type: LogType.paymentReceived,
                  ),
                  _LogTypeCard(
                    icon: Icons.account_balance_wallet,
                    label: 'Advance',
                    color: AppColors.primary,
                    type: LogType.advance,
                  ),
                  _LogTypeCard(
                    icon: Icons.handshake_outlined,
                    label: 'Loan / Credit',
                    color: AppColors.warning,
                    type: LogType.loan,
                  ),
                  _LogTypeCard(
                    icon: Icons.notes,
                    label: 'Other',
                    color: AppColors.neutral,
                    type: LogType.other,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogTypeCard extends ConsumerWidget {
  final IconData icon;
  final String label;
  final Color color;
  final LogType type;

  const _LogTypeCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(addLogFlowProvider.notifier).setLogType(type);
        context.push('/log/add/media');
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

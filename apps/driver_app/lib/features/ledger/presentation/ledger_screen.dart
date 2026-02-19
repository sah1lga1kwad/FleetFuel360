import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class LedgerScreen extends ConsumerWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cloudLogsAsync = ref.watch(ledgerLogsProvider);
    final localLogsAsync = ref.watch(localUnsyncedLogsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Ledger')),
      body: cloudLogsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (cloudLogs) {
          final mergedLogs = <LogModel>[
            ...cloudLogs,
            ...(localLogsAsync.valueOrNull ?? const <LogModel>[]),
          ];
          final orderedLogs = List<LogModel>.from(mergedLogs)
            ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
          final summary = _LedgerSummary.compute(orderedLogs);
          return Column(
            children: [
              _SummaryCard(summary: summary),
              const Divider(height: 1),
              Expanded(
                child: orderedLogs.isEmpty
                    ? _EmptyLedger()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: orderedLogs.length,
                        itemBuilder: (_, i) => _LedgerRow(
                          log: orderedLogs[i],
                          runningBalance: _runningBalance(orderedLogs, i),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  int _runningBalance(List<LogModel> logs, int upToIndex) {
    int balance = 0;
    for (int i = 0; i <= upToIndex; i++) {
      final log = logs[i];
      if ((log.logType == LogType.cashExpense ||
              log.logType == LogType.fuelFill) &&
          log.paidBy == PaidBy.driver) {
        balance += log.amount;
      } else if (log.logType == LogType.paymentReceived ||
          log.logType == LogType.advance ||
          log.logType == LogType.loan) {
        balance -= log.amount;
      }
    }
    return balance;
  }
}

class _LedgerSummary {
  final int totalExpenses;
  final int totalReceived;
  final int balance;

  const _LedgerSummary({
    required this.totalExpenses,
    required this.totalReceived,
    required this.balance,
  });

  static _LedgerSummary compute(List<LogModel> logs) {
    int expenses = 0;
    int received = 0;
    for (final log in logs) {
      if ((log.logType == LogType.cashExpense ||
              log.logType == LogType.fuelFill) &&
          log.paidBy == PaidBy.driver) {
        expenses += log.amount;
      } else if (log.logType == LogType.paymentReceived ||
          log.logType == LogType.advance ||
          log.logType == LogType.loan) {
        received += log.amount;
      }
    }
    return _LedgerSummary(
      totalExpenses: expenses,
      totalReceived: received,
      balance: expenses - received,
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final _LedgerSummary summary;
  const _SummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final isOwed = summary.balance > 0;

    return Container(
      padding: const EdgeInsets.all(20),
      color: isOwed
          ? AppColors.income.withValues(alpha: 0.06)
          : AppColors.neutral.withValues(alpha: 0.04),
      child: Column(
        children: [
          Text(
            isOwed ? 'Company Owes You' : 'All Settled',
            style: TextStyle(
              color: isOwed ? AppColors.income : AppColors.neutral,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppFormatters.formatAmount(summary.balance.abs()),
            style: TextStyle(
              color: isOwed ? AppColors.income : AppColors.neutral,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  label: 'You Spent (DR)',
                  amount: summary.totalExpenses,
                  color: AppColors.expense,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryTile(
                  label: 'You Received (CR)',
                  amount: summary.totalReceived,
                  color: AppColors.income,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String label;
  final int amount;
  final Color color;

  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(color: color, fontSize: 11)),
          const SizedBox(height: 4),
          Text(
            AppFormatters.formatAmount(amount),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _LedgerRow extends StatelessWidget {
  final LogModel log;
  final int runningBalance;

  const _LedgerRow({
    required this.log,
    required this.runningBalance,
  });

  @override
  Widget build(BuildContext context) {
    final isDebit = (log.logType == LogType.cashExpense ||
            log.logType == LogType.fuelFill) &&
        log.paidBy == PaidBy.driver;
    final isCredit = log.logType == LogType.paymentReceived ||
        log.logType == LogType.advance ||
        log.logType == LogType.loan;

    if (!isDebit && !isCredit) return const SizedBox.shrink();

    final entryColor = isDebit ? AppColors.expense : AppColors.income;
    final prefix = isDebit ? 'DR' : 'CR';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // DR/CR badge
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: entryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                prefix,
                style: TextStyle(
                  color: entryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _typeLabel(log.logType),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
                Text(
                  AppFormatters.formatRelative(log.createdAt),
                  style: const TextStyle(
                      color: AppColors.neutral, fontSize: 11),
                ),
              ],
            ),
          ),
          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppFormatters.formatAmount(log.amount),
                style: TextStyle(
                  color: entryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                'Bal: ${AppFormatters.formatAmount(runningBalance.abs())}',
                style: const TextStyle(
                    color: AppColors.neutral, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _typeLabel(LogType t) {
    switch (t) {
      case LogType.fuelFill:
        return 'Fuel Fill';
      case LogType.cashExpense:
        return 'Cash Expense';
      case LogType.paymentReceived:
        return 'Payment Received';
      case LogType.advance:
        return 'Advance';
      case LogType.loan:
        return 'Loan / Credit';
      default:
        return 'Other';
    }
  }
}

class _EmptyLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              size: 56, color: AppColors.neutral),
          SizedBox(height: 16),
          Text('No ledger entries yet',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutral,
                  fontSize: 16)),
          SizedBox(height: 8),
          Text(
            'Expenses and payments will appear here.',
            style: TextStyle(color: AppColors.neutral, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

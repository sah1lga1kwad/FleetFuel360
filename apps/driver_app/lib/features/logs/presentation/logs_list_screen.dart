import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/static_map_thumbnail.dart';

// Provider for filter state
final _logTypeFilterProvider = StateProvider<LogType?>((ref) => null);

class LogsListScreen extends ConsumerWidget {
  const LogsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(_logTypeFilterProvider);
    final logsAsync = ref.watch(allLogsStreamProvider(selectedType));

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          _FilterChipsRow(selected: selectedType),
          const Divider(height: 1),
          // Log list
          Expanded(
            child: logsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (logs) => logs.isEmpty
                  ? _EmptyLogs(hasFilter: selectedType != null)
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: logs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => _LogListTile(log: logs[i]),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) => _FilterSheet(
        selected: ref.read(_logTypeFilterProvider),
        onSelect: (type) {
          ref.read(_logTypeFilterProvider.notifier).state = type;
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _FilterChipsRow extends ConsumerWidget {
  final LogType? selected;
  const _FilterChipsRow({required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            isSelected: selected == null,
            onTap: () =>
                ref.read(_logTypeFilterProvider.notifier).state = null,
          ),
          ...LogType.values.map((t) => _FilterChip(
                label: _typeLabel(t),
                isSelected: selected == t,
                color: _typeColor(t),
                onTap: () =>
                    ref.read(_logTypeFilterProvider.notifier).state = t,
              )),
        ],
      ),
    );
  }

  String _typeLabel(LogType t) {
    switch (t) {
      case LogType.fuelFill:
        return 'Fuel';
      case LogType.cashExpense:
        return 'Expense';
      case LogType.paymentReceived:
        return 'Received';
      case LogType.advance:
        return 'Advance';
      case LogType.loan:
        return 'Loan';
      case LogType.other:
        return 'Other';
    }
  }

  Color _typeColor(LogType t) {
    switch (t) {
      case LogType.fuelFill:
        return AppColors.fuel;
      case LogType.cashExpense:
        return AppColors.expense;
      case LogType.paymentReceived:
        return AppColors.income;
      case LogType.advance:
        return AppColors.primary;
      case LogType.loan:
        return AppColors.warning;
      case LogType.other:
        return AppColors.neutral;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    this.color = AppColors.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _LogListTile extends StatelessWidget {
  final LogModel log;
  const _LogListTile({required this.log});

  @override
  Widget build(BuildContext context) {
    final isExpense =
        log.logType == LogType.cashExpense || log.logType == LogType.fuelFill;
    final amountColor = isExpense ? AppColors.expense : AppColors.income;
    final amountPrefix = isExpense ? '-' : '+';

    return GestureDetector(
      onTap: () => context.push('/log/${log.logId}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            StaticMapThumbnail(
              latitude: log.location.latitude,
              longitude: log.location.longitude,
              width: 60,
              height: 60,
              borderRadius: 10,
              noLocationLabel: 'No GPS',
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_typeLabel(log.logType),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  if (log.description.isNotEmpty)
                    Text(
                      log.description,
                      style: const TextStyle(
                          color: AppColors.neutral, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    AppFormatters.formatRelative(log.createdAt),
                    style: const TextStyle(
                        color: AppColors.neutral, fontSize: 11),
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
                    fontSize: 14,
                  ),
                ),
                if (log.odometerReading > 0)
                  Text(
                    AppFormatters.formatOdometer(log.odometerReading),
                    style: const TextStyle(
                        color: AppColors.neutral, fontSize: 11),
                  ),
              ],
            ),
          ],
        ),
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
      case LogType.other:
        return 'Other';
    }
  }
}

class _EmptyLogs extends StatelessWidget {
  final bool hasFilter;
  const _EmptyLogs({required this.hasFilter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt_long_outlined,
              size: 56, color: AppColors.neutral),
          const SizedBox(height: 16),
          Text(
            hasFilter ? 'No logs for this filter' : 'No logs yet',
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.neutral,
                fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            hasFilter
                ? 'Try a different filter or add a new log.'
                : 'Tap + to add your first log.',
            style: const TextStyle(color: AppColors.neutral, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final LogType? selected;
  final void Function(LogType?) onSelect;

  const _FilterSheet({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter by Type',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const Divider(),
            _FilterTile(
              label: 'All Types',
              isSelected: selected == null,
              onTap: () => onSelect(null),
            ),
            ...LogType.values.map((t) => _FilterTile(
                  label: _typeLabel(t),
                  isSelected: selected == t,
                  onTap: () => onSelect(t),
                )),
          ],
        ),
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
      case LogType.other:
        return 'Other';
    }
  }
}

class _FilterTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.primary)
          : null,
      onTap: onTap,
    );
  }
}

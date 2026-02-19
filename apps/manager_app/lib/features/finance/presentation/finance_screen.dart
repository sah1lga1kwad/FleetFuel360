import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/analytics/fleet_analytics.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class FinanceScreen extends ConsumerStatefulWidget {
  const FinanceScreen({super.key});

  @override
  ConsumerState<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends ConsumerState<FinanceScreen> {
  DateTimeRange? _range;
  final Set<String> _selectedDriverIds = {};
  LogType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(companyLogsProvider(300)).valueOrNull ?? [];
    final drivers = ref.watch(companyDriversProvider).valueOrNull ?? [];
    final driverById = {for (final d in drivers) d.userId: d};

    final filtered = logs.where((log) {
      if (_range != null) {
        if (log.createdAt.isBefore(_range!.start) ||
            log.createdAt.isAfter(_range!.end)) {
          return false;
        }
      }
      if (_selectedDriverIds.isNotEmpty &&
          !_selectedDriverIds.contains(log.driverId)) {
        return false;
      }
      if (_selectedType != null && log.logType != _selectedType) {
        return false;
      }
      return true;
    }).toList();

    final totalAmount = filtered.fold<int>(0, (s, l) => s + l.amount);
    final fuelTotal = filtered
        .where((l) => l.logType == LogType.fuelFill)
        .fold<int>(0, (s, l) => s + l.amount);
    final expenseTotal = filtered
        .where((l) => l.logType == LogType.cashExpense)
        .fold<int>(0, (s, l) => s + l.amount);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finance'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Logs'), Tab(text: 'Ledger')],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      ActionChip(
                        label: Text(
                          _range == null
                              ? 'Date range'
                              : '${AppFormatters.formatDate(_range!.start)} - ${AppFormatters.formatDate(_range!.end)}',
                        ),
                        onPressed: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                            initialDateRange: _range,
                          );
                          if (picked != null) {
                            setState(() => _range = picked);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        label: Text('Drivers (${_selectedDriverIds.length})'),
                        onPressed: () => _pickDrivers(context, drivers),
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        label: Text(_selectedType == null
                            ? 'Type: All'
                            : _selectedType!.name),
                        onPressed: () => _pickType(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      _MetricChip(
                        label: AppFormatters.formatAmount(totalAmount),
                        sublabel: 'Total',
                      ),
                      _MetricChip(
                          label: '${filtered.length}', sublabel: 'Logs'),
                      _MetricChip(
                        label: AppFormatters.formatAmount(fuelTotal),
                        sublabel: 'Fuel',
                      ),
                      _MetricChip(
                        label: AppFormatters.formatAmount(expenseTotal),
                        sublabel: 'Expense',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final log = filtered[index];
                      final driver = driverById[log.driverId];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          onTap: () => _openLogDetail(context, log, driver),
                          title: Text(
                              '${log.logType.name} • ${AppFormatters.formatAmount(log.amount)}'),
                          subtitle: Text(
                            '${driver?.name ?? log.driverId} • ${log.vehicleId}\n${AppFormatters.formatRelative(log.createdAt)}',
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            _LedgerTab(logs: filtered, drivers: drivers),
          ],
        ),
      ),
    );
  }

  void _pickDrivers(BuildContext context, List<UserModel> drivers) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        final selected = Set<String>.from(_selectedDriverIds);
        return StatefulBuilder(
          builder: (context, setInnerState) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(title: Text('Select drivers')),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final d in drivers)
                          CheckboxListTile(
                            value: selected.contains(d.userId),
                            title: Text(d.name),
                            subtitle: Text(d.phoneNumber),
                            onChanged: (v) {
                              setInnerState(() {
                                if (v == true) {
                                  selected.add(d.userId);
                                } else {
                                  selected.remove(d.userId);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() => _selectedDriverIds.clear());
                              Navigator.pop(context);
                            },
                            child: const Text('Clear'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                _selectedDriverIds
                                  ..clear()
                                  ..addAll(selected);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Apply'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _pickType(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All'),
              onTap: () {
                setState(() => _selectedType = null);
                Navigator.pop(context);
              },
            ),
            for (final type in LogType.values)
              ListTile(
                title: Text(type.name),
                onTap: () {
                  setState(() => _selectedType = type);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _openLogDetail(BuildContext context, LogModel log, UserModel? driver) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        builder: (_, sc) => _LogDetailSheet(
          log: log,
          driver: driver,
          scrollController: sc,
        ),
      ),
    );
  }
}

class _LedgerTab extends ConsumerWidget {
  const _LedgerTab({required this.logs, required this.drivers});

  final List<LogModel> logs;
  final List<UserModel> drivers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overallBalance = logs.fold<int>(0, (sum, _) => sum) +
        drivers.fold<int>(0, (sum, d) {
          final driverLogs = logs.where((l) => l.driverId == d.userId).toList();
          return sum + FleetAnalytics.driverBalance(driverLogs);
        });

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ledger Summary'),
                  const SizedBox(height: 4),
                  Text(
                    AppFormatters.formatAmount(overallBalance.abs()),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: overallBalance >= 0
                          ? AppColors.expense
                          : AppColors.income,
                    ),
                  ),
                  Text(overallBalance >= 0 ? 'Outstanding' : 'Advance'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final driver in drivers)
            Builder(
              builder: (_) {
                final driverLogs =
                    logs.where((l) => l.driverId == driver.userId).toList();
                final balance = FleetAnalytics.driverBalance(driverLogs);
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child:
                          Text(driver.name.isNotEmpty ? driver.name[0] : 'D'),
                    ),
                    title: Text(driver.name),
                    subtitle: Text('${driverLogs.length} transactions'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppFormatters.formatAmount(balance.abs()),
                          style: TextStyle(
                            color: balance > 0
                                ? AppColors.expense
                                : AppColors.income,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          balance > 0 ? 'You owe' : 'Advance',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    onTap: () =>
                        context.push('/fleet/drivers/${driver.userId}'),
                  ),
                );
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRecordPaymentSheet(context, ref, drivers),
        label: const Text('Record Payment'),
        icon: const Icon(Icons.payments),
      ),
    );
  }

  void _showRecordPaymentSheet(
    BuildContext context,
    WidgetRef ref,
    List<UserModel> drivers,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _RecordPaymentBottomSheet(drivers: drivers),
    );
  }
}

class _RecordPaymentBottomSheet extends ConsumerStatefulWidget {
  const _RecordPaymentBottomSheet({required this.drivers});

  final List<UserModel> drivers;

  @override
  ConsumerState<_RecordPaymentBottomSheet> createState() =>
      _RecordPaymentBottomSheetState();
}

class _RecordPaymentBottomSheetState
    extends ConsumerState<_RecordPaymentBottomSheet> {
  String? _driverId;
  final _amountCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _mode = 'cash';
  bool _submitting = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(currentManagerProvider).valueOrNull;
    final assignmentByDriver = ref.watch(assignmentByDriverProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Record Payment'),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _driverId,
            decoration: const InputDecoration(labelText: 'Driver'),
            items: widget.drivers
                .map((d) =>
                    DropdownMenuItem(value: d.userId, child: Text(d.name)))
                .toList(),
            onChanged: (value) => setState(() => _driverId = value),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount (INR)'),
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            selected: {_mode},
            segments: const [
              ButtonSegment(value: 'cash', label: Text('Cash')),
              ButtonSegment(value: 'upi', label: Text('UPI')),
              ButtonSegment(
                  value: 'bank_transfer', label: Text('Bank Transfer')),
            ],
            onSelectionChanged: (value) => setState(() => _mode = value.first),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesCtrl,
            decoration: const InputDecoration(labelText: 'Notes'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _submitting || manager == null || _driverId == null
                ? null
                : () async {
                    final assignment = assignmentByDriver[_driverId!];
                    final amountMajor =
                        double.tryParse(_amountCtrl.text.trim());
                    if (assignment == null ||
                        manager.companyId == null ||
                        amountMajor == null ||
                        amountMajor <= 0) {
                      return;
                    }

                    setState(() => _submitting = true);
                    try {
                      final amount = AppFormatters.currencyToPaise(amountMajor);
                      await ref
                          .read(firestoreServiceProvider)
                          .managerCreatePayment(
                            driverId: _driverId!,
                            vehicleId: assignment.vehicleId,
                            companyId: manager.companyId!,
                            assignmentId: assignment.assignmentId,
                            amount: amount,
                            paymentMode: _mode,
                            notes: _notesCtrl.text.trim(),
                            managerId: manager.userId,
                          );

                      if (mounted) {
                        final driver = widget.drivers
                            .firstWhere((d) => d.userId == _driverId!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Payment of ${AppFormatters.formatAmount(amount)} recorded for ${driver.name}',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    } finally {
                      if (mounted) setState(() => _submitting = false);
                    }
                  },
            child: _submitting
                ? const SizedBox(
                    height: 18, width: 18, child: CircularProgressIndicator())
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.sublabel});

  final String label;
  final String sublabel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text(sublabel,
              style: const TextStyle(fontSize: 11, color: AppColors.neutral)),
        ],
      ),
    );
  }
}

class _LogDetailSheet extends StatelessWidget {
  const _LogDetailSheet({
    required this.log,
    required this.driver,
    required this.scrollController,
  });

  final LogModel log;
  final UserModel? driver;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final images = [
      ...log.receiptImageUrls,
      if (log.odometerImageUrl != null && log.odometerImageUrl!.isNotEmpty)
        log.odometerImageUrl!,
      if (log.fuelMeterImageUrl != null && log.fuelMeterImageUrl!.isNotEmpty)
        log.fuelMeterImageUrl!,
      if (log.vehicleImageUrl != null && log.vehicleImageUrl!.isNotEmpty)
        log.vehicleImageUrl!,
    ];

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Text('Log Details', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 8),
        Text('${driver?.name ?? log.driverId} • ${log.vehicleId}'),
        Text(AppFormatters.formatDateTime(log.createdAt)),
        const SizedBox(height: 8),
        if (images.isNotEmpty)
          SizedBox(
            height: 210,
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (_, index) {
                final imageUrl = images[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AppBar(),
                          body: PhotoView(
                            imageProvider: CachedNetworkImageProvider(imageUrl),
                          ),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kv('Type', log.logType.name),
                _kv('Category', log.category.name),
                _kv('Amount', AppFormatters.formatAmount(log.amount)),
                _kv('Paid By', log.paidBy.name),
                _kv('Payment Mode', log.paymentMode.name),
                _kv('Description',
                    log.description.isEmpty ? '-' : log.description),
                _kv('Notes', log.notes.isEmpty ? '-' : log.notes),
                _kv('Odometer', '${log.odometerReading}'),
                _kv('Fuel Litres', log.fuelQuantityLitres.toStringAsFixed(2)),
              ],
            ),
          ),
        ),
        if (log.isEdited)
          ExpansionTile(
            title: Text('Edited ${log.editHistory.length} time(s)'),
            children: log.editHistory
                .map(
                  (edit) => ListTile(
                    title: Text(
                        'Edited ${AppFormatters.formatRelative(edit.editedAt)}'),
                    subtitle: Text(
                        edit.reason.isEmpty ? 'No reason given' : edit.reason),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _kv(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(key)),
          Expanded(
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

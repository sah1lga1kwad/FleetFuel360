import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class EditLogScreen extends ConsumerStatefulWidget {
  final String logId;
  const EditLogScreen({super.key, required this.logId});

  @override
  ConsumerState<EditLogScreen> createState() => _EditLogScreenState();
}

class _EditLogScreenState extends ConsumerState<EditLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _odometerCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();

  LogModel? _originalLog;
  bool _isLoading = true;
  bool _isSaving = false;
  PaymentMode _paymentMode = PaymentMode.cash;
  PaidBy _paidBy = PaidBy.driver;

  @override
  void initState() {
    super.initState();
    _loadLog();
  }

  Future<void> _loadLog() async {
    final firestoreService = ref.read(firestoreServiceProvider);
    // Watch the log by ID via Firestore
    // We use a one-time read here for the edit screen initial state
    await Future.delayed(Duration.zero); // let widget tree build
    final log = await firestoreService.getLog(widget.logId);
    if (log != null && mounted) {
      setState(() {
        _originalLog = log;
        _amountCtrl.text = AppFormatters.paiseToCurrency(log.amount)
            .toStringAsFixed(2);
        _descCtrl.text = log.description;
        _notesCtrl.text = log.notes;
        _odometerCtrl.text =
            log.odometerReading > 0 ? log.odometerReading.toString() : '';
        _paymentMode = log.paymentMode;
        _paidBy = log.paidBy;
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _descCtrl.dispose();
    _notesCtrl.dispose();
    _odometerCtrl.dispose();
    _reasonCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_originalLog == null) return;

    final reason = _reasonCtrl.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a reason for editing.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final user = ref.read(currentUserProvider);
      final firestoreService = ref.read(firestoreServiceProvider);

      final editEntry = EditHistoryEntry(
        editedByDriverId: user?.userId ?? '',
        editedAt: DateTime.now(),
        reason: reason,
        previousValues: {
          'amount': _originalLog!.amount,
          'odometerReading': _originalLog!.odometerReading,
        },
      );

      final updatedLog = _originalLog!.copyWith(
        amount: AppFormatters.parseToPaise(_amountCtrl.text),
        description: _descCtrl.text.trim(),
        notes: _notesCtrl.text.trim(),
        odometerReading: int.tryParse(_odometerCtrl.text) ??
            _originalLog!.odometerReading,
        paymentMode: _paymentMode,
        paidBy: _paidBy,
        editHistory: [..._originalLog!.editHistory, editEntry],
        updatedAt: DateTime.now(),
      );

      await firestoreService.updateLog(
        _originalLog!.logId,
        updatedLog.toFirestore(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Log updated successfully'),
            backgroundColor: AppColors.income,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update: $e'),
            backgroundColor: AppColors.expense,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_originalLog == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Log')),
        body: const Center(child: Text('Log not found')),
      );
    }

    final log = _originalLog!;
    final isCashExpense = log.logType == LogType.cashExpense;
    final isMoneyIn = log.logType == LogType.paymentReceived ||
        log.logType == LogType.advance ||
        log.logType == LogType.loan;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Log')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_outlined,
                        color: AppColors.warning, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Edits are logged with a reason and timestamp.',
                        style:
                            TextStyle(color: AppColors.warning, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Odometer
              if (!isMoneyIn) ...[
                TextFormField(
                  controller: _odometerCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Odometer Reading (km)',
                    prefixIcon: Icon(Icons.speed),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 16),
              ],

              // Description (expense only)
              if (isCashExpense) ...[
                TextFormField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.notes),
                  ),
                  validator: (v) =>
                      AppValidators.required(v, field: 'Description'),
                ),
                const SizedBox(height: 16),
              ],

              // Amount
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(
                  labelText: 'Amount (₹)',
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: AppValidators.amount,
              ),
              const SizedBox(height: 16),

              // Payment Mode
              Text('Payment Mode',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: (isMoneyIn
                        ? [
                            PaymentMode.cash,
                            PaymentMode.upi,
                            PaymentMode.bankTransfer
                          ]
                        : [
                            PaymentMode.cash,
                            PaymentMode.upi,
                            PaymentMode.card,
                            PaymentMode.fuelCard
                          ])
                    .map((mode) => _ModeChip(
                          label: _paymentModeLabel(mode),
                          isSelected: _paymentMode == mode,
                          onTap: () => setState(() => _paymentMode = mode),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Paid By
              if (!isMoneyIn) ...[
                Text('Paid By',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: PaidBy.values
                      .map((pb) => _ModeChip(
                            label: pb == PaidBy.driver ? 'Me' : 'Company',
                            isSelected: _paidBy == pb,
                            onTap: () => setState(() => _paidBy = pb),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],

              // Notes
              TextFormField(
                controller: _notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  prefixIcon: Icon(Icons.comment_outlined),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Reason for edit (required)
              TextFormField(
                controller: _reasonCtrl,
                decoration: const InputDecoration(
                  labelText: 'Reason for Edit *',
                  hintText: 'e.g. Corrected fuel quantity',
                  prefixIcon: Icon(Icons.edit_note),
                ),
                validator: (v) =>
                    AppValidators.required(v, field: 'Edit reason'),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Changes'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _paymentModeLabel(PaymentMode m) {
    switch (m) {
      case PaymentMode.cash:
        return 'Cash';
      case PaymentMode.upi:
        return 'UPI';
      case PaymentMode.card:
        return 'Card';
      case PaymentMode.fuelCard:
        return 'Fuel Card';
      case PaymentMode.bankTransfer:
        return 'Bank';
      case PaymentMode.other:
        return 'Other';
    }
  }
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE0E0E0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.neutral,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

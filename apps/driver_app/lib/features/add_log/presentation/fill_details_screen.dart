import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import 'add_log_flow_notifier.dart';
import '../../../core/theme/app_theme.dart';

class FillDetailsScreen extends ConsumerStatefulWidget {
  const FillDetailsScreen({super.key});

  @override
  ConsumerState<FillDetailsScreen> createState() => _FillDetailsScreenState();
}

class _FillDetailsScreenState extends ConsumerState<FillDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _odometerCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _fuelQtyCtrl = TextEditingController();
  final _fuelPriceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  LogCategory _category = LogCategory.other;
  PaymentMode _paymentMode = PaymentMode.cash;
  PaidBy _paidBy = PaidBy.driver;

  @override
  void initState() {
    super.initState();
    // Pre-fill from existing state if editing
    final flow = ref.read(addLogFlowProvider);
    if (flow.odometerReading > 0) {
      _odometerCtrl.text = flow.odometerReading.toString();
    }
    if (flow.amount > 0) {
      _amountCtrl.text = AppFormatters.paiseToCurrency(flow.amount)
          .toStringAsFixed(2);
    }
    if (flow.fuelQuantityLitres > 0) {
      _fuelQtyCtrl.text = flow.fuelQuantityLitres.toStringAsFixed(2);
    }
    if (flow.fuelPricePerLitre > 0) {
      _fuelPriceCtrl.text = flow.fuelPricePerLitre.toStringAsFixed(2);
    }
    _descCtrl.text = flow.description;
    _notesCtrl.text = flow.notes;
    _category = flow.category;
    _paymentMode = flow.paymentMode;
    _paidBy = flow.paidBy;

    // Auto-calculate amount when fuel details change
    _fuelQtyCtrl.addListener(_recalculateFuelAmount);
    _fuelPriceCtrl.addListener(_recalculateFuelAmount);
  }

  void _recalculateFuelAmount() {
    final qty = double.tryParse(_fuelQtyCtrl.text) ?? 0;
    final price = double.tryParse(_fuelPriceCtrl.text) ?? 0;
    if (qty > 0 && price > 0) {
      _amountCtrl.text = (qty * price).toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _odometerCtrl.dispose();
    _amountCtrl.dispose();
    _fuelQtyCtrl.dispose();
    _fuelPriceCtrl.dispose();
    _descCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    final amount = AppFormatters.parseToPaise(_amountCtrl.text);
    ref.read(addLogFlowProvider.notifier).updateDetails(
          odometerReading: int.tryParse(_odometerCtrl.text) ?? 0,
          category: _category,
          amount: amount,
          paymentMode: _paymentMode,
          paidBy: _paidBy,
          fuelQuantityLitres:
              double.tryParse(_fuelQtyCtrl.text) ?? 0,
          fuelPricePerLitre:
              double.tryParse(_fuelPriceCtrl.text) ?? 0,
          description: _descCtrl.text.trim(),
          notes: _notesCtrl.text.trim(),
        );
    context.push('/log/add/review');
  }

  @override
  Widget build(BuildContext context) {
    final logType =
        ref.watch(addLogFlowProvider).logType ?? LogType.other;
    final isFuel = logType == LogType.fuelFill;
    final isMoneyIn = logType == LogType.paymentReceived ||
        logType == LogType.advance ||
        logType == LogType.loan;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 3 of 4 — Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Odometer (all types except money-in)
              if (!isMoneyIn) ...[
                _buildTextField(
                  controller: _odometerCtrl,
                  label: 'Odometer Reading (km)',
                  hint: 'e.g. 45230',
                  icon: Icons.speed,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: AppValidators.odometerReading,
                ),
                const SizedBox(height: 16),
              ],

              // Fuel-specific fields
              if (isFuel) ...[
                _buildTextField(
                  controller: _fuelQtyCtrl,
                  label: 'Fuel Quantity (Litres)',
                  hint: 'e.g. 35.5',
                  icon: Icons.water_drop_outlined,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _fuelPriceCtrl,
                  label: 'Price per Litre (₹)',
                  hint: 'e.g. 96.50',
                  icon: Icons.currency_rupee,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 16),
              ],

              // Category (expense only)
              if (logType == LogType.cashExpense) ...[
                DropdownButtonFormField<LogCategory>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: LogCategory.values.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(_categoryLabel(c)),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descCtrl,
                  label: 'Description',
                  hint: 'e.g. Tyre repair at highway',
                  icon: Icons.notes,
                  validator: (v) =>
                      AppValidators.required(v, field: 'Description'),
                ),
                const SizedBox(height: 16),
              ],

              // Amount
              _buildTextField(
                controller: _amountCtrl,
                label: 'Amount (₹)',
                hint: 'e.g. 2500.00',
                icon: Icons.currency_rupee,
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
              _SegmentRow<PaymentMode>(
                options: isMoneyIn
                    ? [PaymentMode.cash, PaymentMode.upi, PaymentMode.bankTransfer]
                    : [PaymentMode.cash, PaymentMode.upi, PaymentMode.card,
                        PaymentMode.fuelCard],
                selected: _paymentMode,
                labelOf: _paymentModeLabel,
                onSelect: (v) => setState(() => _paymentMode = v),
              ),
              const SizedBox(height: 16),

              // Paid By (not for money-in)
              if (!isMoneyIn) ...[
                Text('Paid By',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                const SizedBox(height: 8),
                _SegmentRow<PaidBy>(
                  options: PaidBy.values,
                  selected: _paidBy,
                  labelOf: (v) => v == PaidBy.driver ? 'Me' : 'Company',
                  onSelect: (v) => setState(() => _paidBy = v),
                ),
                const SizedBox(height: 16),
              ],

              // Notes
              _buildTextField(
                controller: _notesCtrl,
                label: 'Notes (Optional)',
                hint: 'Any extra details...',
                icon: Icons.comment_outlined,
                maxLines: 3,
              ),

              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: AppColors.primary, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Location will be auto-captured on submit',
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _next,
                child: const Text('Next: Review & Submit'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
    );
  }

  String _categoryLabel(LogCategory c) {
    switch (c) {
      case LogCategory.fuel:
        return 'Fuel';
      case LogCategory.repair:
        return 'Repair';
      case LogCategory.food:
        return 'Food / Allowance';
      case LogCategory.toll:
        return 'Toll / Tax';
      case LogCategory.tyre:
        return 'Tyre';
      case LogCategory.oil:
        return 'Oil / Lubricants';
      case LogCategory.cleaning:
        return 'Cleaning';
      case LogCategory.fine:
        return 'Traffic Fine';
      case LogCategory.other:
        return 'Other';
    }
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

class _SegmentRow<T> extends StatelessWidget {
  final List<T> options;
  final T selected;
  final String Function(T) labelOf;
  final void Function(T) onSelect;

  const _SegmentRow({
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((opt) {
        final isSelected = opt == selected;
        return GestureDetector(
          onTap: () => onSelect(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : const Color(0xFFE0E0E0),
              ),
            ),
            child: Text(
              labelOf(opt),
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.neutral,
                fontSize: 13,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

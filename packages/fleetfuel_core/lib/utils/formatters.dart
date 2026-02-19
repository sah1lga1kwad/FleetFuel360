import 'package:intl/intl.dart';

class AppFormatters {
  static final _dateTimeFormat = DateFormat('dd MMM yyyy, h:mm a');
  static final _dateFormat = DateFormat('dd MMM yyyy');
  static final _numberFormat = NumberFormat('#,##,##0');
  static final _decimalFormat = NumberFormat('#,##,##0.00');

  /// Format amount from paise to display: 150000 → "₹1,500.00"
  static String formatAmount(int paise, {String currency = 'INR'}) {
    final symbol = _currencySymbol(currency);
    final amount = paise / 100.0;
    return '$symbol${_decimalFormat.format(amount)}';
  }

  /// Format amount in major units (already divided): 1500.0 → "₹1,500.00"
  static String formatAmountMajor(double amount, {String currency = 'INR'}) {
    final symbol = _currencySymbol(currency);
    return '$symbol${_decimalFormat.format(amount)}';
  }

  /// Parse display amount to paise: "1500.50" → 150050
  static int parseToPaise(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^\d.]'), '');
    final value = double.tryParse(cleaned) ?? 0.0;
    return (value * 100).round();
  }

  /// Format DateTime: "15 Jan 2025, 3:45 PM"
  static String formatDateTime(DateTime dt) => _dateTimeFormat.format(dt);

  /// Format date only: "15 Jan 2025"
  static String formatDate(DateTime dt) => _dateFormat.format(dt);

  /// Format relative time: "2 hours ago", "Yesterday", "3 days ago"
  static String formatRelative(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return _dateFormat.format(dt);
  }

  /// Format odometer: 45230 → "45,230 km"
  static String formatOdometer(int reading) =>
      '${_numberFormat.format(reading)} km';

  /// Format litres: 35.5 → "35.5 L"
  static String formatLitres(double litres) =>
      '${litres.toStringAsFixed(1)} L';

  /// Format price per litre: 96.5 → "₹96.50/L"
  static String formatPricePerLitre(double price, {String currency = 'INR'}) {
    final symbol = _currencySymbol(currency);
    return '$symbol${price.toStringAsFixed(2)}/L';
  }

  /// Format speed: 60.0 → "60 km/h"
  static String formatSpeed(double speedMs) {
    final kmh = (speedMs * 3.6).round();
    return '$kmh km/h';
  }

  /// Format battery: 85 → "85%"
  static String formatBattery(int level) => '$level%';

  static String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'INR':
        return '₹';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return currency;
    }
  }

  /// Convert paise to major currency unit double
  static double paiseToCurrency(int paise) => paise / 100.0;

  /// Convert major currency unit to paise
  static int currencyToPaise(double amount) => (amount * 100).round();
}

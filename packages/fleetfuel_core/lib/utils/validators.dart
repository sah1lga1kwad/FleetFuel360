class AppValidators {
  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length < 10) return 'Enter a valid phone number';
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) return 'Amount is required';
    final parsed = double.tryParse(value.replaceAll(',', ''));
    if (parsed == null || parsed <= 0) return 'Enter a valid amount';
    return null;
  }

  static String? odometerReading(String? value) {
    if (value == null || value.trim().isEmpty) return 'Odometer reading is required';
    final parsed = int.tryParse(value.replaceAll(',', ''));
    if (parsed == null || parsed < 0) return 'Enter a valid odometer reading';
    return null;
  }

  static String? companyCode(String? value) {
    if (value == null || value.trim().isEmpty) return 'Company code is required';
    if (value.trim().length != 6) return 'Company code must be 6 characters';
    return null;
  }

  static String? licenseNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'License number is required';
    if (value.trim().length < 5) return 'Enter a valid license number';
    return null;
  }
}

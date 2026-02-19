import 'package:fleetfuel_core/fleetfuel_core.dart';

class FleetAnalytics {
  static double kmPerLitre(LogModel earlier, LogModel later) {
    final km = later.odometerReading - earlier.odometerReading;
    final litres = later.fuelQuantityLitres;
    if (litres <= 0 || km <= 0) return 0;
    return km / litres;
  }

  static double avgFuelEfficiency(List<LogModel> allLogs) {
    final fuelLogs = allLogs
        .where(
          (l) =>
              l.logType == LogType.fuelFill &&
              l.odometerReading > 0 &&
              l.fuelQuantityLitres > 0,
        )
        .toList()
      ..sort((a, b) => a.odometerReading.compareTo(b.odometerReading));
    if (fuelLogs.length < 2) return 0;
    final readings = [
      for (var i = 1; i < fuelLogs.length; i++)
        kmPerLitre(fuelLogs[i - 1], fuelLogs[i]),
    ];
    return readings.reduce((a, b) => a + b) / readings.length;
  }

  // positive = company owes driver | negative = driver owes company
  static int driverBalance(List<LogModel> logs) {
    int balance = 0;
    for (final log in logs) {
      if (log.logType == LogType.cashExpense && log.paidBy == PaidBy.driver) {
        balance += log.amount;
      } else if (log.logType == LogType.paymentReceived ||
          log.logType == LogType.advance) {
        balance -= log.amount;
      }
    }
    return balance;
  }

  static int totalSpend(List<LogModel> logs) =>
      logs.fold(0, (sum, l) => sum + l.amount);

  static Map<LogCategory, int> expenseByCategory(List<LogModel> logs) {
    return {
      for (final cat in LogCategory.values)
        cat: logs
            .where((l) => l.category == cat)
            .fold(0, (s, l) => s + l.amount),
    };
  }

  static Map<DateTime, int> dailySpend(List<LogModel> logs, int days) {
    final result = <DateTime, int>{};
    final now = DateTime.now();
    for (var i = 0; i < days; i++) {
      final day = DateTime(now.year, now.month, now.day - i);
      result[day] = logs
          .where(
            (l) =>
                l.createdAt.year == day.year &&
                l.createdAt.month == day.month &&
                l.createdAt.day == day.day,
          )
          .fold(0, (s, l) => s + l.amount);
    }
    return result;
  }

  static int kmDriven(List<LogModel> logs) {
    final withOdometer = logs.where((l) => l.odometerReading > 0).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    if (withOdometer.length < 2) return 0;
    return withOdometer.last.odometerReading -
        withOdometer.first.odometerReading;
  }
}

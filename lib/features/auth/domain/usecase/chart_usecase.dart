import 'package:intl/intl.dart';

import '../../data/models/models.dart';

class ChartUseCase {
  final List<Transaction> recentTransactions;

  ChartUseCase({required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'value': totalSum
      };
    });
  }

  double get weekTotalValue {
    return groupedTransactionValues.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  double weekTotalValue2(double sum, tr) {
    return weekTotalValue;
  }
}

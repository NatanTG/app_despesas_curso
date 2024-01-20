import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import '../../domain/usecase/usecase.dart';

class ChartController extends ChangeNotifier {
  final TransactionUseCase _transactionUseCase = TransactionUseCase();

  List<Transaction> get _recentTransactions =>
      _transactionUseCase.recentTransactions;

  late final ChartUseCase chartUseCase;

  ChartController() {
    chartUseCase = ChartUseCase(recentTransactions: _recentTransactions);
  }

  List<Transaction> get recentTransactions => _recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return chartUseCase.groupedTransactionValues;
  }

  double get weekTotalValue {
    return chartUseCase.weekTotalValue;
  }
}

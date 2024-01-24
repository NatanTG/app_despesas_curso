import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../../domain/usecase/usecase.dart';

class HomeController extends ChangeNotifier {
  final TransactionUseCase _transactionUseCase = TransactionUseCase();

  List<Transaction> get recentTransactions =>
      _transactionUseCase.recentTransactions;

  void addTransaction(String title, double value, DateTime date) {
    _transactionUseCase.addTransaction(title, value, date);
    notifyListeners();
  }
    notifyListeners();
  }
}

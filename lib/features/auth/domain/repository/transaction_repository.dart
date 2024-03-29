import 'dart:math';

import '../../data/models/models.dart';

class TransactionRepository {
  final List<Transaction> _transactions = [];

  List<Transaction> get recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  addTransaction(String title, double value, DateTime date) {
    final newTransaction = _createNewTransaction(title, value, date);
    _updateTransactionList(newTransaction);
  }

  Transaction _createNewTransaction(String title, double value, DateTime date) {
    return Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
  }

  _updateTransactionList(Transaction newTransaction) {
    _transactions.add(newTransaction);
  }

  removeTransaction(String id) {
    _transactions.removeWhere((tr) => tr.id == id);
  }
}

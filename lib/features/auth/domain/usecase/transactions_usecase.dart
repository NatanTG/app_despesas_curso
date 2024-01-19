import 'dart:math';

import '../../data/models/models.dart';

class TransactionUseCase {
  final List<Transaction> _transactions = [
    Transaction(
        id: 'product1',
        title: 'Tênis Nike',
        value: 230.50,
        date: DateTime.now()),
    Transaction(
        id: 'product2',
        title: 'Camisa Oakley',
        value: 130.50,
        date: DateTime.now()),
    Transaction(
        id: 'product3',
        title: 'Calça Jeans',
        value: 230.50,
        date: DateTime.now()),
  ];

  List<Transaction> get recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void addTransaction(String title, double value) {
    final newTransaction = _createNewTransaction(title, value);
    _updateTransactionList(newTransaction);
  }

  Transaction _createNewTransaction(String title, double value) {
    return Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
  }

  void _updateTransactionList(Transaction newTransaction) {
    _transactions.add(newTransaction);
  }
}

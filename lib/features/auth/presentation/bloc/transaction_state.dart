import '../../data/models/models.dart';

abstract class TransactionState {
  final List<Transaction> transactions;

  TransactionState({
    required this.transactions,
  });
}

class TransactionInitialState extends TransactionState {
  TransactionInitialState() : super(transactions: []);
}

class TransactionLoadingState extends TransactionState {
  TransactionLoadingState(List<Transaction> transactions)
      : super(transactions: []);
}

class TransactionLoadedState extends TransactionState {
  TransactionLoadedState(List<Transaction> transactions)
      : super(transactions: transactions);
}

class TransactionErrorState extends TransactionState {
  final Exception exception;

  TransactionErrorState({
    required this.exception,
  }) : super(transactions: []);
}

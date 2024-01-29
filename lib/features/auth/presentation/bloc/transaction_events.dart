import '../../data/models/models.dart';

abstract class TransactionEvent {}

class GetTransaction extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;

  AddTransaction({
    required this.transaction,
  });
}

class RemoveTransaction extends TransactionEvent {
  final String id;

  RemoveTransaction({
    required this.id,
  });
}

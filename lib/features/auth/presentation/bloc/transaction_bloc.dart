import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../domain/repository/repository.dart';
import 'bloc_exports.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final _repository = TransactionRepository();

  TransactionBloc() : super(TransactionInitialState()) {
    on(_mapEventToState);
  }

  _mapEventToState(TransactionEvent event, Emitter emit) {
    List<Transaction> transactions = [];
    emit(TransactionLoadingState(transactions));

    if (event is GetTransaction) {
      transactions = _repository.recentTransactions;
    } else if (event is AddTransaction) {
      _repository.addTransaction(
        event.transaction.title,
        event.transaction.value,
        event.transaction.date,
      );
      transactions = _repository.recentTransactions;
    } else if (event is RemoveTransaction) {
      _repository.removeTransaction(event.id);
      transactions = _repository.recentTransactions;
    }

    emit(TransactionLoadedState(transactions));
  }
}

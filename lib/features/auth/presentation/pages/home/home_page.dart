import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';
import '../../bloc/bloc_exports.dart';
import '../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TransactionBloc _transactionBloc;
  @override
  void initState() {
    super.initState();
    _transactionBloc = TransactionBloc();
    _transactionBloc.add(GetTransaction());
  }

  _openTransactionFormModal(
      BuildContext context, TransactionBloc transactionBloc) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: (title, value, date) {
            transactionBloc.add(
              AddTransaction(
                transaction: Transaction(
                  id: DateTime.now().toString(),
                  title: title,
                  value: value,
                  date: date,
                ),
              ),
            );
          },
        );
      },
      shape: const BeveledRectangleBorder(),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      bloc: _transactionBloc,
      builder: (context, state) {
        if (state is TransactionInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionLoadedState) {
          return Scaffold(
            appBar: _buildAppBar(
              context,
              _transactionBloc,
            ),
            body: _buildBody(
              context,
              _transactionBloc,
            ),
            floatingActionButton:
                _buildFloatActionButton(context, _transactionBloc),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          return const Center(
            child: Text("Erro ao carregar dados"),
          );
        }
      },
    );
  }

//Widgets extraido em metodos abaixo
  FloatingActionButton _buildFloatActionButton(
      BuildContext context, TransactionBloc transactionBloc) {
    return FloatingActionButton(
      onPressed: () {
        _openTransactionFormModal(context, transactionBloc);
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: const Icon(Icons.add),
    );
  }

  SingleChildScrollView _buildBody(context, TransactionBloc transactionBloc) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
              width: double.infinity,
              child: Chart(
                recentTransactions: transactionBloc.state.transactions,
              )),
          TransactionList(
            transactions: transactionBloc.state.transactions,
            removeTransaction: (id) {
              transactionBloc.add(RemoveTransaction(id: id));
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, TransactionBloc transactionBloc) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: [
        IconButton(
          onPressed: () {
            _openTransactionFormModal(
              context,
              transactionBloc,
            );
          },
          icon: const Icon(Icons.add),
        )
      ],
      title: const Text("Despesas App"),
    );
  }
}

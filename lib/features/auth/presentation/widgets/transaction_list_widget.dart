import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.removeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final transaction = transactions[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      'R\$${transaction.value.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                transaction.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(transaction.date),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: MediaQuery.of(context).size.width > 400
                  ? TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      label: const Text('Excluir'),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () {
                        removeTransaction(transaction.id);
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    Navigator.of(context).pop();
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
            controller: valueController,
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text('Nova Transação'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

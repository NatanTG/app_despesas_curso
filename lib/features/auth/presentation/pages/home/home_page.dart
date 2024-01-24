import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  _openTransactionFormModal(
      BuildContext context, HomeController homeController) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: homeController.addTransaction,
        );
      },
      shape: const BeveledRectangleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);

    return Scaffold(
      appBar: _buildAppBar(context, homeController),
      body: _buildBody(context, homeController),
      floatingActionButton: _buildFloatActionButton(context, homeController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

//Widgets extraido em metodos abaixo
  FloatingActionButton _buildFloatActionButton(
      BuildContext context, HomeController homeController) {
    return FloatingActionButton(
      onPressed: () {
        _openTransactionFormModal(context, homeController);
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: const Icon(Icons.add),
    );
  }

  SingleChildScrollView _buildBody(context, homeController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Chart(
                recentTransactions: homeController.recentTransactions,
              )),
          TransactionList(
            transactions: homeController.recentTransactions,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, HomeController homeController) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: [
        IconButton(
          onPressed: () {
            _openTransactionFormModal(context, homeController);
          },
          icon: const Icon(Icons.add),
        )
      ],
      title: const Text("Despesas App"),
    );
  }
}

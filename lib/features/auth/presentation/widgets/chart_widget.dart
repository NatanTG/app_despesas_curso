import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controllers.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChartController(),
      child: const _ChartBody(),
    );
  }
}

class _ChartBody extends StatelessWidget {
  const _ChartBody({super.key});

  @override
  Widget build(BuildContext context) {
    final chartController = Provider.of<ChartController>(context);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: chartController.groupedTransactionValues.map((tr) {
            return _ChartBar(
                label: tr['day'].toString(),
                value: tr['value'] as double,
                percentage:
                    (tr['value'] as double) / chartController.weekTotalValue);
          }).toList(),
        ),
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const _ChartBar(
      {super.key,
      required this.label,
      required this.value,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text(value.toStringAsFixed(2))),
        const SizedBox(height: 4),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5)),
              ),
              FractionallySizedBox(
                heightFactor: max(0.0, percentage),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

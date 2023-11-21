import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listUiWidget extends StatelessWidget {
  const listUiWidget({super.key, required this.transactionName, required this.expense});

  final String transactionName;
  final String expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 20),
      child: SizedBox(
        height: 70,
        child: Card(
          child: Row(
            children: [
              Text(transactionName),
              const SizedBox(width: 40,),
              Text(expense),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:budgetbuddy/listUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class transcationByBudget extends StatefulWidget {
  final String budget;
  final Map<String, dynamic> transaction;
  const transcationByBudget({super.key, required this.budget, required this.transaction});

  @override
  State<transcationByBudget> createState() => _transcationByBudgetState();
}

class _transcationByBudgetState extends State<transcationByBudget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F6EE),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(intialIndex: 0,),
                    ),
                  );
                }, icon: const Icon(Icons.arrow_back, size: 30, color: Color(0xFFf89361),)),

                const Padding(
                  padding: EdgeInsets.only(left: 90),
                  child: Text('All Transactions',style: TextStyle(fontSize: 22, color: Color(0xFFf89361)),),
                ),





              ],
            ),
            const SizedBox(height: 40,),

            Expanded(
              child: ListView.builder(
                itemCount: widget.transaction.length,
                itemBuilder: (context, index) {
                  String key = widget.transaction.keys.elementAt(index);
                  dynamic value = widget.transaction[key];

                  // Assuming 'value' is a Map<String, dynamic> containing transaction details
                  // Adjust the following code as per your actual data structure
                  return listUiWidget(
                    transactionName: key, // Make sure 'date' is in a suitable format
                    expense: value, // Replace with actual field names
                  );
                },
              ),
            ),

          ],
        ),

      ),
    );
  }
}




import 'package:budgetbuddy/addBudget.dart';
import 'package:budgetbuddy/addCategory.dart';
import 'package:budgetbuddy/addTranscation.dart';
import 'package:flutter/material.dart';


class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context) {

    return const SafeArea(child: Scaffold(
      backgroundColor: Color(0xFFF9F6EE),

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Add Expense', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          SizedBox(height: 40,),
          expenseAdd(title: 'Add Budget', destination: addBudget(),),
          SizedBox(height: 20,),
          expenseAdd(title: 'Add Category', destination: addCategory(),),
          SizedBox(height: 20,),
          expenseAdd(title: 'Add Transcation', destination: addTranscation(),)
        ],
      ),

    )
    );
  }
}


class expenseAdd extends StatelessWidget {
  final String title;
  final Widget destination;
  const expenseAdd({super.key, required this.title, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        );
      },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<
              Color>(const Color(0xFF036661)),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(370.0, 60.0),
          ),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.add_box_rounded),
            const SizedBox(width: 10,),
            Text(title, style: const TextStyle(
              color: Color(0xFFF9F6EE),
              fontSize: 20.0,
            )),
          ],
        ),),
    );
  }
}


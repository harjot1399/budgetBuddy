import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonRowUI.dart';
import 'homePage.dart';

class addTranscation extends StatelessWidget {
  const addTranscation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    builder: (context) => const HomePage(intialIndex: 1,),
                  ),
                );
                }, icon: const Icon(Icons.arrow_back, size: 30, color: Color(0xFFf89361),)),

              const Padding(
                padding: EdgeInsets.only(left: 75),
                child: Text('New Transaction',style: TextStyle(fontSize: 22, color: Color(0xFFf89361)),),
              )

            ],
          ),
          const SizedBox(height: 30,),
          SizedBox(
            height: 400,
            width: 350,
            
            child: Card(
              color: const Color(0xFF114945),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Column(
                children: [
                  //Text('Hello'),
                  commonRowUI(vary: TextField(), varyIcon: Icons.money, text: 'Expense'),
                  SizedBox(height: 15.0,),
                  commonRowUI(vary: TextField(), varyIcon: Icons.category, text: 'Category'),
                  SizedBox(height: 15.0,),
                  commonRowUI(vary: TextField(), varyIcon: Icons.payment, text: 'Budget'),
                  SizedBox(height: 15.0,),
                  commonRowUI(vary: TextField(), varyIcon: Icons.edit_calendar, text: 'Date'),
                  SizedBox(height: 15.0,),
                  commonRowUI(vary: TextField(), varyIcon: Icons.repeat, text: 'Repeat'),

                ],
              )
            ),
          )
        ],
      ),
    );
  }
}






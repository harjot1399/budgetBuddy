import 'package:budgetbuddy/firestoreMethods.dart';
import 'package:flutter/material.dart';

import 'commonRowUI.dart';
import 'homePage.dart';

class addBudget extends StatelessWidget {
  const addBudget({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController budgetName = TextEditingController();
    TextEditingController budgetCash = TextEditingController();
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
                          builder: (context) => const HomePage(intialIndex: 1,),
                        ),
                      );
                    }, icon: const Icon(Icons.arrow_back, size: 30, color: Color(0xFFf89361),)),

                    const Padding(
                      padding: EdgeInsets.only(left: 90),
                      child: Text('New Budget',style: TextStyle(fontSize: 22, color: Color(0xFFf89361)),),
                    ),



                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 180,
                  width: 350,

                  child: Card(
                      color: const Color(0xFF114945),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child:  Column(
                        children: [
                          commonRowUI(vary: TextField(
                            controller: budgetName ,
                          ), varyIcon: Icons.payment, text: 'Name'),
                          const SizedBox(height: 30,),
                          commonRowUI(vary: TextField(
                            controller: budgetCash,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.attach_money, color: Color(0xFFF9F6EE),), // Add a dollar sign icon as a prefix
                            ),
                          ), varyIcon: Icons.money, text: 'Expense'),

                        ],
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: ElevatedButton(onPressed: () {
                    addBudgeToDB(budgetName.text, budgetCash.text, context);

                  },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<
                          Color>(const Color(0xFF114945)),
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
                    child: const Text('Add', style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),),
                ),
              ]
          )
      ),
    );

  }
}

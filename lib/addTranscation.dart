import 'package:budgetbuddy/firestoreMethods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'commonRowUI.dart';
import 'homePage.dart';

class addTranscation extends StatefulWidget {
  const addTranscation({super.key});

  @override
  State<addTranscation> createState() => _addTranscationState();
}

class _addTranscationState extends State<addTranscation> {

  TextEditingController moneyused = TextEditingController();
  String selectedCategory = "Transportation";
  String selectedBudget = "Food";
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {


    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
              height: 380,
              width: 380,

              child: Card(
                  color: const Color(0xFF114945),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      //Text('Hello'),
                      commonRowUI(vary: TextField(
                        controller: moneyused,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.attach_money, color: Color(0xFFF9F6EE),), // Add a dollar sign icon as a prefix
                        ),

                      ), varyIcon: Icons.money, text: 'Expense'),
                      const SizedBox(height: 30.0,),
                      commonRowUI(vary: DropdownButton<String>(
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                        items: <String>[
                          "Transportation",
                          "Food",
                          "Entertainment",
                          // Add more budget categories here
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: const TextStyle(fontSize: 20.0),),
                          );
                        }).toList(),
                      ), varyIcon: Icons.category, text: 'Category'),
                      const SizedBox(height: 30.0,),
                      commonRowUI(vary: DropdownButton<String>(
                        value: selectedBudget,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBudget = newValue!;
                          });
                        },
                        items: <String>[
                          "Transportation",
                          "Food",
                          "Entertainment",
                          // Add more budget categories here
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: const TextStyle(fontSize: 20.0),),
                          );
                        }).toList(),
                      ), varyIcon: Icons.payment, text: 'Budget'),
                      const SizedBox(height: 30.0,),
                      commonRowUI(vary:  GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F6EE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(selectedDate),

                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ), varyIcon: Icons.edit_calendar, text: 'Date'),


                    ],
                  )
              ),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: ElevatedButton(onPressed: () {

                addTranscationToDB(moneyused.text, selectedBudget, selectedCategory, context, DateFormat('yyyy-MM-dd').format(selectedDate),);
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
          ],
        ),
      ),
    );
  }
}







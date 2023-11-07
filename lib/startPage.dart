import 'package:budgetbuddy/showStatsUI.dart';
import 'package:budgetbuddy/transcationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firestoreMethods.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedBudget = "Select a budget";
  bool showStats = true;
  bool showCategories = true;
  List<String> allBudgets = [];
  String expense = "";
  int balance = 0;
  int spend = 0;
  List<dynamic> categories = [];
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    allBudgets = Provider.of<TranscationProvider>(context, listen: false).budgets;

  }

  void showStatsUI() {
    setState(() {
      showStats = true;
      showCategories = false;
    });
  }

  void showCategoriesUI() {
    setState(() {
      showStats = false;
      showCategories = true;
    });
  }

  Future<void> updateBudgetData(String budget) async {
    // Call your fetchBudgetData method and update the state with the returned data
    Map<String, dynamic> data = await fetchBudgetData(context, budget);
    int b = await remainingBudget(context, budget);
    if (data.isNotEmpty) {
      setState(()  {
        selectedBudget = budget;
        expense = data['Expense'].toString();
        balance = b;
        spend = int.parse(expense) - b;
        // Make sure to convert to String if necessary
        // categories = List.from(data['Categories']); // Assuming this is a list
        // transactions = List.from(data['Transactions']); // Assuming this is a list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Expense in build: $expense');

    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFFF9F6EE),
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.pink,
                    ),
                  ),
                  const SizedBox(width: 80.0,),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter dropdownSetState) {
                      return DropdownButton<String>(
                      value: selectedBudget,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          dropdownSetState(() {
                            selectedBudget = newValue;
                          });
                          updateBudgetData(newValue);
                        }
                      },
                      items: allBudgets.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value, style: const TextStyle(fontSize: 20.0),),
                        );
                      }).toList(),


                    );}
                  ),

                ],
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Card(
                  elevation: 4,
                  color: const Color(0xFF96c560),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Add content inside the card
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(balance.toString()),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: SizedBox(
                      width: 150, // Set a fixed width
                      height: 100, // Set a fixed height
                      child: Card(
                        elevation: 4,
                        color: const Color(0xFF96c560),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Income',
                                style: TextStyle(fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Text(expense),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  SizedBox(
                    width: 150, // Set a fixed width
                    height: 100, // Set a fixed height
                    child: Card(
                      elevation: 4,
                      color: const Color(0xFF96c560),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Expense',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(spend.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: 200,
                  height: 410,
                  child: Card(
                    elevation: 4,
                    color: const Color(0xFF96c560),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showStatsUI();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Stats',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20.0,),
                              InkWell(
                                onTap: () {
                                  showCategoriesUI();
                                  // Add your button 2 action here
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Categories',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 20.0,),
                          if (showStats)
                            const Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    showStatsWidget(text: 'Goals',
                                        icon: Icons.outlined_flag,
                                        subText: '6'),
                                    SizedBox(width: 10.0,),
                                    showStatsWidget(text: 'Transcations',
                                        icon: Icons.payment,
                                        subText: '26')

                                  ],
                                ),
                                SizedBox(height: 30.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    showStatsWidget(text: 'Money Saved',
                                        icon: Icons.attach_money,
                                        subText: '20000 Dollars'),
                                    SizedBox(width: 10.0,),
                                    showStatsWidget(text: 'Budgets',
                                        icon: Icons.money,
                                        subText: '4'),
                                  ],
                                ),
                              ],
                            )
                          else
                            const Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    showStatsWidget(text: 'Electricity',
                                        icon: Icons.electrical_services,
                                        subText: '5'),
                                    SizedBox(width: 10.0,),
                                    showStatsWidget(text: 'Transportation',
                                        icon: Icons.emoji_transportation,
                                        subText: '10'),
                                  ],
                                ),
                                SizedBox(height: 30.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    showStatsWidget(text: 'Grocery',
                                        icon: Icons.local_grocery_store,
                                        subText: '5'),
                                    SizedBox(width: 10.0,),
                                    showStatsWidget(text: 'Shopping',
                                        icon: Icons.shopping_bag,
                                        subText: '5'),
                                  ],
                                ),
                              ],
                            )

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }
}



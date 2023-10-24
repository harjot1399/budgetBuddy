
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedBudget = "Transportation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              DropdownButton<String>(
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
              ),

            ],
          ),
          const SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Card(
              elevation: 4,
              color: const Color(0xFFd4d4d9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Add content inside the card
                    Text(
                      'Total Balance',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('10000 Dollars'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: SizedBox(
                  width: 150, // Set a fixed width
                  height: 100, // Set a fixed height
                  child: Card(
                    elevation: 4,
                    color: const Color(0xFFd4d4d9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Income',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text('10000 Dollars'),
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
                  color: const Color(0xFFd4d4d9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Expense',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text('10000 Dollars'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

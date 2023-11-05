import 'package:budgetbuddy/addExpense.dart';
import 'package:budgetbuddy/firestoreMethods.dart';
import 'package:budgetbuddy/settingsPage.dart';
import 'package:budgetbuddy/startPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int intialIndex;
  const HomePage({super.key, required this.intialIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cIndex = 0;

  @override
  void initState() {
    super.initState();
    // Set the initial tab index based on the provided initialIndex
    cIndex = widget.intialIndex;
  }


  final List<Widget> screens = [
    const StartPage(),
    const AddExpense(),
    const SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: cIndex,
            children: screens,
          ),
           // Hide bottom navigation bar when camera icon is clicked
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF036661),
              selectedItemColor: const Color(0xFFf89361),
              unselectedItemColor: const Color(0xFFF9F6EE),
              currentIndex: cIndex,
              onTap: (int index) {
                setState(() {
                  cIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30.0),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded, size: 30.0),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30.0),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



import 'package:budgetbuddy/startPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cIndex = 0;

  final List<Widget> screens = [
    const StartPage()
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
              backgroundColor: const Color(0xFF96c560),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.white,
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
                  icon: Icon(Icons.search, size: 30.0),
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

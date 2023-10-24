import 'package:flutter/material.dart';
import 'loginPage.dart';
void main() {
  runApp(budgetBuddy());
}

class budgetBuddy extends StatelessWidget {

  // This widget is the root of your application.
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFD36675),
      ),
      home: const loginPage(),
    );
  }
}
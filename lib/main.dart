import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'loginPage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line to initialize the binding
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
import 'package:budgetbuddy/firestoreMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';
import 'loginPage.dart';

class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {

            if (snapshot.hasData) {
              User? user = snapshot.data;
              String userEmail = user?.email ?? '';
              getDataFromEmail(userEmail, context);
              return const HomePage(intialIndex: 0,);
            } else {
              return const loginPage();
            }
          }
        },
      ),
    );
  }
}
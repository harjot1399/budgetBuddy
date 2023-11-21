import 'package:budgetbuddy/firestoreMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';
import 'loginPage.dart';

class authPage extends StatefulWidget {
  const authPage({super.key});

  @override
  State<authPage> createState() => _authPageState();
}

class _authPageState extends State<authPage> {


  Future<void> dataFetch() async {
    await budgetsInDB(context);
    await categoriesInDB(context);
  }

  Future<void> _initializeData(User? user) async {
    if (user != null) {
      String userEmail = user.email ?? '';
      await getDataFromEmail(userEmail, context);
      await dataFetch();
    }
  }


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
              // User? user = snapshot.data;
              // String userEmail = user?.email ?? '';
              // getDataFromEmail(userEmail, context);
              // dataFetch();
              // return const HomePage(intialIndex: 0,);
              return FutureBuilder(
                future: _initializeData(snapshot.data),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const HomePage(intialIndex: 0,);
                  }
                },
              );
            } else {
              return const loginPage();
            }
          }
        },
      ),
    );
  }
}




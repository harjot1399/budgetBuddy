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
              dataFetch();
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

// class _authPageState extends State<authPage> {
//
//   bool _isFetchingData = false;
//
//   Future<void> dataFetch() async {
//     await budgetsInDB(context);
//     await categoriesInDB(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             // Start data fetching only if not already fetching
//             if (!_isFetchingData) {
//               _isFetchingData = true; // Set the flag to true to prevent refetching
//               dataFetch().then((_) {
//                 // Once fetching is done, reset the flag and potentially rebuild
//                 setState(() => _isFetchingData = false);
//               }).catchError((error) {
//                 // Handle any errors here
//                 setState(() => _isFetchingData = false);
//               });
//             }
//
//             // Check if still fetching data, show loading indicator
//             if (_isFetchingData) {
//               return const CircularProgressIndicator();
//             } else {
//               // Data has been fetched, return the HomePage
//               return HomePage(intialIndex: 0);
//             }
//           } else {
//             return const loginPage();
//           }
//         },
//       ),
//     );
//   }
// }

// class _authPageState extends State<authPage> {
//   Future<void>? _fetchDataFuture;
//
//   Future<void> dataFetch() async {
//     await budgetsInDB(context);
//     await categoriesInDB(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             // Initialize fetching data if not already initialized
//             User? user = snapshot.data;
//               String userEmail = user?.email ?? '';
//               getDataFromEmail(userEmail, context);
//             _fetchDataFuture ??= dataFetch().catchError((error) {
//               // Log any errors here
//               print('Error fetching data: $error');
//             });
//
//             // Use a FutureBuilder to wait for the data fetching to complete
//             return FutureBuilder(
//               future: _fetchDataFuture,
//               builder: (context, dataSnapshot) {
//                 // Check for errors in data fetching
//                 if (dataSnapshot.hasError) {
//                   // Handle error state
//                   print('FutureBuilder error: ${dataSnapshot.error}');
//                   return Text('Error: ${dataSnapshot.error}');
//                 }
//
//                 switch (dataSnapshot.connectionState) {
//                   case ConnectionState.none:
//                   case ConnectionState.waiting:
//                     return const CircularProgressIndicator();
//                   case ConnectionState.active:
//                   case ConnectionState.done:
//                   // Data fetching is complete, return the HomePage
//                     return const HomePage(intialIndex: 0,);
//                 }
//               },
//             );
//           } else {
//             return const loginPage();
//           }
//         },
//       ),
//     );
//   }
// }
//
// class _authPageState extends State<authPage> {
//   Future<void>? _fetchDataFuture;
//
//   Future<void> dataFetch(String userEmail) async {
//     // First, get user data from the email
//     await getDataFromEmail(userEmail, context);
//     // After getting user data, fetch budgets and categories
//     await budgetsInDB(context);
//     await categoriesInDB(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData && snapshot.data!.email != null) {
//             // Only initialize the data fetch process if we haven't already
//             _fetchDataFuture ??= dataFetch(snapshot.data!.email!).catchError((error) {
//               // Handle any errors here
//               print('Error initializing data fetch: $error');
//             });
//
//             // Use a FutureBuilder to wait for the data fetching to complete
//             return FutureBuilder(
//               future: _fetchDataFuture,
//               builder: (context, dataSnapshot) {
//                 // Check for errors in the data fetching process
//                 if (dataSnapshot.hasError) {
//                   // Handle the error state
//                   print('FutureBuilder error: ${dataSnapshot.error}');
//                   return Text('Error: ${dataSnapshot.error}');
//                 }
//
//                 switch (dataSnapshot.connectionState) {
//                   case ConnectionState.none:
//                   case ConnectionState.waiting:
//                   // If we're still waiting, show a progress indicator
//                     return const CircularProgressIndicator();
//                   case ConnectionState.active:
//                   case ConnectionState.done:
//                   // Once the data is fetched, proceed to the HomePage
//                     return const HomePage(intialIndex: 0,);
//                 }
//               },
//             );
//           } else {
//             // If we do not have user data, return to the login page
//             return const loginPage();
//           }
//         },
//       ),
//     );
//   }
// }




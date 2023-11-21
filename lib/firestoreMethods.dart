import 'package:budgetbuddy/homePage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:budgetbuddy/transcationProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseFirestore store = FirebaseFirestore.instance;

Future<void> getDataFromEmail(String email, BuildContext context) async {
  final dataProvider = Provider.of<ProfileProvider>(context, listen: false);

  DocumentReference docRef = store.collection('Users').doc(email);
  docRef.get().then(
        (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      dataProvider.setUsername(data['Username']);
      dataProvider.setName(data['Name']);
      dataProvider.setEmail(email);
    },
    onError: (e) => print("Error getting document: $e"),
  );
}

Future <void> addTranscationToDB (String expense, String budget, String category, BuildContext context, String date, String name)async {
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference transRef = store.collection('Users').doc(dataProvider.email).collection('Transactions');

    // Assuming date is in a format that Firestore can work with, e.g., 'yyyy-MM-dd'
    final Timestamp dateTimestamp = Timestamp.fromDate(DateTime.parse(date));

    final DocumentReference documentRef = transRef.doc(name);
    await documentRef.set({
      'Expense': expense,
      'Budget': budget,
      'Category': category,
      'Date': dateTimestamp, // Make sure dateTimestamp is a Timestamp object
    });
    final String documentID = documentRef.id;
    final Map<String, dynamic> transactionUpdate = {
      'Transcations.$documentID': expense, // Construct the map with the transaction ID as key and expense as value
    };
    final DocumentReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets').doc(budget);
    await budgetRef.update(transactionUpdate).catchError((error) {
      if (kDebugMode) {
        print('Error updating budget with transaction data: $error');
      }
    });
    try {
      budgetRef.update({
        'Categories' : FieldValue.arrayUnion([category]),
        'nTrans' : FieldValue.increment(1)

      });
    } catch (e) {
      print('Error: $e');
    }

    final DocumentReference categoryRef = store.collection('Users').doc(dataProvider.email).collection('Category').doc(category);
    try {
      categoryRef.update({
        'Transcations' : FieldValue.arrayUnion([documentID])

      });
    } catch (e) {
      print('Error: $e');
    }


    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(intialIndex: 1),
        ),
      );
    }
    
  } catch (e) {
    // Handle Firestore operation errors, e.g., network issues or permission problems
    print('Error: $e');
  }
}

Future <void> addBudgeToDB (String name, String expense,BuildContext context, Map<String, dynamic> transcations, List<String> categories, int nTransactions)async {
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets');
    final listProvider = Provider.of<TranscationProvider>(context, listen: false);

    await budgetRef.doc(name).set({
      'Expense': expense,
      'Transcations': transcations,
      'Categories' : categories,
      'nTrans' : nTransactions
    });
    listProvider.addToBudgets(name);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(intialIndex: 1),
        ),
      );
    }

  } catch (e) {
    // Handle Firestore operation errors, e.g., network issues or permission problems
    print('Error: $e');
  }
}


Future<void> addCategorytoDB (String icon, String name, String color, BuildContext context, List<String> transcations) async{
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Category');
    final listProvider = Provider.of<TranscationProvider>(context, listen: false);

    await budgetRef.doc(name).set({
      'Icon': icon,
      'Color': color,
      'Transcations' : transcations

    });
    listProvider.addToCategories(name);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(intialIndex: 1),
        ),
      );
    }

  } catch (e) {
    // Handle Firestore operation errors, e.g., network issues or permission problems
    print('Error: $e');
  }
}


Future<void> budgetsInDB(BuildContext context) async {
  final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
  final listProvider = Provider.of<TranscationProvider>(context, listen: false);
  final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets');

  try {
    final querySnapshot = await budgetRef.get();
    if (querySnapshot.docs.isEmpty) {
      print('No budgets found in the database.');
    } else {
      for (var doc in querySnapshot.docs) {
        listProvider.addToBudgets(doc.id);
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching budgets: $e");
    }
    rethrow; // Rethrow the error to be caught by the FutureBuilder.
  }
}

Future<void> categoriesInDB(BuildContext context)  async {
  final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
  final listProvider = Provider.of<TranscationProvider>(context, listen: false);
  final CollectionReference categoryRef = store.collection('Users').doc(dataProvider.email).collection('Category');

  try {
    final querySnapshot = await categoryRef.get();
    for (var doc in querySnapshot.docs) {
      listProvider.addToCategories(doc.id);
    }
  } catch (e) {
    print("Error fetching budgets: $e");// Return an empty list in case of an error
  }
}


Future<Map<String, dynamic>> fetchBudgetData(BuildContext context, String budget) async {
  final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
  final DocumentReference budgetRef = FirebaseFirestore.instance.collection('Users').doc(dataProvider.email).collection('Budgets').doc(budget);

  Map<String, dynamic> budgetData = {};

  try {
    DocumentSnapshot budgetDoc = await budgetRef.get();
    if (budgetDoc.exists) {
      budgetData = budgetDoc.data() as Map<String, dynamic>;
    } else {
      print('Budget document does not exist.');
    }
  } catch (e) {
    print('Error fetching budget data: $e');
  }

  return budgetData;
}



Future<int> remainingBudget(BuildContext context, String budgetId) async {
  final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
  final DocumentReference budgetRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(dataProvider.email)
      .collection('Budgets')
      .doc(budgetId);

  try {
    // Get the budget data
    DocumentSnapshot budgetSnapshot = await budgetRef.get();
    if (budgetSnapshot.exists) {
      Map<String, dynamic> budgetData = budgetSnapshot.data() as Map<String, dynamic>;
      // Assuming 'InitialBalance' holds the starting amount for the budget
      int remainingBudget = int.tryParse(budgetData['Expense'].toString()) ?? 0;
      Map<String, dynamic> transactions = budgetData['Transcations'] ?? {};

      // Subtract each transaction's expense from the remaining balance
      for (String expense in transactions.values) {
        // Ensure the value is an integer or can be parsed as one
        remainingBudget -= int.tryParse(expense.toString()) ?? 0;
      }

      // At this point, `remainingBudget` holds the calculated remaining budget
      return remainingBudget;
    } else {
      print("Budget does not exist.");
      return 0; // Return an appropriate value for non-existing budget
    }
  } catch (e) {
    print("Error fetching budgets: $e");
    throw Exception("Error fetching budgets"); // or return an appropriate error value
  }
}

// Future<void> transactionPerBudget (String budget, List<transactionsinBudget> transcations, BuildContext context)async {
//   final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
//   final DocumentReference budgetRef = FirebaseFirestore.instance
//       .collection('Users')
//       .doc(dataProvider.email)
//       .collection('Budgets')
//       .doc(budget);
//
//   try {
//     DocumentSnapshot documentSnapshot = await budgetRef.get();
//     if (documentSnapshot.exists){
//       Map<String, dynamic> budgetData = documentSnapshot.data() as Map<String, dynamic>;
//       Map<String, dynamic> nMap = budgetData['Transcations'];
//       for (var key in nMap.keys){
//         DocumentSnapshot ref = await FirebaseFirestore.instance
//             .collection('Users')
//             .doc(dataProvider.email)
//             .collection('Transcations')
//             .doc(key).get();
//         if (ref.exists){
//           Map<String, dynamic> data = ref.data() as Map<String, dynamic>;
//           String category = data['Category'];
//           String expense = data['Expense'];
//           String name = key;
//           print(name);
//           DateTime date = data['Date'];
//           DocumentSnapshot catref = await FirebaseFirestore.instance
//               .collection('Users')
//               .doc(dataProvider.email)
//               .collection('Category')
//               .doc(category).get();
//           if (catref.exists){
//             Map<String, dynamic> catdata = catref.data() as Map<String, dynamic>;
//             String icondata = catdata['Icon'];
//             transcations.add(transactionsinBudget(name, category, expense, icondata, date));
//
//           }
//
//
//         }
//
//       }
//     }
//   }catch (e) {
//     if (kDebugMode) {
//       print("Error fetching budgets: $e");
//     }
//     throw Exception("Error fetching budgets"); // or return an appropriate error value
//   }
// }

// Future<Map<String, dynamic>?> transactionPerBudget (String budget, Map <String, dynamic> transactions, BuildContext context)async {
//   final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
//   final DocumentReference budgetRef = FirebaseFirestore.instance
//       .collection('Users')
//       .doc(dataProvider.email)
//       .collection('Budgets')
//       .doc(budget);
//
//   try {
//     DocumentSnapshot documentSnapshot = await budgetRef.get();
//     if (documentSnapshot.exists){
//       Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//       if (data.containsKey('Transcations') && data['Trasncations'] is Map<String, dynamic>) {
//         return data['Transcations'] as Map<String, dynamic>;
//       } else {
//         // Field not found or not the expected type
//         return null;
//       }
//     } else {
//       // Document does not exist
//       return null;
//     }
//
//   }catch (e) {
//     if (kDebugMode) {
//       print("Error fetching budgets: $e");
//     }
//     throw Exception("Error fetching budgets"); // or return an appropriate error value
//   }
//
// }

import 'package:budgetbuddy/homePage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

Future <void> addTranscationToDB (String expense, String budget, String category, BuildContext context, String date)async {
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference transRef = store.collection('Users').doc(dataProvider.email).collection('Transactions');

    // Assuming date is in a format that Firestore can work with, e.g., 'yyyy-MM-dd'
    final Timestamp dateTimestamp = Timestamp.fromDate(DateTime.parse(date));

    await transRef.add({
      'Expense': expense,
      'Budget': budget,
      'Category': category,
      'Date': dateTimestamp
    });
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

Future <void> addBudgeToDB (String name, String expense,BuildContext context)async {
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets');

    await budgetRef.add({
      'Name': name,
      'Expense': expense,

    });
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



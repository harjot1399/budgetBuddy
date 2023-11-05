import 'package:budgetbuddy/homePage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:budgetbuddy/transcationProvider.dart';
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

    final DocumentReference documentRef = await transRef.add({
      'Expense': expense,
      'Budget': budget,
      'Category': category,
      'Date': dateTimestamp,
    });
    final String documentID = documentRef.id;
    final DocumentReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets').doc(budget);
    try {
      budgetRef.update({
        'Transcations' : FieldValue.arrayUnion([documentID]),
        'Categories' : FieldValue.arrayUnion([category])

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

Future <void> addBudgeToDB (String name, String expense,BuildContext context, List<String> transcations, List<String> categorys)async {
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets');

    await budgetRef.doc(name).set({
      'Expense': expense,
      'Transcations': transcations,
      'Categories' : categorys,
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


Future<void> addCategorytoDB (String icon, String name, String color, BuildContext context, List<String> transcations) async{
  try {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Category');

    await budgetRef.doc(name).set({
      'Icon': icon,
      'Color': color,
      'Transcations' : transcations

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


Future<void> budgetsInDB(BuildContext context)  async {
  final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
  final listProvider = Provider.of<TranscationProvider>(context, listen: false);
  final CollectionReference budgetRef = store.collection('Users').doc(dataProvider.email).collection('Budgets');

  try {
    final querySnapshot = await budgetRef.get();
    for (var doc in querySnapshot.docs) {
      listProvider.addToBudgets(doc.id);
    }
  } catch (e) {
    print("Error fetching budgets: $e");// Return an empty list in case of an error
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





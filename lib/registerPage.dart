import 'package:budgetbuddy/loginPage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


  Future<void> regularSignUp() async {
    final dataProvider = Provider.of<ProfileProvider>(context, listen: false);
    dataProvider.setUsername(usernameController.text);
    dataProvider.setName(nameController.text);
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final user = userCredential.user!;
      await FirebaseFirestore.instance.collection('Users').doc(
          user.uid).set({
        'Name': nameController.text,
        'Username': usernameController.text
      }).then((value) {
        //signUp successful
        FirebaseAuth.instance.currentUser!.updateDisplayName(
            nameController.text);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const loginPage(),
            ),
          );
        }
      }).catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      });
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        print(e);
      } else if (e.code == 'invalid-email') {
        // Fluttertoast.showToast(
        //   msg: "The email address is invalid.",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.white,
        //   textColor: Colors.black,
        // );
        print(e);
      } else {
        // Fluttertoast.showToast(
        //   msg: "An error occurred. Please try again later.",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.white,
        //   textColor: Colors.black,
        // );
        print(e);
      }
    } catch (e) {
      // Fluttertoast.showToast(
      //   msg: "An error occurred. Please try again later.",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.white,
      //   textColor: Colors.black,
      // );
      print(e);
    }
      // TODO
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF114945),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF114945),
              child: const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Budget Buddy',
                          style: TextStyle(
                              color: Color(0xFFF9F6EE),
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Track and manage your budget with ease!',
                          style: TextStyle(
                              color: Color(0xFFF9F6EE),
                              fontSize: 18.0
                          ),
                        ),
                      ),

                    ]
                ),
              ),
            ),
          ),
          Expanded(flex: 8,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF9F6EE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Create an Account',

                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                        ),),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text('Full Name*',
                        style: TextStyle(color: Colors.black,
                            fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text('Username*',
                        style: TextStyle(color: Colors.black,
                            fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text('Email*',
                        style: TextStyle(color: Colors.black,
                            fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: 'email@email.com',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text('Password*',
                        style: TextStyle(color: Colors.black,
                            fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: passwordController,
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.key),
                          prefixIconColor: Colors.black,

                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text('Confirm Password*',
                        style: TextStyle(color: Colors.black,
                            fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.key),
                          prefixIconColor: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ElevatedButton(onPressed: () {
                        regularSignUp();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff0114945)),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(200.0, 60.0),
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ), child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFF9F6EE),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),),
                    ),
                    const SizedBox(height: 20.0),
                    Row(children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 90.0),
                        child: Text(
                          'Already have a account? ', style: TextStyle(
                            color: Colors.black, fontSize: 16.0),),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const loginPage(),
                              ),
                            );

                          },
                          child: const Text('Log In', style: TextStyle(
                              color: Color(0xFF114945),
                              fontWeight: FontWeight.bold
                          ),)
                      ),
                    ],)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

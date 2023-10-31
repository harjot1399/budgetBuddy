import 'package:budgetbuddy/homePage.dart';
import 'package:budgetbuddy/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'googleLogo.dart';


class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void authenticateUserIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text
      );


      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(intialIndex: 0,),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
           print('Hello');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Hey');
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF9F6EE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Text('budgetBuddy', style: TextStyle(color: Color(0xFF114945), fontSize: 40.0, fontWeight: FontWeight.bold),),
            const SizedBox(height: 15,),
            const Text('Log in to track and manage your', style: TextStyle(color: Colors.black, fontSize: 22.0),),
            const Text('expenses.', style: TextStyle(color: Colors.black, fontSize: 22.0),),
            const SizedBox(height: 60,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('E-Mail*',
                  style: TextStyle(color: Colors.black,
                      fontSize: 16.0,),
                ),
              ),
            ),
            const SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Password*',
                  style: TextStyle(color: Colors.black,
                    fontSize: 16.0,),
                ),
              ),
            ),
            const SizedBox(height: 5.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(Icons.key),
                  prefixIconColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: ElevatedButton(onPressed: () {
                authenticateUserIn();
              },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<
                        Color>(const Color(0xFF114945)),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(370.0, 60.0),
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                child: const Text('Log In', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),),
            ),
            const SizedBox(height: 20,),
            const Text('Forgot Your Password?', style: TextStyle(fontSize: 18.0, color: Color(0xFF114945)),),
            const SizedBox(height: 22.0,),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0),
              child: const Row(
                children: [
                  Expanded(child: Divider(color: Colors.black)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0),
                    child: Text(
                      'Or Continue With',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: GestureDetector(
                    onTap: (){
                      if (kDebugMode) {
                        print('Icon clicked');
                      }
                      },
                    child: const GoogleLogo(size: 40)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: GestureDetector(
                    onTap: () {
                        print('Icon clicked');

                    },
                    child: const Icon(
                      FontAwesomeIcons.facebook,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50.0,),
            Row(children: [
              const Padding(
                padding: EdgeInsets.only(left: 90.0),
                child: Text('Do not have a account? ',
                  style: TextStyle(
                      color: Colors.black, fontSize: 16.0),),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Register', style: TextStyle(
                      color: Color(0xFF114945),
                      fontWeight: FontWeight.bold
                  ),)
              ),

            ],)


          ],
        ),
      ),
    );
  }
}


import 'package:budgetbuddy/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF96c560),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF96c560),
              child: const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Budget Buddy',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Track and manage your budget with ease!',
                          style: TextStyle(
                              color: Colors.white,
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
                color: Colors.white,
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
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        decoration: InputDecoration(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        decoration: InputDecoration(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        decoration: InputDecoration(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
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

                      },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF96c560)),
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
                            color: Colors.white,
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
                              color: Color(0xFF96c560),
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

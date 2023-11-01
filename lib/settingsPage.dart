import 'package:budgetbuddy/editProfile.dart';
import 'package:budgetbuddy/loginPage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<ProfileProvider>(context);
    final username = pProvider.username;
    final name = pProvider.name;


    return Scaffold(
      backgroundColor: const Color(0xFFF9F6EE),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Settings', style: TextStyle(fontSize: 40.0, color: Color(0xFFf89361),),),
          ),
          const SizedBox(height: 40.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 100.0,
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const editProfile(),
                    ),
                  );

                },
                child: Card(
                  color: const Color(0xFF036661),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.pink,
                        ),

                      ),
                      SizedBox(width: 25.0,),
                      Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Color(0xFFF9F6EE)),),
                            const SizedBox(height: 8.0,),
                            Text(username, style: TextStyle(fontSize: 20.0, color: Color(0xFFF9F6EE)), )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),

                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0,),
          SizedBox(
            height: 260,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                color: Color(0xFF036661),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Column(
                  children: [
                    SectionWidget(text: "Account Settings", icon: Icons.person),
                    Divider(color: Colors.black,),
                    SectionWidget(text: "Security", icon: Icons.security),
                    Divider(color: Colors.black,),
                    SectionWidget(text: "Notifications", icon: Icons.notifications),
                  ],
                )
              ),
            ),
          ),
          const SizedBox(height: 40.0,),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const loginPage(),
                ),
              );
            },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<
                    Color>(const Color(0xFF036661)),
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
              child: const Text('Log Out', style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),),
          ),

        ],
      ),
    );
  }
}


class SectionWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const SectionWidget({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle the click action for each section
        if (kDebugMode) {
          print('$text clicked.');
        }
      },
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: const Color(0xFFf89361),
                  child: Icon(icon, color: Color(0xFFF9F6EE),),
                ),
              ),
            ),
            const SizedBox(width: 30,),
            Text(text, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFFF9F6EE)),),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 10.0,top: 10.0),
              child: Icon(Icons.arrow_forward_ios,size: 20.0,color: Color(0xFFF9F6EE),),
            )
          ],
        ),
      ),
    );
  }
}
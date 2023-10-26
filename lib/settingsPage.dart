import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Settings', style: TextStyle(fontSize: 40.0),),
          ),
          const SizedBox(height: 40.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 100.0,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Row(
                  children: [
                    Padding(
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
                          Text("Harjot Singh", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                          SizedBox(height: 8.0,),
                          Text("Edit your Profile", style: TextStyle(fontSize: 20.0), )

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
          )
        ],
      ),
    );
  }
}

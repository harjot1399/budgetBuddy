import 'package:budgetbuddy/homePage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:budgetbuddy/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final TextEditingController editedUserName = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<ProfileProvider>(context);
    String newUserName = editedUserName.text;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell ( onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(intialIndex: 2),
                      ),
                    );

                  },
                  child: const Text('Cancel', style: TextStyle(fontSize: 20.0),)
                  ),
                ),
                const SizedBox(width: 90.0,),
                const Text('Edit Profile', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell ( onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(intialIndex: 2),
                      ),
                    );

                  },
                      child: const Text('Save', style: TextStyle(fontSize: 20.0, color: Colors.blue),)
                  ),
                ),


              ],
            ),

          ),
          const Divider(color: Colors.grey),
          Stack(
            children: [
              const CircleAvatar(
                maxRadius: 60,
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 0,
                bottom: 0,
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(40),
                  child: InkWell(
                    onTap: () async {

                    },
                    radius: 50,
                    child: const SizedBox(
                      width: 35,
                      height: 35,
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 50.0,),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Username :', style: TextStyle(fontSize: 20.0),),
              ),
              const SizedBox(width: 10.0,),
              SizedBox(width: 270, child: TextField(
                controller: editedUserName,
                decoration: InputDecoration(
                  labelText: pProvider.username
                ),
                onChanged: (user){
                  if (user.isEmpty) {
                    // If the 'TextField' is empty, you can update the provider with the old username
                    pProvider.setUsername(pProvider.username);
                  } else {
                    // If the 'TextField' is not empty, update the provider with the new username
                    pProvider.setUsername(user);
                  }

                },

              ))
            ],
          )


        ],
      ),
    );
  }
}

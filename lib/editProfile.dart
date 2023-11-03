import 'dart:io';
import 'dart:ui';
import 'package:budgetbuddy/cameraUtil.dart';
import 'package:budgetbuddy/homePage.dart';
import 'package:budgetbuddy/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final TextEditingController editedUserName = TextEditingController();

  File? profileImage;

  void _showCameraDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Handle "Take a Live Picture" button pressed
                  final image = await cameraUtil.openCamera(context);
                  setState(() {
                    profileImage = image;
                  });
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Take a Live Picture'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Handle "Select from Gallery" button pressed
                  final image = await cameraUtil.openGallery(context);
                  setState(() {
                    profileImage = image;
                  });

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Select from Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: profileImage != null
                        ? Image.file(profileImage!, fit: BoxFit.cover)
                        : const Center(child: Text('No image selected')),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<ProfileProvider>(context);
    String newUserName = editedUserName.text;

    return SafeArea(child: Scaffold(
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
               GestureDetector(
                 onTap: (){
                   _showImageDialog(context);
                 },
                 child: CircleAvatar(
                  maxRadius: 60,
                  backgroundColor: Colors.pink,
                  backgroundImage: profileImage != null
                      ? MemoryImage(profileImage!.readAsBytesSync())
                      : null,
              ),
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
                      _showCameraDialog(context);

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
    )
    );
  }
}

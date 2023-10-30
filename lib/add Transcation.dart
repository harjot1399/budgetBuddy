import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class addTranscation extends StatelessWidget {
  const addTranscation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(intialIndex: 1,),
                  ),
                );
                }, icon: const Icon(Icons.arrow_back, size: 30,)),

              const Padding(
                padding: EdgeInsets.only(left: 75),
                child: Text('New Transaction',style: TextStyle(fontSize: 22),),
              )

            ],
          )
        ],
      ),
    );
  }
}

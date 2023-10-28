
import 'package:flutter/material.dart';

class showStatsWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final String subText;


  const showStatsWidget({super.key, required this.text, required this.icon, required this.subText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // Set a fixed width
      height: 140, // Set a fixed height
      child: Card(
          elevation: 4,
          color: const Color(0xFFffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 4.0),
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: const Color(0xFF96c560),
                    child: Icon(icon),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text (text, style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(subText,style: const TextStyle(fontSize: 15.0),),
              )
            ],
          )
      ),
    );
  }
}

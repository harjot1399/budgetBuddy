import 'package:flutter/cupertino.dart';

class commonRowUI extends StatelessWidget {
  final Widget vary;
  final IconData varyIcon;
  final String text;
  const commonRowUI({super.key, required this.vary, required this.varyIcon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(varyIcon, color: const Color(0xFFf89361),),
          const SizedBox(width: 10,),
          Text(text, style: const TextStyle(color: Color(0xFFF9F6EE)),),
          const SizedBox(width: 10,),
          Expanded(child: vary)

        ],
      ),
    );
  }
}
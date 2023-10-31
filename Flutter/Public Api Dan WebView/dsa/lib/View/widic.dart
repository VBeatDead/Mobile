import 'package:flutter/material.dart';
import 'package:prak/View/smalltext.dart';

class Widic extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color  IconColor;
  const Widic({
    Key? key,
    required this.icon,
    required this.text,
    required this.IconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: IconColor,),
        Smalltext(text: text),
        SizedBox(width: 5,),
      ],
    );
  }
}
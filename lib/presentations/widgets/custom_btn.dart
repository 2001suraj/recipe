// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  CustomBtn({
    Key? key,
    required this.tap,
    required this.text,
    required this.color,
     required this.textcolor
  }) : super(key: key);
  final VoidCallback tap;
  final String text;
  final Color textcolor;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: color,
      onPressed: tap,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            color: textcolor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2),
      ),
    );
  }
}

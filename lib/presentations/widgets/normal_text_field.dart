import 'package:flutter/material.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField({
    Key? key,
    required this.controller,
    required this.text
  }) : super(key: key);

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.white),
        fillColor: Colors.white24,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

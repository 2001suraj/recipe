import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.password,
  }) : super(key: key);

  final TextEditingController password;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool click = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: widget.password,
      obscureText: click,
      decoration: InputDecoration(
        labelText: 'Your password',
        labelStyle: TextStyle(color: Colors.white),
        fillColor: Colors.white24,
        filled: true,
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            click = !click;
            print(click);
          }),
          icon: click
              ? Icon(
                  Icons.visibility,
                  color: Colors.white,
                )
              : Icon(
                  Icons.visibility_off,
                  color: Colors.white,
                ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  CustomRow(
      {Key? key, required this.text1, required this.text2, required this.tap, this.color =Colors.grey,})
      : super(key: key);
  final String text1;
  final String text2;
  final VoidCallback tap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          TextButton(
              onPressed: tap,
              child: Text(
                text2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 25),
              )),
        ],
      ),
    );
  }
}

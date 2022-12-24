import 'package:flutter/material.dart';
Padding StepsRow({required String index, required String text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              index,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ],
    ),
  );
}
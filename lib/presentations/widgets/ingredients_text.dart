import 'package:flutter/material.dart';

Row IngredientsText(BuildContext context,
    {required String text, required String index}) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        index,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ),
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: 3,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    )
  ]);
}

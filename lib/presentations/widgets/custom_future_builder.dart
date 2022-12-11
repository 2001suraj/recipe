import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';

class CustomFutureBuilder extends StatelessWidget {
  CustomFutureBuilder({
    Key? key,
    required this.stream,
  }) : super(key: key);

  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LocalStorage().readdata(),
        builder: (context1, snap) {
          return StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return tText(text: snapshot.data!.docs.length.toString());
              } else {
                return Text('no data found');
              }
            },
          );
        });
  }
}
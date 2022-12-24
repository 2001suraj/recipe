import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
class AuthorContainer extends StatefulWidget {
  const AuthorContainer(
      {Key? key, required this.name, required this.title})
      : super(key: key);

  final String name;

  final String title;

  @override
  State<AuthorContainer> createState() => _AuthorAndFavContainerState();
}

class _AuthorAndFavContainerState extends State<AuthorContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: LocalStorage().readdata(),
          builder: (context1, snap) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' By  ' + widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        );
                      });
                } else {
                  return Text('no data found');
                }
              },
            );
          }),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/other_user_profile.dart';

class FollowingPage extends StatelessWidget {
  static const String routeName = 'following page';
  FollowingPage({
    Key? key,
    required this.email,
    required this.unfollow,
  }) : super(key: key);
  final String email;
  bool unfollow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
        title: Text('Following'),
      ),
      body: Container(
        child: FutureBuilder(
            future: LocalStorage().readdata(),
            builder: (context1, snap) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    // .doc(snap.data.toString())
                    .doc(email)
                    .collection('following')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            snapshot.data!.docs[index]
                                                        ['image'] ==
                                                    'null'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/user1.png'),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['image'],
                                                      ),
                                                    ),
                                                  ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['name'],
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['following'],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        unfollow
                                            ? PopupMenuButton<int>(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Row(
                                                      children: const [
                                                        // Icon(Icons.delete),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Unfollow user")
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                elevation: 2,
                                                onSelected: (value) {
                                                  if (value == 1) {
                                                    _showDialog(context,
                                                        following: snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['following'],
                                                        email: snap.data
                                                            .toString());
                                                  }
                                                },
                                              )
                                            : Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Colors.white,
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text('no data found');
                  }
                },
              );
            }),
      ),
    );
  }

  void _showDialog(BuildContext context,
      {required String email, required String following}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(" Want to unfollow user ? "),
          actions: [
            MaterialButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text("yes"),
              onPressed: () async {
                var item = FirebaseFirestore.instance
                    .collection('user')
                    .doc(email)
                    .collection('following')
                    .doc(following);
                await item.delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

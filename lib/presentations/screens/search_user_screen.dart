// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/other_user_profile.dart';

class SearchUserScreen extends StatelessWidget {
  static const String routeName = 'search user screen';
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Search User'),
        bottom: PreferredSize(
          preferredSize: Size(40, 90),
          child: Container(
            height: 100,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Suggestion',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FutureBuilder(
                      future: LocalStorage().readdata(),
                      builder: (context1, snap) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.docs[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          OtherUserProfilePage.routeName,
                                          arguments: OtherUserProfilePage(
                                            followers: ['followers'],
                                            following: data['following'],
                                            about: data['about'],
                                            email: data['email'],
                                            image: data['image'],
                                            name: data['name'],
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/user1.png'),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['name'],
                                                      ),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['email'],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return FittedBox(child: Text('no data founnd'));
                            }
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

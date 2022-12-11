import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/other_user_profile.dart';

class FollowingPage extends StatelessWidget {
  static const String routeName = 'following page';
  const FollowingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    .doc(snap.data.toString())
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
                                  Text(
                                    data['following'],
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(
                                  //       context,
                                  //       OtherUserProfilePage.routeName,
                                  //       arguments: OtherUserProfilePage(
                                  //         followers: ['followers'],
                                  //         following: data['following'],
                                  //         about: data['about'],
                                  //         email: data['email'],
                                  //         image: data['image'],
                                  //         name: data['name'],
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 8.0),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             snapshot.data!.docs[index]
                                  //                         ['image'] ==
                                  //                     'null'
                                  //                 ? Padding(
                                  //                     padding:
                                  //                         const EdgeInsets.all(
                                  //                             8.0),
                                  //                     child: CircleAvatar(
                                  //                       radius: 30,
                                  //                       backgroundImage: AssetImage(
                                  //                           'assets/images/user1.png'),
                                  //                     ),
                                  //                   )
                                  //                 : Padding(
                                  //                     padding:
                                  //                         const EdgeInsets.all(
                                  //                             8.0),
                                  //                     child: CircleAvatar(
                                  //                       radius: 30,
                                  //                       backgroundImage:
                                  //                           NetworkImage(
                                  //                         snapshot.data!
                                  //                                 .docs[index]
                                  //                             ['image'],
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //             Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(8.0),
                                  //               child: Column(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.start,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Text(
                                  //                     snapshot.data!.docs[index]
                                  //                         ['name'],
                                  //                   ),
                                  //                   Text(
                                  //                     snapshot.data!.docs[index]
                                  //                         ['email'],
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             )
                                  //           ],
                                  //         ),
                                  //         Icon(
                                  //           Icons.arrow_forward_ios_outlined,
                                  //           color: Colors.white,
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
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
}
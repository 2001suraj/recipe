import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';
import 'package:recipe_app/presentations/widgets/custom_future_builder.dart';

class OtherUserProfilePage extends StatelessWidget {
  static const String routeName = 'other user profile page';
  OtherUserProfilePage(
      {Key? key,
      required this.email,
      required this.image,
      required this.name,
      required this.followers,
      required this.following,
      required this.about})
      : super(key: key);
  final String name;
  final String email;
  final String image;
  final String about;
  final List followers;
  final List following;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              image.toString() != 'null'
                  ? CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(image),
                    )
                  : CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/images/user1.png'),
                    ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54),
                child: Column(
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Center(
                        child: Text(
                          about,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: LocalStorage().readdata(),
                        builder: (context, snapshot) {
                          return InkWell(
                            onTap: () async {
                              var user = await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(snapshot.data.toString())
                                  .collection('following')
                                  .doc(email);
                              await user.set({'following': email});
                              print('follow');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Follow  + ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              tText(text: 'Recipes'),
                              tText(text: 'Followers'),
                              tText(text: 'Following'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Spacer(),
                              CustomFutureBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(email)
                                    .collection('recipes')
                                    .snapshots(),
                              ),
                              Spacer(),
                              Spacer(),
                              Text('0'),

                              // FutureBuilder(
                              //     future: LocalStorage().readdata(),
                              //     builder: (context1, snap) {
                              //       return StreamBuilder(
                              //         stream: FirebaseFirestore.instance
                              //             .collection('user')
                              //             .doc(email)
                              //             .collection('following')
                              //             .snapshots(),
                              //         builder: (context,
                              //             AsyncSnapshot<QuerySnapshot>
                              //                 snapshot) {
                              //           if (snapshot.hasData) {
                              //             return Column(
                              //               children: [
                              //                 SizedBox(
                              //                   width: 60,
                              //                   height: 120,
                              //                   child: ListView.builder(
                              //                     itemCount: snapshot
                              //                         .data!.docs.length,
                              //                     itemBuilder:
                              //                         (context, index) {
                              //                       var data = snapshot
                              //                           .data!.docs[index];
                              //                       return Text(
                              //                         data['following'],
                              //                       );
                              //                     },
                              //                   ),
                              //                 ),
                              //                 tText(
                              //                     text: snapshot
                              //                         .data!.docs.length
                              //                         .toString()),
                              //               ],
                              //             );
                              //           } else {
                              //             return Text('no data found');
                              //           }
                              //         },
                              //       );
                              //     }),
                              // CustomFutureBuilder(
                              //   stream: FirebaseFirestore.instance
                              //       .collection('user')
                              //       .doc(email)
                              //       .collection('following')
                              //       .snapshots(),
                              // ),
                              Spacer(),
                              Spacer(),
                              CustomFutureBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(email)
                                    .collection('following')
                                    .snapshots(),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

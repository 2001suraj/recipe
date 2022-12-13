import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/following_page.dart';
import 'package:recipe_app/presentations/pages/uploaded_recipe_page.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';
import 'package:recipe_app/presentations/widgets/custom_future_builder.dart';

class OtherUserProfilePage extends StatefulWidget {
  static const String routeName = 'other user profile page';
  OtherUserProfilePage(
      {Key? key,
      required this.email,
      required this.image,
      required this.name,
      required this.following,
      required this.about})
      : super(key: key);
  final String name;
  final String email;
  final String image;
  final String about;
  final List following;

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  bool isfollow = false;

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
              widget.image.toString() != 'null'
                  ? CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(widget.image),
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
                      widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Center(
                        child: Text(
                          widget.about,
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
                                  .doc(widget.email);
                              await user.set({
                                'name': widget.name,
                                'following': widget.email,
                                'image': widget.image
                              });
                              setState(() {
                                isfollow = true;
                              });
                            },
                            child: isfollow == false
                                ? Container(
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
                                  )
                                : SizedBox(),
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
                              tText(text: 'Recipe'),
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
                              Spacer(),
//recipe
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, UploadedRecipePage.routeName,
                                      arguments: UploadedRecipePage(
                                        owner: false,
                                          email: widget.email));
                                },
                                child: CustomFutureBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('all_recipe')
                                      .where('owner_email',
                                          isEqualTo: widget.email)
                                      .snapshots(),
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                              Spacer(),

                              //following
                              FutureBuilder(
                                  future: LocalStorage().readdata(),
                                  builder: (context1, snap) {
                                    return StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(widget.email)
                                          .collection('following')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    FollowingPage.routeName,
                                                    arguments: FollowingPage(
                                                      unfollow: false,
                                                      email: widget.email,
                                                    ));
                                              },
                                              child: tText(
                                                  text: snapshot
                                                      .data!.docs.length
                                                      .toString()));
                                        } else {
                                          return Text('no data found');
                                        }
                                      },
                                    );
                                  }),
                              Spacer(),
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

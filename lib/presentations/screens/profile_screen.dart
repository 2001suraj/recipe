// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/logout/logout_bloc.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/data/repo/cloud_storage.dart';
import 'package:recipe_app/data/repo/recipe_repo.dart';
import 'package:recipe_app/presentations/pages/edit_profile_page.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'ProfileScreen';
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: SingleChildScrollView(
            primary: true,
            child: Container(
              height: MediaQuery.of(context).size.height * 1.2,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: FutureBuilder(
                            future: LocalStorage().readdata(),
                            builder: (context1, snap) {
                              return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return snap.data.toString() ==
                                                  snapshot.data!.docs[index]
                                                      ['email']
                                              ? snapshot.data!.docs[index]
                                                          ['image'] ==
                                                      'null'
                                                  ? CircleAvatar(
                                                      radius: 130,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/user1.png'),
                                                    )
                                                  : CircleAvatar(
                                                      radius: 130,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['image'],
                                                      ),
                                                    )
                                              : SizedBox();
                                        });
                                  } else {
                                    return FittedBox(
                                        child: Text('no data founnd'));
                                  }
                                },
                              );
                            }),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 60,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, MainScreen.routeName);
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 60,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Logout ?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("No"),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.of(ctx).pop();
                                    context
                                        .read<LogoutBloc>()
                                        .add(logoutAddEvent());
                                    LocalStorage().clear(key: 'name');
                                    LocalStorage().clear(key: 'imageurl');
                                    Navigator.pushReplacementNamed(
                                        context, LoginScreen.routeName);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("yes"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.logout,
                        ),
                      ),
                    ),
                  ),
                  BlocListener<LogoutBloc, LogoutState>(
                      listener: (context, state) {
                        if (state is Logoutsuccess) {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        } else if (state is Logoutfailure) {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        }
                      },
                      child: Container()),
                  Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black38,
                      ),
                      child: FutureBuilder(
                          future: LocalStorage().readdata(),
                          builder: (context1, snap) {
                            return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 180,
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              var user =
                                                  snapshot.data!.docs[index];
                                              if (user['email'] == snap.data) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      user['name'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      child: Text(
                                                        user['about'],
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            EditProfilePage
                                                                .routeName,
                                                            arguments: EditProfilePage(
                                                                about: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['about'],
                                                                ss: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['name'],
                                                                email: snap.data
                                                                    .toString()));
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.white,
                                                        ),
                                                        width: 120,
                                                        height: 40,
                                                        child: Center(
                                                          child: Text(
                                                            'Edit profile',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            }),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        margin: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                tText(text: 'Recipes'),
                                                tText(text: 'Followers'),
                                                tText(text: 'Following'),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            FutureBuilder(
                                                future:
                                                    LocalStorage().readdata(),
                                                builder: (context1, snap) {
                                                  return StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('user')
                                                        .doc(snap.data
                                                            .toString())
                                                        .collection('recipes')
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Spacer(),
                                                            tText(
                                                                text: snapshot
                                                                    .data!
                                                                    .docs
                                                                    .length
                                                                    .toString()),
                                                            Spacer(),
                                                            Spacer(),
                                                            tText(text: '0'),
                                                            Spacer(),
                                                            Spacer(),
                                                            tText(text: '0'),
                                                            Spacer(),
                                                          ],
                                                        );
                                                      } else {
                                                        return Text(
                                                            'no data found');
                                                      }
                                                    },
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
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
                  ),
                  Positioned(
                    top: 650,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                          // color: Colors.black38,
                          ),
                      child: FutureBuilder(
                          future: LocalStorage().readdata(),
                          builder: (context1, snap) {
                            return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(snap.data.toString())
                                  .collection('recipes')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              IndividualPage.routeName,
                                              arguments: IndividualPage(
                                                des: snapshot.data!.docs[index]
                                                    ['description'],
                                                name: snapshot.data!.docs[index]
                                                    ['name'],
                                                time: snapshot.data!.docs[index]
                                                    ['cook_time'],
                                                image: snapshot.data!
                                                    .docs[index]['photourl'],
                                                ingr: snapshot.data!.docs[index]
                                                    ['ingredient'],
                                                step: snapshot.data!.docs[index]
                                                    ['steps'],
                                                title: snapshot
                                                    .data!.docs[index]['title'],
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 200,
                                                width: 170,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['photourl'],
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 130,
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['title'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    PopupMenuButton<int>(
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem(
                                                          value: 1,
                                                          child: Row(
                                                            children: const [
                                                              Icon(
                                                                  Icons.delete),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                  "Delete your recipe")
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                      offset: Offset(0, 100),
                                                      color: Colors.white,
                                                      elevation: 2,
                                                      // on selected we show the dialog box
                                                      onSelected: (value) {
                                                        // if value 1 show dialog
                                                        if (value == 1) {
                                                          _showDialog(context,
                                                              title: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]
                                                                  ['title'],
                                                              email: snap.data
                                                                  .toString());
                                                          // if value 2 show dialog
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  return Text('no data found');
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
        ));
  }

  void _showDialog(BuildContext context,
      {required String title, required String email}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Do you want to delete your receipe ? "),
          actions: [
            MaterialButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text("yes"),
              onPressed: () {
                RecipeRepo().deleteRecipes(title: title, email: email);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Text tText({required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }
}


// Container(
//                       margin: EdgeInsets.all(30),
//                       height: MediaQuery.of(context).size.height * 0.4,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.black38,
//                       ),
//                       child: FutureBuilder(
//                           future: LocalStorage().readdata(),
//                           builder: (context1, snap) {
//                             return StreamBuilder(
//                               stream: FirebaseFirestore.instance
//                                   .collection('user')
//                                   .snapshots(),
//                               builder: (context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 if (snapshot.hasData) {
//                                   return Column();



//  } else {
//                                   return Text('no data found');
//                                 }
//                               },
//                             );
//                           }),
//                     ),
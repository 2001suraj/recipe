// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/logout/logout_bloc.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/edit_profile_page.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'ProfileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 130,
                        backgroundImage: AssetImage('assets/images/user1.png'),
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
                          context.read<LogoutBloc>().add(logoutAddEvent());
                          LocalStorage().clear();
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
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
                    bottom: 180,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      height: MediaQuery.of(context).size.height * 0.3,
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
                                        height: 100,
                                        child: ListView.builder(
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              var user =
                                                  snapshot.data!.docs[index];
                                              if (user['email'] == snap.data) {
                                                return Column(
                                                  children: [
                                                    // if (user['email'] ==
                                                    //     snap.data)
                                                    Text(
                                                      user['name'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
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
                                                            arguments: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['name']);
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
                                      // InkWell(
                                      //   onTap: () {
                                      //     Navigator.pushNamed(context,
                                      //         EditProfilePage.routeName,
                                      //         arguments: snapshot.data!.docs[1]
                                      //             ['name']);
                                      //   },
                                      //   child: Container(
                                      //     decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(15),
                                      //       color: Colors.white,
                                      //     ),
                                      //     width: 120,
                                      //     height: 40,
                                      //     child: Center(
                                      //       child: Text(
                                      //         'Edit profile',
                                      //         style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Spacer(),
                                                tText(text: '0'),
                                                Spacer(),
                                                Spacer(),
                                                tText(text: '0'),
                                                Spacer(),
                                                Spacer(),
                                                tText(text: '0'),
                                                Spacer(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Text('no data found');
                                }
                              },
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
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

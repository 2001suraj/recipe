// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/discover_page.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Activity',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, DiscoverPage.routeName);
                          },
                          child: Text(
                            'Discover',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10),
                        child: SizedBox(
                          height: 40,
                          width: 40,
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
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            return snap.data.toString() ==
                                                    snapshot.data!.docs[index]
                                                        ['email']
                                                ? snapshot.data!.docs[index]
                                                            ['image'] ==
                                                        'null'
                                                    ? CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage: AssetImage(
                                                            'assets/images/user1.png'),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 20,
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
                  ),
                ),
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SingleActivityContainer(),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleActivityContainer extends StatelessWidget {
  const SingleActivityContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height,
          color: Colors.grey,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('user').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              snapshot.data!.docs[index]['image'] == null
                                  ? CircleAvatar(
                                      radius: 23,
                                      child: Icon(
                                        Icons.person,
                                        size: 25,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 23,
                                      backgroundImage: NetworkImage(
                                        snapshot.data!.docs[index]['image'],
                                      ),
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['email'],
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: 460,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(snapshot.data!.docs[index]['email'])
                                  .collection('recipes')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot1) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot1.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Text(
                                                snapshot1.data!.docs[index]
                                                    ['description'],
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    letterSpacing: 1.6),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  IndividualPage.routeName,
                                                  arguments: IndividualPage(
                                                    name: snapshot1.data!
                                                        .docs[index]['owner'],
                                                    des: snapshot1
                                                            .data!.docs[index]
                                                        ['description'],
                                                    time: snapshot1
                                                            .data!.docs[index]
                                                        ['cook_time'],
                                                    image: snapshot1
                                                            .data!.docs[index]
                                                        ['photourl'],
                                                    ingr: snapshot1
                                                            .data!.docs[index]
                                                        ['ingredient'],
                                                    step: snapshot1.data!
                                                        .docs[index]['steps'],
                                                    title: snapshot1.data!
                                                        .docs[index]['title'],
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 280,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            snapshot1.data!
                                                                    .docs[index]
                                                                ['photourl'],
                                                          ),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      height: 60,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot1.data!
                                                                  .docs[index]
                                                              ['title'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            //likes
                                            Text(
                                              '8  Likes ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.comment,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  return Text('no data found');
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 8,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      );
                    });
              } else {
                return Text('no data found');
              }
            },
          ),
        ),
        // Container(
        //   height: 580,
        //   color: Colors.grey,
        //   padding: EdgeInsets.all(20),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //image  name and email
        // Row(
        //   children: [
        //     CircleAvatar(
        //       radius: 23,
        //       child: Icon(
        //         Icons.person,
        //         size: 25,
        //       ),
        //     ),
        //     SizedBox(
        //       width: 20,
        //     ),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           'Ram',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //         Text(
        //           'ram@gmail.com',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // details
        // Text(
        //   'We\'re big  fans of the chinese  takeaway, so we\'re always looking for slimming friendly alternatives. Enter chinese chickens and Brocooli !',
        //   style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 15,
        //       letterSpacing: 1.6),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        //image
        // InkWell(
        //   onTap: () {
        //     Navigator.pushNamed(context, IndividualPage.routeName);
        //   },
        //   child: Stack(
        //     children: [
        //       Container(
        //         height: 280,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20),
        //           image: DecorationImage(
        //               image: AssetImage('assets/images/1.jpg'),
        //               fit: BoxFit.cover),
        //         ),
        //       ),
        //       Positioned(
        //         left: 0,
        //         right: 0,
        //         bottom: 0,
        //         child: Container(
        //           height: 60,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             color: Colors.white.withOpacity(0.7),
        //             borderRadius: BorderRadius.only(
        //               bottomLeft: Radius.circular(20),
        //               bottomRight: Radius.circular(20),
        //             ),
        //           ),
        //           child: Center(
        //             child: Text(
        //               'Chinese Chicken  and Broccoli ',
        //               textAlign: TextAlign.center,
        //               style: Theme.of(context).textTheme.headline5,
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        //likes
        // Text(
        //   '8  Likes ',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 18,
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.favorite_border,
        //         color: Colors.white,
        //         size: 30,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.comment,
        //         color: Colors.white,
        //         size: 30,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.share,
        //         color: Colors.white,
        //         size: 30,
        //       ),
        //     ),
        //   ],
        // )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

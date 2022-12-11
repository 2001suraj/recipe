import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';

class UploadedRecipePage extends StatelessWidget {
  static const String routeName = 'uploaded recipe page';

  const UploadedRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: LocalStorage().readdata(),
              builder: (context1, snap) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(snap.data.toString())
                      .collection('recipes')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        // height: MediaQuery.of(context).size.height * 0.3,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          // scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      IndividualPage.routeName,
                                      arguments: IndividualPage(
                                        des: snapshot.data!.docs[index]
                                            ['description'],
                                        name: snapshot.data!.docs[index]
                                            ['owner'],
                                        time: snapshot.data!.docs[index]
                                            ['cook_time'],
                                        image: snapshot.data!.docs[index]
                                            ['photourl'],
                                        ingr: snapshot.data!.docs[index]
                                            ['ingredient'],
                                        step: snapshot.data!.docs[index]
                                            ['steps'],
                                        title: snapshot.data!.docs[index]
                                            ['title'],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 170,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.docs[index]
                                                ['photourl'],
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          snapshot.data!.docs[index]['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Text('no data found');
                    }
                  },
                );
              }),
        ),
      ),
      //     body: Container(
      //   height: MediaQuery.of(context).size.width,
      //   child: FutureBuilder(
      //     future: LocalStorage().readdata(),
      //     builder: (context, snapshot) {
      //       return StreamBuilder(
      //           stream: FirebaseFirestore.instance.collection('user').snapshots(),
      //           builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //             return GridView.builder(
      //               shrinkWrap: true,
      //               primary: false,
      //               itemCount: snapshot.data!.docs.length,
      //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                   crossAxisCount: 2),
      //               itemBuilder: (context, index) {
      //                 return Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: InkWell(
      //                         onTap: () {
      //                           Navigator.pushNamed(
      //                             context,
      //                             IndividualPage.routeName,
      //                             arguments: IndividualPage(
      //                               name: snapshot.data!.docs[index]['owner'],
      //                               des: snapshot.data!.docs[index]
      //                                   ['description'],
      //                               time: snapshot.data!.docs[index]['cook_time'],
      //                               image: snapshot.data!.docs[index]['photourl'],
      //                               ingr: snapshot.data!.docs[index]
      //                                   ['ingredient'],
      //                               step: snapshot.data!.docs[index]['steps'],
      //                               title: snapshot.data!.docs[index]['title'],
      //                             ),
      //                           );
      //                         },
      //                         child: Stack(
      //                           children: [
      //                             Container(
      //                               decoration: BoxDecoration(
      //                                 borderRadius: BorderRadius.circular(20),
      //                                 image: DecorationImage(
      //                                     image: NetworkImage(snapshot
      //                                         .data!.docs[index]['photourl']),
      //                                     fit: BoxFit.cover),
      //                               ),
      //                               height: 150,
      //                             ),
      //                             Positioned(
      //                               bottom: 0,
      //                               left: 0,
      //                               right: 0,
      //                               child: Container(
      //                                 padding:
      //                                     EdgeInsets.symmetric(horizontal: 8),
      //                                 decoration: BoxDecoration(
      //                                     borderRadius: BorderRadius.only(
      //                                         bottomLeft: Radius.circular(20),
      //                                         bottomRight: Radius.circular(20)),
      //                                     color: Colors.white.withOpacity(0.6)),
      //                                 height: 30,
      //                                 width: 180,
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.start,
      //                                   children: [
      //                                     SizedBox(
      //                                       width: 160,
      //                                       child: Row(
      //                                         mainAxisAlignment:
      //                                             MainAxisAlignment.start,
      //                                         children: [
      //                                           Icon(Icons.timer_outlined),
      //                                           Text(
      //                                             snapshot.data!.docs[index]
      //                                                 ['cook_time'],
      //                                             maxLines: 1,
      //                                             overflow: TextOverflow.ellipsis,
      //                                             style: TextStyle(
      //                                                 fontWeight: FontWeight.bold,
      //                                                 color: Colors.black),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.all(7),
      //                       child: SizedBox(
      //                         width: 150,
      //                         child: Text(
      //                           snapshot.data!.docs[index]['title'],
      //                           maxLines: 1,
      //                           overflow: TextOverflow.ellipsis,
      //                           style: TextStyle(
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.black),
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 );
      //               },
      //             );
      //           }));
      //     },
      //   ),
      // ));
    );
  }
}

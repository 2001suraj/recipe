// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/all_recipe_page.dart';

class SearchRecipeScreen extends StatefulWidget {
  static const String routeName = 'search recipe screen';
  const SearchRecipeScreen({Key? key}) : super(key: key);

  @override
  State<SearchRecipeScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchRecipeScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? ff;
  String nam = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(40, 90),
            child: Container(
              margin: EdgeInsets.all(20),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search ...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    nam = value;
                  });
                },
              ),
            ),
          ),
        ),
        body: (nam != '' && nam != null)
            ? AllRecipePage(
                stream: FirebaseFirestore.instance
                    .collection('all_recipe')
                    .where('key', arrayContains: nam)
                    .snapshots())
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Stack(
                  children: [
                    Image(
                      image: AssetImage('assets/images/searchr.png'),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.45,
                        left: MediaQuery.of(context).size.width * 0.2,
                        right: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          'Search your favorite recipe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 2),
                        )),
                  ],
                )),
              )

        // SingleChildScrollView(
        //   child: Container(
        //     padding: EdgeInsets.all(20),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           'Suggestion',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 24,
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(top: 10.0, right: 10),
        //           child: SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.7,
        //             width: MediaQuery.of(context).size.width * 0.8,
        //             child: FutureBuilder(
        //                 future: LocalStorage().readdata(),
        //                 builder: (context1, snap) {
        //                   return StreamBuilder(
        //                     stream: (nam != '' && nam != null)
        //                         ? FirebaseFirestore.instance
        //                             .collection('user')
        //                             .where('key', arrayContains: nam)
        //                             .snapshots()
        //                         : FirebaseFirestore.instance
        //                             .collection('user')
        //                             .snapshots(),
        //                     builder:
        //                         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //                       if (snapshot.hasData) {
        //                         return ListView.builder(
        //                             itemCount: snapshot.data!.docs.length,
        //                             itemBuilder: (context, index) {
        //                               var data = snapshot.data!.docs[index];
        //                               return InkWell(
        //                                 onTap: () {
        //                                   Navigator.pushNamed(
        //                                     context,
        //                                     OtherUserProfilePage.routeName,
        //                                     arguments: OtherUserProfilePage(
        //                                       followers: ['followers'],
        //                                       following: data['following'],
        //                                       about: data['about'],
        //                                       email: data['email'],
        //                                       image: data['image'],
        //                                       name: data['name'],
        //                                     ),
        //                                   );
        //                                 },
        //                                 child: Padding(
        //                                   padding: const EdgeInsets.symmetric(
        //                                       vertical: 8.0),
        //                                   child: Row(
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       Row(
        //                                         children: [
        //                                           snapshot.data!.docs[index]
        //                                                       ['image'] ==
        //                                                   'null'
        //                                               ? Padding(
        //                                                   padding:
        //                                                       const EdgeInsets
        //                                                           .all(8.0),
        //                                                   child: CircleAvatar(
        //                                                     radius: 30,
        //                                                     backgroundImage:
        //                                                         AssetImage(
        //                                                             'assets/images/user1.png'),
        //                                                   ),
        //                                                 )
        //                                               : Padding(
        //                                                   padding:
        //                                                       const EdgeInsets
        //                                                           .all(8.0),
        //                                                   child: CircleAvatar(
        //                                                     radius: 30,
        //                                                     backgroundImage:
        //                                                         NetworkImage(
        //                                                       snapshot.data!
        //                                                               .docs[index]
        //                                                           ['image'],
        //                                                     ),
        //                                                   ),
        //                                                 ),
        //                                           Padding(
        //                                             padding:
        //                                                 const EdgeInsets.all(8.0),
        //                                             child: Column(
        //                                               mainAxisAlignment:
        //                                                   MainAxisAlignment.start,
        //                                               crossAxisAlignment:
        //                                                   CrossAxisAlignment
        //                                                       .start,
        //                                               children: [
        //                                                 Text(
        //                                                   snapshot.data!
        //                                                           .docs[index]
        //                                                       ['name'],
        //                                                 ),
        //                                                 Text(
        //                                                   snapshot.data!
        //                                                           .docs[index]
        //                                                       ['email'],
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                           )
        //                                         ],
        //                                       ),
        //                                       Icon(
        //                                         Icons.arrow_forward_ios_outlined,
        //                                         color: Colors.white,
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                               );
        //                             });
        //                       } else {
        //                         return FittedBox(child: Text('no data founnd'));
        //                       }
        //                     },
        //                   );
        //                 }),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

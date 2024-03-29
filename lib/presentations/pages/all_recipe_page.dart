import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';

class AllRecipePage extends StatelessWidget {
  static const String routeName = 'All recipe page';

  AllRecipePage({Key? key, required this.stream}) : super(key: key);
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                IndividualPage.routeName,
                                arguments: IndividualPage(
                                  owner: false,
                                                    cata:snapshot.data!.docs[index]['category'] ,

                                  name: snapshot.data!.docs[index]['owner'],
                                  des: snapshot.data!.docs[index]
                                      ['description'],
                                  time: snapshot.data!.docs[index]['cook_time'],
                                  image: snapshot.data!.docs[index]['photourl'],
                                  ingr: snapshot.data!.docs[index]
                                      ['ingredient'],
                                  step: snapshot.data!.docs[index]['steps'],
                                  title: snapshot.data!.docs[index]['title'],
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['photourl']),
                                        fit: BoxFit.cover),
                                  ),
                                  height: 130,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                 
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        color: Colors.white.withOpacity(0.6)),
                                    height: 30,
                                    width: 160,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.timer_outlined),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['cook_time'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              snapshot.data!.docs[index]['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
           
            }),
      ),
    );
  }
}

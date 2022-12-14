// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/create_recipe_page.dart';
import 'package:recipe_app/presentations/pages/popular_recipes_page.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';
import 'package:recipe_app/presentations/pages/today_recipe_page.dart';
import 'package:recipe_app/presentations/screens/categoty_screen.dart';
import 'package:recipe_app/presentations/widgets/custom_row.dart';
import 'package:recipe_app/presentations/widgets/dot_indicator.dart';

class DiscoverPage extends StatefulWidget {
  static const String routeName = 'discover page';
  DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int pageindex = 0;
  List<String> menu_image = [
    'assets/images/breakfast.png',
    'assets/images/lunch.png',
    'assets/images/main.png',
    'assets/images/dinner.png',
  ];
  List<String> menu_name = [
    'BreakFast ',
    'Vegetarian',
    'Non veg',
    'others',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image slider
              custompageView(context),
              // today recipes and view all
              CustomRow(
                text1: 'Today Recipes',
                text2: 'View All',
                tap: () {
                  Navigator.pushNamed(context, TodayRecipePage.routeName);
                },
              ),
              //. image contianer
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('today_recipe')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
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
                                          name: snapshot.data!.docs[index]
                                              ['owner'],
                                          // name: 'ram',

                                          des: snapshot.data!.docs[index]
                                              ['description'],
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
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ['photourl'],
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                          height: 200,
                                          width: 180,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 9),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                color: Colors.white
                                                    .withOpacity(0.6)),
                                            height: 40,
                                            width: 180,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                          Icons.timer_outlined),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['cook_time'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
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
                                  padding: const EdgeInsets.only(
                                      left: 18.0, top: 10),
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
                    }
                    return Text('no data found');
                  },
                ),
              ),

              //category and view all

              CustomRow(
                text1: 'Category',
                text2: '',
                tap: () {},
              ),
              //contianer
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoty_list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, CategotyScreen.routeName,
                              arguments:
                                  CategotyScreen(title: categoty_list[index]));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black54,
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 90,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        menu_image[index],
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Text(
                                menu_name[index],
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),

              //popular recipe
              CustomRow(
                text1: 'Popular Recipes',
                text2: 'View All',
                tap: () {
                  Navigator.pushNamed(context, PopularRecipesPage.routeName);
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('popular_recipe')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
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
                                          name: snapshot.data!.docs[index]
                                              ['owner'],
                                          // name: 'ram',

                                          des: snapshot.data!.docs[index]
                                              ['description'],
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
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ['photourl'],
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                          height: 200,
                                          width: 180,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 9),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                color: Colors.white
                                                    .withOpacity(0.6)),
                                            height: 40,
                                            width: 180,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                          Icons.timer_outlined),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['cook_time'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
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
                                  padding: const EdgeInsets.only(
                                      left: 18.0, top: 10),
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
                    }
                    return Text('no data found');
                  },
                ),
              ),

//all recipe
              CustomRow(
                text1: 'More Recipes',
                text2: '',
                tap: () {},
              ),

              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('all_recipe')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return Container(
                      child: GridView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
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
                                        name: snapshot.data!.docs[index]
                                            ['owner'],
                                        des: snapshot.data!.docs[index]
                                            ['description'],
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot.data!
                                                  .docs[index]['photourl']),
                                              fit: BoxFit.cover),
                                        ),
                                        height: 130,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                          height: 30,
                                          width: 145,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 145,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.timer_outlined),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          ['cook_time'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Stack custompageView(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.red,
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                pageindex = value;
              });
            },
            children: [
              Image.asset(
                'assets/images/1.jpg',
                height: 200,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/3.jpg',
                height: 200,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/4.jpg',
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Row(
            children: [
              ...List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Dotindicator(
                          isActive: index == pageindex,
                        ),
                      ))
            ],
          ),
        ),
      ],
    );
  }
}

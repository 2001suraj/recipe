// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';
import 'package:recipe_app/presentations/widgets/cus_title.dart';
import 'package:recipe_app/presentations/widgets/dot_indicator.dart';

class DiscoverPage extends StatefulWidget {
  static const String routeName = 'discover page';
  DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(context),
      body: SingleChildScrollView(
        primary: true,
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
              ),

              //. image contianer
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
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
                                  context, IndividualPage.routeName);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/1.jpg',
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        color: Colors.white.withOpacity(0.6)),
                                    height: 40,
                                    width: 180,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.favorite_border),
                                            Text(
                                              '121',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.timer_outlined),
                                            Text(
                                              '13 mins',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
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
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              '5 ingredients Beef stir-fry',
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
              ),
              //category and view all
              CustomRow(
                text1: 'Category',
                text2: 'View All',
              ),
              //contianer
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black54,
                        ),
                        child: Center(child: Icon(Icons.settings)),
                      ),
                    );
                  },
                ),
              ),

              //popular recipe
              CustomRow(
                text1: 'Popular Recipes',
                text2: 'View All',
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 15,
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
                                  context, IndividualPage.routeName);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/1.jpg',
                                        ),
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
                                    width: 180,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.favorite_border),
                                            Text(
                                              '121',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.timer_outlined),
                                            Text(
                                              '13 mins',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
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
                              '5 ingredients Beef stir-fry',
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
              ),

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

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      actions: [
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.people,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15,
            child: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class CustomRow extends StatelessWidget {
  CustomRow({Key? key, required this.text1, required this.text2})
      : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                text2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 25),
              )),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/screens/add_screen.dart';
import 'package:recipe_app/presentations/screens/home_screen.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';
import 'package:recipe_app/presentations/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'home screen';
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    ProfileScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: pages[index],
    
      bottomNavigationBar: ConvexAppBar(
          initialActiveIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            TabItem(
                icon: Icon(
                  Icons.home,
                ),
                title: 'Home'),
            TabItem(
                icon: Icon(
                  Icons.search,
                ),
                title: 'Search'),
            TabItem(
                icon: Icon(
                  Icons.add,
                ),
                title: 'Add'),
            TabItem(icon: Icon(Icons.person), title: 'Profile'),
          ]),
    );
  }
}

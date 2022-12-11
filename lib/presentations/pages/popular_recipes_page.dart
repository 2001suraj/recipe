import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/all_recipe_page.dart';

class PopularRecipesPage extends StatelessWidget {
  static const String routeName = 'popular recipe page';

  const PopularRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AllRecipePage(
      stream:
          FirebaseFirestore.instance.collection('popular_recipe').snapshots(),
    ));
  }
}

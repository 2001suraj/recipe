import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/models/recipe_model.dart';

class RecipeRepo {
  FirebaseFirestore storage = FirebaseFirestore.instance;


//normal
  Future addRecipes({required Recipes recipes, required String email}) async {
    var item = await storage
        .collection('user')
        .doc(email)
        .collection('recipes')
        .doc(recipes.title);
    var items = await item.set(Recipes(
      owner: recipes.owner,
            photourl: recipes.photourl,
            title: recipes.title,
            description: recipes.description,
            cook_time: recipes.cook_time,
            ingredient: recipes.ingredient,
            steps: recipes.steps)
        .toMap());
  }


  //today
  
  // Future addRecipes({
  //   required Recipes recipes,
  // }) async {
  //   var item = storage
  //       .collection('today_recipe')
  //       // .doc(email)
  //       // .collection('recipes')
  //       .doc(recipes.title);
  //   await item.set(
  //     Recipes(
  //             owner: recipes.owner,
  //             photourl: recipes.photourl,
  //             title: recipes.title,
  //             description: recipes.description,
  //             cook_time: recipes.cook_time,
  //             ingredient: recipes.ingredient,
  //             steps: recipes.steps)
  //         .toMap(),
  //   );
  // }

//popular
  // Future addRecipes({
  //   required Recipes recipes,
  // }) async {
  //   var item = storage
  //       .collection('popular_recipe')
  //       // .doc(email)
  //       // .collection('recipes')
  //       .doc(recipes.title);
  //   await item.set(
  //     Recipes(
  //             owner: recipes.owner,
  //             photourl: recipes.photourl,
  //             title: recipes.title,
  //             description: recipes.description,
  //             cook_time: recipes.cook_time,
  //             ingredient: recipes.ingredient,
  //             steps: recipes.steps)
  //         .toMap(),
  //   );
  // }

  Future deleteRecipes({required String title, required String email}) async {
    var item =
        storage.collection('user').doc(email).collection('recipes').doc(title);
    await item.delete();
  }
}

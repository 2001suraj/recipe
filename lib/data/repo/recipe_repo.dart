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
            category: recipes.category,
            key: recipes.key,
            owner: recipes.owner,
            fav: recipes.fav,
            photourl: recipes.photourl,
            owner_email: recipes.owner_email,
            title: recipes.title,
            description: recipes.description,
            cook_time: recipes.cook_time,
            ingredient: recipes.ingredient,
            steps: recipes.steps)
        .toMap());
  }

  //today

  Future todayRecipes({
    required Recipes recipes,
  }) async {
    var item = storage
        .collection('today_recipe')
        // .doc(email)
        // .collection('recipes')
        .doc(recipes.title);
    await item.set(
      Recipes(
              category: recipes.category,
              fav: recipes.fav,
              key: recipes.key,
              owner: recipes.owner,
              photourl: recipes.photourl,
              title: recipes.title,
              description: recipes.description,
              cook_time: recipes.cook_time,
              ingredient: recipes.ingredient,
              owner_email: recipes.owner_email,
              steps: recipes.steps)
          .toMap(),
    );
  }

//popular
  Future popularRecipes({
    required Recipes recipes,
  }) async {
    var item = storage
        .collection('popular_recipe')
        // .doc(email)
        // .collection('recipes')
        .doc(recipes.title);
    await item.set(
      Recipes(
              category: recipes.category,
              key: recipes.key,
              owner: recipes.owner,
              photourl: recipes.photourl,
              title: recipes.title,
              owner_email: recipes.owner_email,
              fav: recipes.fav,
              description: recipes.description,
              cook_time: recipes.cook_time,
              ingredient: recipes.ingredient,
              steps: recipes.steps)
          .toMap(),
    );
  }

  //all
  Future allRecipes({
    required Recipes recipes,
  }) async {
    var item = storage
        .collection('all_recipe')
        // .doc(email)
        // .collection('recipes')
        .doc(recipes.title);

    await item.set(
      Recipes(
              owner_email: recipes.owner_email,
              category: recipes.category,
              fav: recipes.fav,
              key: recipes.key,
              owner: recipes.owner,
              photourl: recipes.photourl,
              title: recipes.title,
              description: recipes.description,
              cook_time: recipes.cook_time,
              ingredient: recipes.ingredient,
              steps: recipes.steps)
          .toMap(),
    );
  }

  Future updateRecipes({
    required Recipes recipes,
  }) async {
    var item = storage.collection('all_recipe').doc(recipes.title);

    await item.update(
      Recipes(
              owner_email: recipes.owner_email,
              category: recipes.category,
              fav: recipes.fav,
              key: recipes.key,
              owner: recipes.owner,
              photourl: recipes.photourl,
              title: recipes.title,
              description: recipes.description,
              cook_time: recipes.cook_time,
              ingredient: recipes.ingredient,
              steps: recipes.steps)
          .toMap(),
    );
  }

  Future updateingredient({
    required String title,
    required List<String> ing,
  }) async {
    var item = storage.collection('all_recipe').doc(title);

    await item.update({
      // 'ingredient': [{index: ing},]
      'ingredient': ing
    });
  }

  Future deleteRecipes({required String title, required String email}) async {
    var item =
        // storage
        //     .collection('all_recipe')
        //     .where('owner_email', isEqualTo: email).snapshots();
        storage.collection('all_recipe').doc(title);
    await item.delete();
  }
}

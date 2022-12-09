import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/models/recipe_model.dart';

class RecipeRepo {
  FirebaseFirestore storage = FirebaseFirestore.instance;

  Future  addRecipes({required Recipes recipes, required String email}) async {
    var item = await storage.collection('user').doc(email).collection('recipes').doc(recipes.title);
    var items = await item.set(Recipes(
            photourl: recipes.photourl,
            title: recipes.title,
            description: recipes.description,
            cook_time: recipes.cook_time,
            ingredient: recipes.ingredient,
            steps: recipes.steps)
        .toMap());
  }
}

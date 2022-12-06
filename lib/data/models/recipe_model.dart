// ignore_for_file: public_member_api_docs, sort_constructors_first
class Recipes {
  String photourl;
  String title;
  String description;
  String cook_time;
  List<String> ingredient;
  List<String> steps;
  Recipes({
    required this.photourl,
    required this.title,
    required this.description,
    required this.cook_time,
    required this.ingredient,
    required this.steps,
  });
}

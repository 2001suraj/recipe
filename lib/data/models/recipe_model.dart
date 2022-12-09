import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photourl': photourl,
      'title': title,
      'description': description,
      'cook_time': cook_time,
      'ingredient': ingredient,
      'steps': steps,
    };
  }

  factory Recipes.fromMap(Map<String, dynamic> map) {
    return Recipes(
      photourl: map['photourl'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      cook_time: map['cook_time'] as String,
      ingredient: List<String>.from((map['ingredient'] as List<String>)),
      steps: List<String>.from((map['steps'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipes.fromJson(String source) => Recipes.fromMap(json.decode(source) as Map<String, dynamic>);
}

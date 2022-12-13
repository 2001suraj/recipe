// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Recipes {
  String owner;
  String owner_email;
  String photourl;
  String title;
  String category;
  bool isfav;
  int fav;
  String description;
  String cook_time;
  List<String> ingredient;
  List<String> steps;
  List<String> key;

  Recipes({
    required this.photourl,
    this.isfav = false,
    required this.owner,
    required this.owner_email,
    required this.category,
    required this.fav,
    required this.key,
    required this.title,
    required this.description,
    required this.cook_time,
    required this.ingredient,
    required this.steps,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'owner': owner,
      'owner_email': owner_email,
      'photourl': photourl,
      'title': title,
      'isfav': isfav,
      'category': category,
      'fav': fav,
      'key': key,
      'description': description,
      'cook_time': cook_time,
      'ingredient': ingredient,
      'steps': steps,
    };
  }

  factory Recipes.fromMap(Map<String, dynamic> map) {
    return Recipes(
      owner: map['owner'] as String,
      owner_email: map['owner_email'] as String,
      photourl: map['photourl'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      isfav: map['isfav'] as bool,
      fav: map['fav'] as int,
      description: map['description'] as String,
      cook_time: map['cook_time'] as String,
      ingredient: List<String>.from((map['ingredient'] as List<String>)),
      key: List<String>.from((map['key'] as List<String>)),
      steps: List<String>.from((map['steps'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipes.fromJson(String source) =>
      Recipes.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/data/models/recipe_model.dart';
import 'package:recipe_app/data/repo/cloud_storage.dart';
import 'package:recipe_app/data/repo/recipe_repo.dart';

import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/widgets/ingredients_container.dart';
import 'package:recipe_app/presentations/widgets/setp_container.dart';
import 'package:recipe_app/presentations/widgets/show__snackbar.dart';

List<String> categoty_list = <String>[
  'BreakFast ',
  'Vegetarian',
  'Non veg',
  'Drinks and Cocktail',
  'others',
];

class CreateRecipePage extends StatefulWidget {
  static const String routeName = 'create recipe page';
  CreateRecipePage({Key? key}) : super(key: key);

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  XFile? image;
  List<Widget> ingredients = [];
  List<Widget> steps = [];
  String dropdownValue = categoty_list.last;

  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController time = TextEditingController();
  List<TextEditingController> ingr = [];
  List<TextEditingController> step = [];
  String cata = 'others';
  @override
  void dispose() {
    for (TextEditingController t in ingr) {
      t.dispose();
    }
    for (TextEditingController t in step) {
      t.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        title: Text(
          'create',
        ),
        actions: [
          FutureBuilder(
              future: LocalStorage().readdata(),
              builder: (context, snapshot1) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return Container(
                        width: 120,
                        height: 80,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docChanges.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data!.docs[index]['email'] ==
                                  snapshot1.data) {
                                return InkWell(
                                  onTap: () {
                                    var rec = Recipes(
                                        owner_email: snapshot1.data.toString(),
                                        category: cata,
                                        key: [
                                          for (int i = 0;
                                              i <= title.text.length;
                                              i++)
                                            title.text
                                                .substring(0, i)
                                                .toLowerCase(),
                                        ],
                                        fav: 0,
                                        owner: snapshot
                                            .data!.docs[index]['name']
                                            .toString(),
                                        photourl: '',
                                        title: title.text.toLowerCase(),
                                        description: des.text,
                                        cook_time: time.text,
                                        ingredient:
                                            ingr.map((e) => e.text).toList(),
                                        steps:
                                            step.map((e) => e.text).toList());

                                    var pp = File(image!.path);
                                    RecipeRepo().allRecipes(
                                      recipes: rec,
                                    );
                                    CloudStorages().allRecipephoto(
                                        photo: pp,
                                        title: title.text,
                                        email: snapshot1.data.toString());
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text(
                                            " Where do you want to publish your recipe ?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              RecipeRepo().todayRecipes(
                                                recipes: rec,
                                              );

                                              CloudStorages().todayrecipephoto(
                                                  photo: pp,
                                                  title: title.text,
                                                  email: snapshot1.data
                                                      .toString());

                                              showsnackBar(
                                                  context: context,
                                                  text:
                                                      'Added new recipe in profile',
                                                  color: Colors.green);
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  MainScreen.routeName);
                                            },
                                            child: Container(
                                              width: 120,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              // padding: const EdgeInsets.all(14),
                                              child: Center(
                                                child: const Text(
                                                  "Today",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              RecipeRepo().popularRecipes(
                                                // email: snapshot1.data.toString(),
                                                recipes: rec,
                                              );
                                              CloudStorages()
                                                  .popularrecipephoto(
                                                      photo: pp,
                                                      title: title.text,
                                                      email: snapshot1.data
                                                          .toString());

                                              showsnackBar(
                                                  context: context,
                                                  text:
                                                      'Added new recipe in popular recipe',
                                                  color: Colors.green);
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  MainScreen.routeName);
                                            },
                                            child: Container(
                                              width: 120,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              // padding: const EdgeInsets.all(14),
                                              child: Center(
                                                child: const Text(
                                                  "Popular",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              RecipeRepo().addRecipes(
                                                email:
                                                    snapshot1.data.toString(),
                                                recipes: rec,
                                              );
                                              CloudStorages().addrecipephoto(
                                                  photo: pp,
                                                  title: title.text,
                                                  email: snapshot1.data
                                                      .toString());

                                              showsnackBar(
                                                  context: context,
                                                  text:
                                                      'Added new recipe in popular recipe',
                                                  color: Colors.green);
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  MainScreen.routeName);
                                            },
                                            child: Container(
                                              width: 120,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              // padding: const EdgeInsets.all(14),
                                              child: Center(
                                                child: const Text(
                                                  "Normal",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('cancel'))
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    margin: EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        right: 15,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: Colors.white,
                                    ),
                                    width: 90,
                                    child: Center(
                                      child: Text(
                                        'Publish',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                      );
                    });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  image == null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: AssetImage('assets/images/user1.png'),
                              )),
                        )
                      : Container(
                          color: Colors.grey,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Expanded(
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 80,
                    child: TextButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final img = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            image = img;
                          });
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Upload a recipe photo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                        )),
                  )
                ],
              ),

              //title
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Title : Mother\'s vegetable soup ',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white54),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              //description
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: des,
                  maxLines: 7,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText:
                        'Description: What\'s the origin of your recipe? What inspired it? What makes it special ',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white54),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.grey, thickness: 7),

              //time
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Cooking time',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      // height: 100,
                      child: TextField(
                        controller: time,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: '1 hr 15 min ',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white54),
                          fillColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 50,
                width: 200,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'category',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
                elevation: 16,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                underline: Container(
                  height: 4,
                  color: Colors.blue,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    cata = value;
                    print(cata);
                  });
                },
                items:
                    categoty_list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
              ),

              Divider(color: Colors.grey, thickness: 7),

              //ingredients
              Text(
                'Ingredients',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              ),
              IngredientsContainer(
                ingre: ingr,
              ),

              Divider(
                color: Colors.grey,
                thickness: 8,
              ),
              // steps
              Text(
                'Steps',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              ),
              StepContainer(step: step),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context,
    {required String title, required String email}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Do you want to delete your receipe ? "),
        actions: [
          MaterialButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            child: Text("yes"),
            onPressed: () {
              RecipeRepo().deleteRecipes(title: title, email: email);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

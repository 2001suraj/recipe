// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/data/models/recipe_model.dart';
import 'package:recipe_app/data/repo/cloud_storage.dart';
import 'package:recipe_app/data/repo/recipe_repo.dart';

import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/widgets/show__snackbar.dart';

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

  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController time = TextEditingController();
  List<TextEditingController> ingr = [];
  List<TextEditingController> step = [];
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
                                        owner: snapshot
                                            .data!.docs[index]['name']
                                            .toString(),
                                        photourl: '',
                                        title: title.text,
                                        description: des.text,
                                        cook_time: time.text,
                                        ingredient:
                                            ingr.map((e) => e.text).toList(),
                                        steps:
                                            step.map((e) => e.text).toList());

                                    var pp = File(image!.path);
                                    RecipeRepo().addRecipes(
                                      email: snapshot1.data.toString(),
                                      recipes: rec,
                                    );
                                    CloudStorages().addrecipephoto(
                                        photo: pp,
                                        title: title.text,
                                        email: snapshot1.data.toString());
                                    showsnackBar(
                                        context: context,
                                        text: 'added new recipe',
                                        color: Colors.green);
                                    Navigator.pushReplacementNamed(
                                        context, MainScreen.routeName);
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
              Divider(color: Colors.grey, thickness: 7),

              //ingredients
              IngredientsContainer(
                ingre: ingr,
              ),

              Divider(
                color: Colors.grey,
                thickness: 8,
              ),
              // steps
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

class StepContainer extends StatefulWidget {
  StepContainer({Key? key, required this.step}) : super(key: key);
  final List step;

  @override
  State<StepContainer> createState() => _StepContainerState();
}

class _StepContainerState extends State<StepContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Steps',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
          Container(
            height: 290,
            child: ListView.builder(
              itemCount: widget.step.length,
              itemBuilder: (context, index) {
                if (index >= 20) {
                  return const SizedBox();
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              height: 90,
                              child: TextField(
                                controller: widget.step[index],
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  hintText:
                                      'Mix the flour and water until they thicken',
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
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
              height: 50,
              minWidth: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  widget.step.add(TextEditingController());
                });
              },
              child: Text(
                '+ Steps',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientsContainer extends StatefulWidget {
  IngredientsContainer({Key? key, required this.ingre}) : super(key: key);
  final List ingre;

  @override
  State<IngredientsContainer> createState() => _IngredientsContainerState();
}

class _IngredientsContainerState extends State<IngredientsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Ingredients',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
          Container(
            height: 290,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.ingre.length,
              itemBuilder: (context, int index) {
                if (index >= 20) {
                  return const SizedBox();
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue,
                            ),
                            child: Center(
                                child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              height: 60,
                              child: TextField(
                                controller: widget.ingre[index],
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  hintText: '250 g flour ',
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
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
              height: 50,
              minWidth: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  widget.ingre.add(TextEditingController());
                });
              },
              child: Text(
                '+ Ingredients',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

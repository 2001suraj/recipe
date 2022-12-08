// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:recipe_app/presentations/screens/main_screen.dart';

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
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.white,
            ),
            width: 90,
            child: Center(
              child: Text(
                'Publish',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          )
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
                height: 50,
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
                      height: 50,
                      child: TextField(
                        maxLines: 1,
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
              Container(
                child: Column(
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    Container(
                      height: 290,
                      child: ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    height: 50,
                                    child: TextField(
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
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
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
                            ingredients.add(Container());
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
              ),
              Divider(
                color: Colors.grey,
                thickness: 8,
              ),
              // steps
              Container(
                child: Column(
                  children: [
                    Text(
                      'Steps',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    Container(
                      height: 290,
                      child: ListView.builder(
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    height: 70,
                                    child: TextField(
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
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
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
                            steps.add(Container());
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
              ),
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

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/widgets/normal_text_field.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = 'edit profile page';
  EditProfilePage({Key? key, required this.ss}) : super(key: key);
  final String ss;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController name;

  TextEditingController about = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController(text: widget.ss);
    super.initState();
  }

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    image == null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage('assets/images/user1.png'),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                 
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final img = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            image = img;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 20,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Username',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: name,
                decoration: InputDecoration(
                  hintText: 'ram',
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'About',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                maxLines: 10,
                controller: about,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.amber,
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {},
                child: Text(
                  'save',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

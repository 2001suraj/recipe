// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/pages/edit_recipe_page.dart';

class IndividualPage extends StatefulWidget {
  static const String routeName = 'individual page';
  IndividualPage(
      {Key? key,
      required this.des,
      required this.name,
      required this.time,
      required this.image,
      required this.ingr,
      required this.step,
      required this.title})
      : super(key: key);
  String title;
  String image;
  String name;
  String des;
  String time;
  List ingr;
  List step;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  TextEditingController descon = TextEditingController();
  TextEditingController timecon = TextEditingController();
  TextEditingController titlecon = TextEditingController();
  List<TextEditingController> ingcon = [];

  @override
  void initState() {
    setState(() {
      descon.text = widget.des;
      timecon.text = widget.time;
      titlecon.text = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Icon(Icons.edit),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Edit your recipe")
                            ],
                          ),
                        ),
                      ],
                      icon: Icon(Icons.menu, color: Colors.white),
                      offset: Offset(0, 40),
                      color: Colors.white,
                      elevation: 2,
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.pushNamed(
                            context,
                            EditRecipePage.routeName,
                            arguments: EditRecipePage(
                              des: descon,
                              image: widget.image,
                              ingr: widget.ingr,
                              step: widget.step,
                              time: timecon,
                              title: titlecon,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // by author and likes
                    AuthorAndFavContainer(
                      name: widget.name,
                      title: widget.title,
                    ),

                    SizedBox(
                      height: 20,
                    ), //title
                    Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.des,
                      textAlign: TextAlign.left,
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),

                    Divider(
                      color: Colors.black,
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Ready In    :    ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        children: [
                          TextSpan(
                            text: widget.time,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    //ingredients
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredients',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.ingr.length,
                              itemBuilder: (context, index) {
                                return IngredientsText(context,
                                    text: widget.ingr[index],
                                    index: '${index + 1} : ');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    //steps
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Steps',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.step.length,
                              itemBuilder: (context, index) {
                                return StepsRow(
                                    index: '${index + 1}',
                                    text: widget.step[index]);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Padding StepsRow({required String index, required String text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              index,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ],
    ),
  );
}

Row IngredientsText(BuildContext context,
    {required String text, required String index}) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      index,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
    ),
    SizedBox(
      width: 5,
    ),
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: 3,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    )
  ]);
}

class AuthorAndFavContainer extends StatefulWidget {
  const AuthorAndFavContainer(
      {Key? key, required this.name, required this.title})
      : super(key: key);

  final String name;

  final String title;

  @override
  State<AuthorAndFavContainer> createState() => _AuthorAndFavContainerState();
}

class _AuthorAndFavContainerState extends State<AuthorAndFavContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: LocalStorage().readdata(),
          builder: (context1, snap) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' By  ' + widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        );
                      });
                } else {
                  return Text('no data found');
                }
              },
            );
          }),
    );
  }
}

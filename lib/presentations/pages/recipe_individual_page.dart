// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/widgets/author_contianer.dart';
import 'package:recipe_app/presentations/widgets/ingredients_text.dart';
import 'package:recipe_app/presentations/widgets/step_text.dart';

class IndividualPage extends StatefulWidget {
  static const String routeName = 'individual page';
  IndividualPage(
      {Key? key,
      required this.des,
      required this.name,
      required this.time,
      required this.image,
      required this.ingr,
      required this.cata,
      required this.step,
      required this.owner,
      required this.title})
      : super(key: key);
  String title;
  String image;
  String name;
  String des;
  String time;
  String cata;
  List ingr;
  List step;
  bool owner;

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
                    AuthorContainer(
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

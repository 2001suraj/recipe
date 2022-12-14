// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IngredientsContainer extends StatefulWidget {
  IngredientsContainer({Key? key, required this.ingre}) : super(key: key);
  final List ingre;

  @override
  State<IngredientsContainer> createState() => _IngredientsContainerState();
}

class _IngredientsContainerState extends State<IngredientsContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
    );
  }
}

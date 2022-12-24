// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StepContainer extends StatefulWidget {
  StepContainer({Key? key, required this.step}) : super(key: key);
  final List step;

  @override
  State<StepContainer> createState() => _StepContainerState();
}

class _StepContainerState extends State<StepContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
            itemCount: widget.step.length,
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
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 85,
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
                        PopupMenuButton<int>(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: const [
                                  Icon(Icons.delete),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Delete this Row")
                                ],
                              ),
                            ),
                          ],
                          offset: Offset(0, 40),
                          color: Colors.white,
                          elevation: 2,
                          onSelected: (value) {
                            if (value == 1) {
                              _showDialog(context, index: index);
                            }
                          },
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
                widget.step.add(TextEditingController());
              });
            },
            child: Text(
              '+ steps',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
        ),
      ],
    );
    //  Column(
    //   children: [
    //     Container(
    //       child: ListView.builder(
    //         itemCount: widget.step.length,
    //         itemBuilder: (context, index) {
    //           if (index >= 20) {
    //             return const SizedBox();
    //           } else {
    //             return Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 40,
    //                       width: 40,
    //                       margin: EdgeInsets.symmetric(
    //                           vertical: 20, horizontal: 10),
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(8),
    //                         color: Colors.white,
    //                       ),
    //                       child: Center(
    //                           child: Text(
    //                         '${index + 1}',
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.black,
    //                             fontSize: 20),
    //                       )),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: SizedBox(
    //                         width: MediaQuery.of(context).size.width / 1.4,
    //                         height: 90,
    //                         child: TextField(
    //                           controller: widget.step[index],
    //                           maxLines: 2,
    //                           style: TextStyle(
    //                               fontSize: 20,
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold),
    //                           decoration: InputDecoration(
    //                             hintText:
    //                                 'Mix the flour and water until they thicken',
    //                             hintStyle: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 20,
    //                                 color: Colors.white54),
    //                             fillColor: Colors.grey,
    //                             filled: true,
    //                             border: OutlineInputBorder(
    //                               borderSide: BorderSide(color: Colors.white),
    //                               borderRadius: BorderRadius.circular(15),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(18.0),
    //       child: MaterialButton(
    //         height: 50,
    //         minWidth: 200,
    //         shape:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //         color: Colors.white,
    //         onPressed: () {
    //           setState(() {
    //             widget.step.add(TextEditingController());
    //           });
    //         },
    //         child: Text(
    //           '+ Steps',
    //           style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black,
    //               fontSize: 20),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  void _showDialog(BuildContext context, {required index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Do you want to delete this row ? "),
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
                setState(() {
                  widget.step.removeAt(index);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class IndividualPage extends StatelessWidget {
  static const String routeName = 'individual page';
  const IndividualPage({Key? key}) : super(key: key);

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
                      image: AssetImage('assets/images/1.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'By Ram',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Row(
                          children: [
                            Text(
                              '8',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ), //title
                    Text(
                      'Chinese chicken and Broccoli / simming & weight watcher friendly',
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
                      'We\'re big fan of the chinese takeaway, so we\'re always looking for slimming friendly alternatives. Enter chinese chicken and broccoli! ',
                      textAlign: TextAlign.left,
                      maxLines: 8,
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
                        text: 'Ready In ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        children: [
                          TextSpan(
                            text: '  30 minutes',
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
                          IngredientsText(text: '6 tbsp balsamic vinegar'),
                          IngredientsText(
                              text: '1/2 cup zesty italian dressing'),
                          IngredientsText(text: '1lb chicken'),
                          IngredientsText(text: '2 heads broccoli'),
                          IngredientsText(text: '1 cup baby carrot'),
                          IngredientsText(text: '0.5 pint cherry tomatoes'),
                          IngredientsText(text: 'salt'),
                          IngredientsText(text: 'fresh parsley'),
                          IngredientsText(text: 'pepper'),
                          IngredientsText(text: 'oil'),
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
                          StepsRow(
                            index: '1',
                            text:
                                'Preheat the overn to 400 degrees F. Spray a large tray with nonstick spray(line  with parchment paper if you tray isn\'t already nostick or the balsmic + italian misture will stick ot it) and set aside',
                          ),
                          StepsRow(
                            index: '2',
                            text:
                                'Whisk together the balsamic vinegar and zesty italian dressing',
                          ),
                          StepsRow(
                            index: '3',
                            text:
                                'cook all the way through in 7-10 minutes an another time it took about 14 minutes',
                          ),
                          StepsRow(
                            index: '4',
                            text: 'Great served over rice or quinoa!',
                          ),
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
            child: IngredientsText(text: text),
          ),
        ],
      ),
    );
  }

  Text IngredientsText({required String text}) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:recipe_app/data/models/onboard_model.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';

class OnBoardpage extends StatefulWidget {
  static const String routeName = ' onboarding page';
  const OnBoardpage({Key? key}) : super(key: key);

  @override
  State<OnBoardpage> createState() => _OnBoardScrrenState();
}

class _OnBoardScrrenState extends State<OnBoardpage> {
  late PageController pageController;
  int pageindex = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      pageindex = value;
                    });
                  },
                  itemCount: OnboardModel.demo.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(OnboardModel.demo[index].image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 420,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: OnboardModel.demo[index].color,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            child: Column(
                              children: [
                                Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    OnboardModel.demo[index].title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 30),
                                  child: Text(
                                    OnboardModel.demo[index].des,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, LoginScreen.routeName);
                                        },
                                        child: Text('Skip'),
                                      ),
                                      Row(
                                        children: [
                                          ...List.generate(
                                              OnboardModel.demo.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Dotindicator(
                                                      isActive:
                                                          index == pageindex,
                                                    ),
                                                  ))
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          if (pageindex < 2) {
                                            pageController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.ease);
                                          } else {
                                            Navigator.pushReplacementNamed(
                                                context, LoginScreen.routeName);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text('next'),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Icon(Icons.arrow_right_alt_outlined)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class Dotindicator extends StatelessWidget {
  Dotindicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

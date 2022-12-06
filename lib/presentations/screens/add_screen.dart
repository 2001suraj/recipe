import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/create_recipe_page.dart';

class AddScreen extends StatelessWidget {
  static const String routeName = 'AddScreen';
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(
              height: 300,
              width: 200,
              color: Colors.red,
              image: const AssetImage(
                'assets/images/add.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Create your food recipe and share it with the community',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Text(
                'Help people to find new ideas and devlop thier cooking skills',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white, fontSize: 20),
              ),
            ),
            const Spacer(),
            MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.85,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, CreateRecipePage.routeName);
              },
              child: const Text(
                'Create Recipe  +  ',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

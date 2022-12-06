import 'package:flutter/material.dart';

class FavScreen extends StatelessWidget {
  static const String routeName = 'FavScreen';
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FavScreen')),
    );
  }
}

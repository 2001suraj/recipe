import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'SearchScreen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SearchScreen')),
    );
  }
}

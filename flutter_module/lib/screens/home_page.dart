import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final String? title;

  const MyHomePage([this.title]);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title ?? 'This is Home Widget\n from module',
        style: optionStyle,
      ),
    );
  }
}

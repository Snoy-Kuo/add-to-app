import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/screens/home_page.dart';

class MyHomePageApp extends StatelessWidget {
  final String? title;
  MyHomePageApp([this.title]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyHomePage(this.title),
      ),
    );
  }
}

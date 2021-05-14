import 'package:flutter/material.dart';
import 'package:flutter_app/screens/web_view_page.dart';

import 'screens/main_page.dart';

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Add to App Flutter App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      routes: {
        '/': (context) => MainPage(),
        '/web': (context) => WebViewPage(),
      },
    );
  }
}

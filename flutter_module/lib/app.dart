import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/screens/home_page.dart';
// import 'l10n/l10n.dart';

class MyHomePageApp extends StatelessWidget {

  MyHomePageApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: l10nDelegates,
      // supportedLocales:AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

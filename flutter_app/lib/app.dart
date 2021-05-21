import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/news_detail_page.dart';
import 'package:flutter_app/screens/web_view_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';

import 'bloc/app_bloc.dart';
import 'screens/main_page.dart';

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Add to App Flutter App';

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        log('[MyApp][build]state=$state');
        return MaterialApp(
          title: _title,
          routes: {
            '/': (context) => MainPage(),
            '/web': (context) => WebViewPage(),
            '/news_detail': (context) => NewsDetailPage(),
          },
          theme: appLightThemeDate(),
          darkTheme: appDarkThemeDate(),
          themeMode: appBloc.themeMode,
        );
      },
    );
  }
}

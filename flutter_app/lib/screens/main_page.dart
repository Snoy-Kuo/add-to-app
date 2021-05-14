import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/host/host_cubit.dart';
import 'package:flutter_module/screens/home_page.dart';

/// This is the stateful widget that the main application instantiates.
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Text(
      'This is Settings Widget',
      style: optionStyle,
    ),
  ];

  late StreamSubscription blocSubs;

  @override
  void initState() {
    super.initState();
    initCubitHandler();
  }

  void initCubitHandler() {
    blocSubs = context.read<HostCubit>().stream.listen((state) {
      if (state is HostOpenUrl) {
        //open WebViewPage
        Navigator.of(context).pushNamed('/web', arguments: state.url);
      }
    });
  }

  @override
  void dispose() {
    blocSubs.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to App Flutter App'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

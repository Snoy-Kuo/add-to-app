import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_app/screens/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';

/// This is the stateful widget that the main application instantiates.
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _selectedSubIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  Widget _getSelectedWidget(int index, int subIndex) {
    Text text = Text(
      'This is Info Widget',
      style: optionStyle,
    );
    if (index == 1) {
      String type = 'All News';
      if (subIndex == 1) {
        type = 'Good News';
      } else if (subIndex == 2) {
        type = 'Bad News';
      }
      text = Text(
        'This is Info Widget, \nType=$type',
        style: optionStyle,
      );
    }

    return IndexedStack(
      index: index,
      children: [
        MyHomePage(),
        Center(child: text),
        SettingsPage(),
      ],
    );
  }

  late StreamSubscription blocSubs;

  @override
  void initState() {
    super.initState();
    initCubitHandler();
  }

  void initCubitHandler() {
    final ChannelCubit cubit = context.read<ChannelCubit>();
    blocSubs = cubit.stream.listen((state) {
      if (state is HostOpenUrl) {
        //open WebViewPage
        Navigator.of(context).pushNamed('/web', arguments: state.url);
      } else if (state is HostOpenNewsType) {
        //open Tab
        log('initCubitHandler state.type=${state.type}');
        _onItemTapped(1, (state.type == NewsType.Type1) ? 1 : 2);
      } else if (state is HostOpenNewsDetail) {
        //open DetailPage
        log('initCubitHandler state.title=${state.item.title}');
        Navigator.of(context).pushNamed('/news_detail', arguments: state.item);
      } else if (state is ClientGetTheme) {
        log('initCubitHandler state is ClientGetTheme');
        cubit.emit(
          ClientChangeTheme(
            mode: BlocProvider.of<AppBloc>(context).themeMode,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    blocSubs.cancel();
    super.dispose();
  }

  void _onItemTapped(int index, [int? subIndex]) {
    setState(() {
      _selectedIndex = index;
      _selectedSubIndex = subIndex ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getSelectedWidget(_selectedIndex, _selectedSubIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color(0xFF97A8B9),
        selectedItemColor: const Color(0xFF2B64A3),
        onTap: _onItemTapped,
      ),
    );
  }
}

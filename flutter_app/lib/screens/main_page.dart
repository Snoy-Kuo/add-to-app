import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_app/l10n/l10n.dart';
import 'package:flutter_app/screens/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';

/// This is the stateful widget that the main application instantiates.
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
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
      String type = L10n.of(context)!.allNews;
      if (subIndex == 1) {
        type = L10n.of(context)!.goodNews;
      } else if (subIndex == 2) {
        type = L10n.of(context)!.badNews;
      } else if (subIndex == 3) {
        type = L10n.of(context)!.flashNews;
      } else if (subIndex == 4) {
        type = L10n.of(context)!.calendarNews;
      }
      text = Text(
        L10n.of(context)!.thisIsInfoWidget(type),
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //update language by change system settings(Android)
      AppBloc appBloc = context.read<AppBloc>();
      String languageMode = appBloc.languageMode;
      if (languageMode == 'System') {
        appBloc.add(AppChangeLanguage(language: languageMode));
        appBloc.chCubit.emit(ClientChangeLanguage(language: languageMode));
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
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
        _onItemTapped(1, state.type.index + 1);
      } else if (state is HostOpenNewsDetail) {
        //open NewsDetailPage
        Navigator.of(context).pushNamed('/news_detail', arguments: state.item);
      } else if (state is ClientGetTheme) {
        cubit.emit(
          ClientChangeTheme(
            mode: BlocProvider.of<AppBloc>(context).themeMode,
          ),
        );
      } else if (state is ClientGetLanguage) {
        cubit.emit(
          ClientChangeLanguage(
            language: BlocProvider.of<AppBloc>(context).languageMode,
          ),
        );
      } else if (state is HostOpenQuotDetail) {
        //open QuotDetailPage
        Navigator.of(context).pushNamed('/quot_detail', arguments: state.item);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: L10n.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: L10n.of(context)!.info,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: L10n.of(context)!.settings,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';
import 'package:group_button/group_button.dart';

class SettingsPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final channelCubit = BlocProvider.of<ChannelCubit>(context);
    final String selectionButton = _getSelection(appBloc.themeMode);

    return SafeArea(
      top: true,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text('ThemeMode:'),
                GroupButton(
                  isRadio: true,
                  selectedButtons: [selectionButton],
                  selectedColor: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  spacing: 10,
                  onSelected: (index, isSelected) {
                    ThemeMode mode = _getThemeMode(index);
                    appBloc.add(AppChangeTheme(mode: mode));
                    channelCubit.emit(ClientChangeTheme(mode: mode));
                  },
                  buttons: ["Light", "Dark", "System"],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text('Realtime Quot:'),
              ),
              Flexible(
                child: Switch(
                  value: appBloc.isRealtime,
                  onChanged: (value) {
                    appBloc.add(AppSwitchRealtimeQuote(isRealtime: value));
                  },
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'This is Settings Widget',
                style: optionStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ThemeMode _getThemeMode(int selection) {
    switch (selection) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _getSelection(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return "Light";
      case ThemeMode.dark:
        return "Dark";
      default:
        return "System";
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';
import 'package:group_button/group_button.dart';

import '../l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final channelCubit = BlocProvider.of<ChannelCubit>(context);
    final String selectionButton =
        _getSelection(appBloc.themeMode, L10n.of(context)!);

    return SafeArea(
      top: true,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: [
          Text(L10n.of(context)!.themeMode),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: GroupButton(
              buttonWidth: MediaQuery.of(context).size.width / 3 - 5,
              isRadio: true,
              selectedButtons: [selectionButton],
              selectedColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              spacing: 2,
              onSelected: (index, isSelected) {
                ThemeMode mode = _getThemeMode(index);
                appBloc.add(AppChangeTheme(mode: mode));
                channelCubit.emit(ClientChangeTheme(mode: mode));
              },
              buttons: [
                L10n.of(context)!.light,
                L10n.of(context)!.dark,
                L10n.of(context)!.system
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(L10n.of(context)!.language),
              ),
              Flexible(
                child: LanguageDropdownView(
                  locale: appBloc.locale,
                  onChanged: (value) {
                    appBloc.add(AppChangeLanguage(language: value));
                    channelCubit.emit(ClientChangeLanguage(language: value));
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(L10n.of(context)!.realtimeQuot),
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
                L10n.of(context)!.thisIsSettingsWidget,
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

  String _getSelection(ThemeMode mode, L10n l10n) {
    switch (mode) {
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
      default:
        return l10n.system;
    }
  }
}

class LanguageDropdownView extends StatelessWidget {
  final Locale locale;
  final ValueChanged<String>? onChanged;

  LanguageDropdownView({required this.locale, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    String dropdownValue = appBloc.languageMode;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Theme.of(context).accentColor,
      ),
      onChanged: (String? newValue) {
        dropdownValue = newValue!;
        if (null != onChanged) {
          onChanged!(dropdownValue);
        }
      },
      items: <String>['English', '简体中文', '繁體中文', 'System']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            '${(value == 'System') ? L10n.of(context)!.system : value}  ',
            style: (value == dropdownValue)
                ? Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor)
                : Theme.of(context).textTheme.bodyText2,
          ),
        );
      }).toList(),
    );
  }
}

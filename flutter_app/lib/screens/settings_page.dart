import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class SettingsPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
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
                  selectedColor: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  spacing: 10,
                  onSelected: (index, isSelected) =>
                      print('$index button is selected'),
                  buttons: ["Light", "Dark", "System"],
                ),
              ],
            ),
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
}

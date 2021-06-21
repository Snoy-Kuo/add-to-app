import 'package:flutter/material.dart';
import 'package:flutter_module/l10n/l10n.dart';

import 'menu_cell.dart';

class MenuView extends StatelessWidget {
  final Function(int index) onItemClick;

  MenuView({required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MenuCell(
                  icon: Icons.flash_on,
                  label: l10n(context).flash,
                  onItemClick: () => onItemClick(0),
                ),
              ),
              Expanded(
                child: MenuCell(
                  icon: Icons.calendar_today_outlined,
                  label: l10n(context).calendar,
                  onItemClick: () => onItemClick(1),
                ),
              ),
              Expanded(
                child: MenuCell(
                  icon: Icons.live_tv,
                  label: l10n(context).live,
                  onItemClick: () => onItemClick(2),
                ),
              ),
              Expanded(
                child: MenuCell(
                  icon: Icons.contact_support_outlined,
                  label: l10n(context).support,
                  onItemClick: () => onItemClick(3),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => onItemClick(4),
            child: Image(
              image: AssetImage(
                './assets/images/banner.png'.lightDarkPath(context),
                package: 'flutter_module',
              ),
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.width * 111 / 375,
              width: MediaQuery.of(context).size.width * 345 / 375,
            ),
          ),
        ],
      ),
    );
  }
}

extension PathUtil on String {
  String lightDarkPath(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return this;
    } else {
      List<String> list = this.split('/');
      String darkPath = "";
      for (var i = 0; i < list.length; i++) {
        if (i == list.length - 1) {
          darkPath = darkPath + 'dark/${list[i]}';
        } else {
          darkPath = darkPath + '${list[i]}/';
        }
      }

      return darkPath;
    }
  }
}

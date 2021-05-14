import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/widgets/banner/banner.dart';

class MyHomePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final String? title;

  const MyHomePage([this.title]);

  @override
  Widget build(BuildContext context) {
    //make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        BannerView(
          repository: MockBannerRepo(),
          onItemClick: onBannerItemClick,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              title ?? 'This is Home Widget\n from module',
              style: optionStyle,
            ),
          ),
        ),
      ],
    );
  }

  void onBannerItemClick(BannerItem? item) {
    log('onBannerItemClick item=${item?.id ?? null}');
  }
}

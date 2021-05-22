import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/method_channel/method_channel_handler.dart';
import 'package:flutter_module/theme/app_theme.dart';
import 'package:flutter_module/widgets/banner/banner.dart';
import 'package:flutter_module/widgets/news_ticker/news_ticker.dart';

class MyHomePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final String? title;
  final MethodChannelHandler _channelHandler = MethodChannelHandler();

  MyHomePage([this.title]);

  @override
  Widget build(BuildContext context) {
    //make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return BlocProvider<HomePageBloc>(
      create: (_) {
        ChannelCubit? channelCubit;
        try {
          channelCubit = BlocProvider.of<ChannelCubit>(context);
        } catch (e) {
          channelCubit = null;
        }
        final bloc = HomePageBloc(channelCubit);
        _channelHandler.bloc = bloc;

        return bloc;
      },
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (_channelHandler.bloc == null) {
            _channelHandler.bloc = BlocProvider.of<HomePageBloc>(context);
          }
          //build by state
          final ThemeData themeData = _getThemeDataByMode(context);
          return Theme(
            data: themeData,
            child: Container(
              color: themeData.scaffoldBackgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  BannerView(
                    repository: MockBannerRepo(),
                    onItemClick: (item) => onBannerItemClick(item),
                  ),
                  NewsTickerView(
                    repository: MockNewsRepo(),
                    onItemClick: (item) => onNewsTickerItemClick(item),
                    onMoreClick: (item) => onNewsTickerMoreClick(item),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        title ?? 'This is Home Widget\n from module',
                        style: themeData.textTheme.headline5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onBannerItemClick(BannerItem? item) {
    String url = item?.targetUrl ?? '';
    log('onBannerItemClick, url=$url');
    _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
    _channelHandler.bloc?.channelCubit?.emit(HostOpenUrl(url: url));
  }

  void onNewsTickerItemClick(NewsItem? item) {
    log('onNewsTickerItemClick, item=$item');
    if (item == null) return;
    _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_NEWS_DETAIL,
        <String, dynamic>{'id': item.id, 'title': item.title});
    _channelHandler.bloc?.channelCubit?.emit(HostOpenNewsDetail(item: item));
  }

  void onNewsTickerMoreClick(NewsItem? item) {
    log('onNewsTickerMoreClick, item=$item');
    if (item == null) return;
    NewsType type = item.type;
    _channelHandler.invokeMethod(
        MethodChannelHandler.HOST_OPEN_NEWS_TYPE, type.index);
    _channelHandler.bloc?.channelCubit?.emit(HostOpenNewsType(type: type));
  }

  ThemeData _getThemeDataByMode(BuildContext context) {
    final ThemeMode mode = BlocProvider.of<HomePageBloc>(context).themeMode;
    final ThemeData themeData;
    if (mode == ThemeMode.dark) {
      themeData = appDarkThemeDate();
    } else if (mode == ThemeMode.light) {
      themeData = appLightThemeDate();
    } else {
      final Brightness platformBrightness =
          MediaQuery.platformBrightnessOf(context);
      if (platformBrightness == Brightness.dark) {
        themeData = appDarkThemeDate();
      } else {
        themeData = appLightThemeDate();
      }
    }
    return themeData;
  }
}

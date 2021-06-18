import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/method_channel/method_channel_handler.dart';
import 'package:flutter_module/theme/app_theme.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:flutter_module/widgets/widgets.dart';

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
                  _stockTickerView(),
                  Divider(
                    thickness: 4,
                  ),
                  MenuView(
                    onItemClick: (index) => onMenuItemClick(index),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
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

  Widget _stockTickerView() {
    Widget w = BlocProvider<StockTickerBloc>(
      create: (context) {
        final StockTickerBloc bloc =
            StockTickerBloc(repository: MockQuotRepo());
        context.read<HomePageBloc>().stockTickerBloc = bloc;
        return bloc..add(RefreshStockTicker());
      },
      child: StockTickerView(
        onItemClick: (item) => onStockTickerItemClick(item),
      ),
    );

    return w;
  }

  void onBannerItemClick(BannerItem? item) {
    String url = item?.targetUrl ?? '';
    _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
    _channelHandler.bloc?.channelCubit?.emit(HostOpenUrl(url: url));
  }

  void onNewsTickerItemClick(NewsItem? item) {
    if (item == null) return;
    _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_NEWS_DETAIL,
        <String, dynamic>{'id': item.id, 'title': item.title});
    _channelHandler.bloc?.channelCubit?.emit(HostOpenNewsDetail(item: item));
  }

  void onNewsTickerMoreClick(NewsItem? item) {
    if (item == null) return;
    NewsType type = item.type;
    _channelHandler.invokeMethod(
        MethodChannelHandler.HOST_OPEN_NEWS_TYPE, type.index);
    _channelHandler.bloc?.channelCubit?.emit(HostOpenNewsType(type: type));
  }

  void onStockTickerItemClick(QuotItem? item) {
    dev.log('onStockTickerItemClick, item=$item');
    if (item == null) return;
    _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_QUOT_DETAIL,
        <String, dynamic>{'id': item.id, 'name': item.name});
    _channelHandler.bloc?.channelCubit?.emit(HostOpenQuotDetail(item: item));
  }

  void onMenuItemClick(int index) {
    dev.log('onMenuItemClick, index=$index');
    switch (index) {
      case 0:
        {
          //Flash
          NewsType type = NewsType.Type3;
          _channelHandler.invokeMethod(
              MethodChannelHandler.HOST_OPEN_NEWS_TYPE, type.index);
          _channelHandler.bloc?.channelCubit
              ?.emit(HostOpenNewsType(type: type));
        }
        break;
      case 1:
        {
          //Calendar
          NewsType type = NewsType.Type4;
          _channelHandler.invokeMethod(
              MethodChannelHandler.HOST_OPEN_NEWS_TYPE, type.index);
          _channelHandler.bloc?.channelCubit
              ?.emit(HostOpenNewsType(type: type));
        }
        break;
      case 2:
        {
          //Live
          String url = 'https://www.linetv.tw/';
          _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
          _channelHandler.bloc?.channelCubit?.emit(HostOpenUrl(url: url));
        }
        break;
      case 3:
        {
          //Contact
          String url = 'https://www.answers.com/';
          _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
          _channelHandler.bloc?.channelCubit?.emit(HostOpenUrl(url: url));
        }
        break;
      case 4:
        {
          //Course
          String url = 'https://www.udemy.com/';
          _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
          _channelHandler.bloc?.channelCubit?.emit(HostOpenUrl(url: url));
        }
        break;
    }
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

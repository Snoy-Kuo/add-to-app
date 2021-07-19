import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/l10n/l10n.dart';
import 'package:flutter_module/method_channel/method_channel_handler.dart';
import 'package:flutter_module/theme/app_theme.dart';
import 'package:flutter_module/utils/log_util.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:flutter_module/widgets/type_article_list/model/mock_type_article_repo.dart';
import 'package:flutter_module/widgets/type_article_list/view/type_article_list_view.dart';
import 'package:flutter_module/widgets/widgets.dart';

class MyHomePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final MethodChannelHandler _channelHandler = MethodChannelHandler();

  MyHomePage();

  @override
  Widget build(BuildContext context) {
    //make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // LogUtil.d('Localizations.localeOf(context)=${Localizations.localeOf(context)}, Intl.getCurrentLocale()=${Intl.getCurrentLocale()}, Platform.localeName=${Platform.localeName}');

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
        _channelHandler.bloc!.channelCubit?.emit(ClientGetTheme());

        _channelHandler.invokeMethod(MethodChannelHandler.CLIENT_GET_LANGUAGE);
        _channelHandler.bloc!.channelCubit?.emit(ClientGetLanguage());

        return bloc;
      },
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (_channelHandler.bloc == null) {
            _channelHandler.bloc = BlocProvider.of<HomePageBloc>(context);
          }
          //build by state
          final ThemeData themeData = _getThemeDataByMode(context);
          final Locale locale = BlocProvider.of<HomePageBloc>(context).locale;
          return Theme(
            data: themeData,
            child: Localizations.override(
              context: context,
              locale: locale,
              delegates: l10nDelegates,
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
                    TypeArticleListView(
                        repository: MockTypeArticleRepo(),
                        onItemClick: (item) => onTypeArticleListItemClick(item),
                    ),
                    HomePageLabel(),
                  ],
                ),
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
    LogUtil.d('item=$item');
    if (item == null) return;
    _channelHandler.invokeMethod(MethodChannelHandler.HOST_OPEN_QUOT_DETAIL,
        <String, dynamic>{'id': item.id, 'name': item.name});
    _channelHandler.bloc?.channelCubit?.emit(HostOpenQuotDetail(item: item));
  }

  void onMenuItemClick(int index) {
    LogUtil.d('index=$index');
    switch (index) {
      case 0:
        {
          //Flash
          NewsType type = NewsType.TypeFlash;
          _channelHandler.invokeMethod(
              MethodChannelHandler.HOST_OPEN_NEWS_TYPE, type.index);
          _channelHandler.bloc?.channelCubit
              ?.emit(HostOpenNewsType(type: type));
        }
        break;
      case 1:
        {
          //Calendar
          NewsType type = NewsType.TypeCalendar;
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

  void onTypeArticleListItemClick(NewsItem? item){
    if (item == null) return;
    LogUtil.d('item=$item');
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

class HomePageLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Center(
        child: Text(
          l10n(context).thisIsFromModule('Home'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}

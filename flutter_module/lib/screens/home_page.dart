import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/method_channel/method_channel_handler.dart';
import 'package:flutter_module/widgets/banner/banner.dart';
import 'package:flutter_module/widgets/news_ticker/news_ticker.dart';

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

    MethodChannelHandler? _channelHandler;

    return BlocProvider<HomePageBloc>(
      create: (_) {
        HostCubit? hostCubit;
        try {
          hostCubit = BlocProvider.of<HostCubit>(context);
        } catch (e) {
          hostCubit = null;
        }
        final bloc = HomePageBloc(hostCubit);
        _channelHandler = MethodChannelHandler(bloc);
        return bloc;
      },
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          //TODO: build by state
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              BannerView(
                repository: MockBannerRepo(),
                onItemClick: (item) => onBannerItemClick(item, _channelHandler),
              ),
              NewsTickerView(
                repository: MockNewsRepo(),
                onItemClick: (item) =>
                    onNewsTickerItemClick(item, _channelHandler),
                onMoreClick: (item) =>
                    onNewsTickerMoreClick(item, _channelHandler),
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
        },
      ),
    );
  }

  void onBannerItemClick(
      BannerItem? item, MethodChannelHandler? channelHandler) {
    String url = item?.targetUrl ?? '';
    log('onBannerItemClick item=${item?.id ?? null}, url=$url');
    channelHandler?.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
    channelHandler?.bloc.hostCubit?.emit(HostOpenUrl(url: url));
  }

  void onNewsTickerItemClick(
      NewsItem? item, MethodChannelHandler? channelHandler) {
    if (item == null) return;
    String title = item.title;
    log('onNewsTickerItemClick item=${item.id}, title=$title');
    channelHandler?.invokeMethod(
        MethodChannelHandler.HOST_OPEN_NEWS_DETAIL, item);
    channelHandler?.bloc.hostCubit?.emit(HostOpenNewsDetail(item: item));
  }

  void onNewsTickerMoreClick(
      NewsItem? item, MethodChannelHandler? channelHandler) {
    if (item == null) return;
    NewsType type = item.type;
    log('onNewsTickerMoreClick item=${item.id}, type=$type');
    channelHandler?.invokeMethod(
        MethodChannelHandler.HOST_OPEN_NEWS_TYPE, item);
    channelHandler?.bloc.hostCubit?.emit(HostOpenNewsType(type: type));
  }
}

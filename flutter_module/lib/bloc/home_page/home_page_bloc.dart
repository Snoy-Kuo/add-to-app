import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/channel/channel_cubit.dart';
import 'package:flutter_module/flutter_module.dart';
import 'package:flutter_module/utils/log_util.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:flutter_module/widgets/type_article_list/bloc/type_article_list_bloc.dart';
import 'package:meta/meta.dart';

import '../../l10n/l10n.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  ChannelCubit? channelCubit;
  ThemeMode themeMode = ThemeMode.system;
  Locale locale =
      Locale('en').supportLocale(); //'en'); //('zh','TW');//('zh');//'en');
  bool isRookie = true;
  StockTickerBloc? stockTickerBloc;
  TypeArticleListBloc? typeArticleRepoBloc;

  // ignore: cancel_subscriptions
  StreamSubscription? channelSub;

  HomePageBloc(this.channelCubit) : super(HomePageInitial()) {
    if (channelCubit == null) {
      return;
    }

    channelSub = channelCubit!.stream.listen((state) {
      //listen to host state, and add hp event
      if (state is ClientChangeTheme) {
        add(ChangeTheme(mode: state.mode));
      } else if (state is ClientChangeLanguage) {
        LogUtil.d(
            '[HomePageBloc][constructor]channelCubit!.stream.listen state=$state');
        add(ChangeLocale(locale: languageToLocale(state.language)));
      } else if (state is ClientUpdateQuot) {
        stockTickerBloc?.add(UpdateStockTicker(item: state.item));
      } else if (state is ClientChangeUserLv) {
        // add(ChangeUserLv(isRookie: state.isRookie));
        typeArticleRepoBloc?.add(RefreshTypeArticleList(
            type: state.isRookie ? NewsType.TypeRookie : NewsType.TypeVeteran));
      }
    });
  }

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is ChangeTheme) {
      this.themeMode = event.mode;
      yield HomePageUpdated(
          themeMode: themeMode, locale: locale, isRookie: isRookie);
    } else if (event is ChangeLocale) {
      this.locale = event.locale.supportLocale();
      yield HomePageUpdated(
          themeMode: themeMode, locale: locale, isRookie: isRookie);
    } else if (event is UpdateQuot) {
      //from method channel
      stockTickerBloc?.add(UpdateStockTicker(item: event.item));
    } else if (event is ChangeUserLv) {
      //from method channel
      this.isRookie = event.isRookie;
      typeArticleRepoBloc?.add(RefreshTypeArticleList(
          type: event.isRookie ? NewsType.TypeRookie : NewsType.TypeVeteran));
    }
  }

  @override
  Future<void> close() {
    if (channelSub != null) {
      channelSub!.cancel();
    }

    return super.close();
  }
}

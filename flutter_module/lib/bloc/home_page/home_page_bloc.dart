import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/channel/channel_cubit.dart';
import 'package:flutter_module/flutter_module.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:meta/meta.dart';

import '../../l10n/l10n.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  ChannelCubit? channelCubit;
  ThemeMode themeMode = ThemeMode.system;
  Locale locale =
      Locale('en').supportLocale(); //'en'); //('zh','TW');//('zh');//'en');
  StockTickerBloc? stockTickerBloc;

  // ignore: cancel_subscriptions
  StreamSubscription? channelSub;

  HomePageBloc(this.channelCubit) : super(HomePageInitial()) {
    if (channelCubit == null) {
      return;
    }
    channelCubit!.emit(ClientGetTheme());
    channelCubit!.emit(ClientGetLanguage());
    channelSub = channelCubit!.stream.listen((state) {
      //listen to host state, and add hp event
      if (state is ClientChangeTheme) {
        add(ChangeTheme(mode: state.mode));
      } else if (state is ClientChangeLanguage) {
        add(ChangeLocale(locale: languageToLocale(state.language)));
      } else if (state is ClientUpdateQuot) {
        stockTickerBloc?.add(UpdateStockTicker(item: state.item));
      }
    });
  }

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is ChangeTheme) {
      this.themeMode = event.mode;
      yield HomePageUpdated(themeMode: themeMode, locale: locale);
    } else if (event is ChangeLocale) {
      this.locale = event.locale.supportLocale();
      yield HomePageUpdated(themeMode: themeMode, locale: locale);
    } else if (event is UpdateQuot) {
      //from method channel
      stockTickerBloc?.add(UpdateStockTicker(item: event.item));
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

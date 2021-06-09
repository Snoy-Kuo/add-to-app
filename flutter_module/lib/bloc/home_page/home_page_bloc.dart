import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/channel/channel_cubit.dart';
import 'package:flutter_module/flutter_module.dart';
import 'package:flutter_module/widgets/stock_ticker/bloc/stock_ticker_bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  ChannelCubit? channelCubit;
  late ThemeMode themeMode = ThemeMode.system;
  StockTickerBloc? stockTickerBloc;

  // ignore: cancel_subscriptions
  StreamSubscription? channelSub;

  HomePageBloc(this.channelCubit) : super(HomePageInitial()) {
    if (channelCubit == null) {
      return;
    }
    channelCubit!.emit(ClientGetTheme());
    channelSub = channelCubit!.stream.listen((state) {
      //listen to host state, and add hp event
      if (state is ClientChangeTheme) {
        add(ChangeTheme(mode: state.mode));
      } else if (state is ClientUpdateQuot) {
        stockTickerBloc?.add(UpdateStockTicker(item: state.item));
      }
    });
  }

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is ChangeTheme) {
      this.themeMode = event.mode;
      yield HomePageUpdated();
    } else if (event is UpdateQuot) {
      //from method channel
      log('[HomePageBloc][UpdateQuot]item=${event.item}');
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

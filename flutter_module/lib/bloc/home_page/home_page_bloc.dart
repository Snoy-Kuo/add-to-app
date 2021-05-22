import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/channel/channel_cubit.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  ChannelCubit? channelCubit;
  late ThemeMode themeMode = ThemeMode.system;

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

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/host/host_cubit.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HostCubit? hostCubit;
  ThemeMode themeMode = ThemeMode.system;

  // ignore: cancel_subscriptions
  StreamSubscription? hostSub;

  HomePageBloc(this.hostCubit) : super(HomePageInitial()) {
    if (hostCubit == null) {
      log('hostCubit == null');
      return;
    }
    log('hostCubit != null');
    hostCubit!.emit(ClientGetTheme());
    hostSub = hostCubit!.stream.listen((state) {
      log('hostCubit!.stream.listen state=$state');
      //listen to host state, and add hp event
      if (state is ClientChangeTheme) {
        log('state is ClientChangeTheme');
        add(ChangeTheme(mode: state.mode));
      }
    });
  }

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is ChangeTheme) {
      log('[mapEventToState]event is ChangeTheme');
      this.themeMode = event.mode;
      yield HomePageUpdated();
    }
  }

  @override
  Future<void> close() {
    if (hostSub != null) {
      hostSub!.cancel();
    }

    return super.close();
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/realtime_quot_repo.dart';
import 'package:flutter_module/flutter_module.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final RealtimeQuotRepo rtRepo;
  final ChannelCubit chCubit;

  ThemeMode themeMode = ThemeMode.system;
  String languageMode = 'System';
  Locale locale = languageToLocale('System').supportLocale();
  bool isRealtime = false;
  late StreamSubscription realtimeSubs;

  AppBloc({required this.rtRepo, required this.chCubit}) : super(AppInitial()) {
    realtimeSubs = rtRepo.listenRealtimeQuote().listen((item) {
      if (item == null) return;
      //send to client
      chCubit.emit(ClientUpdateQuot(item: item));
    });
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppChangeTheme) {
      themeMode = event.mode;
      yield AppThemeChanged(mode: themeMode);
    } else if (event is AppChangeLanguage) {
      languageMode = event.language;
      locale = languageToLocale(event.language).supportLocale();
      yield AppLanguageChanged(locale: locale);
    } else if (event is AppSwitchRealtimeQuote) {
      isRealtime = event.isRealtime;
      rtRepo.toggleRealtimeQuote(isRealtime);
      realtimeSubs.cancel();
      realtimeSubs = rtRepo.listenRealtimeQuote().listen((item) {
        if (item == null) return;
        //send to client
        chCubit.emit(ClientUpdateQuot(item: item));
      });
      yield AppRealtimeQuotSwitched(isRealtime: isRealtime);
    }
  }

  @override
  Future<void> close() {
    realtimeSubs.cancel();
    return super.close();
  }
}

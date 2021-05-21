import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  ThemeMode themeMode = ThemeMode.system;

  AppBloc() : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    log('[AppBloc][mapEventToState]event=$event');
    if (event is AppChangeTheme){
      themeMode = event.mode;
      yield AppThemeChanged(mode: themeMode);
    }
  }
}

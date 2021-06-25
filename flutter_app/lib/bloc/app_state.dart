part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {}

class AppInitial extends AppState {
  @override
  List<Object?> get props => [];
}

class AppThemeChanged extends AppState {
  final ThemeMode mode;

  AppThemeChanged({required this.mode});

  @override
  List<Object?> get props => [mode];
}

class AppLanguageChanged extends AppState {
  final Locale locale;

  AppLanguageChanged({required this.locale});

  @override
  List<Object?> get props => [locale];
}

class AppRealtimeQuotSwitched extends AppState {
  final bool isRealtime;

  AppRealtimeQuotSwitched({required this.isRealtime});

  @override
  List<Object?> get props => [isRealtime];
}

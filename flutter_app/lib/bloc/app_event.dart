part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {}

class AppChangeTheme extends AppEvent {
  final ThemeMode mode;

  AppChangeTheme({required this.mode});

  @override
  List<Object?> get props => [mode];
}

class AppSwitchRealtimeQuote extends AppEvent {
  final bool isRealtime;

  AppSwitchRealtimeQuote({required this.isRealtime});

  @override
  List<Object?> get props => [isRealtime];
}

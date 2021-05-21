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

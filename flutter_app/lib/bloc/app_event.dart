part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {}

class AppChangeTheme extends AppEvent {
  final ThemeMode mode;

  AppChangeTheme({required this.mode});

  @override
  List<Object?> get props => [];
}

part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable{}

class ChangeTheme extends HomePageEvent{
  final ThemeMode mode;

  ChangeTheme({required this.mode});

  @override
  List<Object?> get props => [mode];
}

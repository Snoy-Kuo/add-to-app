part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState extends Equatable {}

class HomePageInitial extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageUpdated extends HomePageState {
  final ThemeMode themeMode;
  final Locale locale;

  HomePageUpdated({required this.themeMode, required this.locale});

  @override
  List<Object?> get props => [themeMode, locale];
}

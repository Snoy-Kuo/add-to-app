part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable {}

class ChangeTheme extends HomePageEvent {
  final ThemeMode mode;

  ChangeTheme({required this.mode});

  @override
  List<Object?> get props => [mode];
}

class ChangeLocale extends HomePageEvent {
  final Locale locale;

  ChangeLocale({required this.locale});

  @override
  List<Object?> get props => [locale];
}

class UpdateQuot extends HomePageEvent {
  final QuotItem item;

  UpdateQuot({required this.item});

  @override
  List<Object?> get props => [item];
}

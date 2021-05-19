part of 'news_ticker_bloc.dart';

@immutable
abstract class NewsTickerState extends Equatable {}

class NewsTickerLoading extends NewsTickerState {
  @override
  List<Object?> get props => [];
}

class NewsTickerLoaded extends NewsTickerState {
  final List<NewsItem> list;

  NewsTickerLoaded([this.list = const []]);

  @override
  List<Object?> get props => [list];
}

class NewsTickerError extends NewsTickerState {
  final String msg;
  final String code;

  NewsTickerError({required this.code, required this.msg});

  @override
  List<Object?> get props => [msg, code];
}

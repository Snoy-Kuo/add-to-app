part of 'news_ticker_bloc.dart';

@immutable
abstract class NewsTickerEvent extends Equatable {}

class RefreshNewsTicker extends NewsTickerEvent {
  @override
  List<Object?> get props => [];
}

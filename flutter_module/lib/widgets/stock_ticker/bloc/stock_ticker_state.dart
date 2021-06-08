part of 'stock_ticker_bloc.dart';

@immutable
abstract class StockTickerState extends Equatable {}

class StockTickerLoading extends StockTickerState {
  @override
  List<Object?> get props => [];
}

class StockTickerLoaded extends StockTickerState {
  final List<QuotItem> list;
  final int _time = DateTime.now().millisecondsSinceEpoch;

  StockTickerLoaded([this.list = const []]);

  @override
  List<Object?> get props => [list, _time];
}

class StockTickerError extends StockTickerState {
  final String msg;
  final String code;

  StockTickerError({required this.code, required this.msg});

  @override
  List<Object?> get props => [msg, code];
}

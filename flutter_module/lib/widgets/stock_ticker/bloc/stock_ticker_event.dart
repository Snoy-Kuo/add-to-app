part of 'stock_ticker_bloc.dart';

@immutable
abstract class StockTickerEvent extends Equatable {}

class RefreshStockTicker extends StockTickerEvent {
  @override
  List<Object?> get props => [];
}

class UpdateStockTicker extends StockTickerEvent {
  final QuotItem item;

  UpdateStockTicker({required this.item});

  @override
  List<Object?> get props => [item];
}

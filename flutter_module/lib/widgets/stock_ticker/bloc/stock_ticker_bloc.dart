import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_module/utils/log_util.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_repo.dart';
import 'package:meta/meta.dart';

part 'stock_ticker_event.dart';
part 'stock_ticker_state.dart';

class StockTickerBloc extends Bloc<StockTickerEvent, StockTickerState> {
  final QuotRepo repository;
  List<QuotItem>? list = [];

  StockTickerBloc({required this.repository}) : super(StockTickerLoading());

  @override
  Stream<StockTickerState> mapEventToState(
    StockTickerEvent event,
  ) async* {
    if (event is RefreshStockTicker) {
      yield* _mapRefreshStockTickerToState();
    } else if (event is UpdateStockTicker) {
      yield* _mapUpdateStockTickerToState(event.item);
    }
  }

  Stream<StockTickerState> _mapRefreshStockTickerToState() async* {
    try {
      yield StockTickerLoading();
      list = await repository.fetchQuotList();
      yield StockTickerLoaded(list ?? []);
    } catch (e) {
      LogUtil.e('e=$e');
      yield StockTickerError(code: '-1', msg: 'Something wrong');
    }
  }

  Stream<StockTickerState> _mapUpdateStockTickerToState(QuotItem item) async* {
    try {
      var target = list?.firstWhereOrNull((it) => (it.id == item.id));
      if (target == null) {
        return;
      } else {
        target.price = item.price;
      }
      yield StockTickerLoaded(list ?? []);
    } catch (e) {
      LogUtil.e('e=$e');
    }
  }
}

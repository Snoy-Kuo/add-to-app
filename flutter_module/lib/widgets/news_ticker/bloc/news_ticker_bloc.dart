import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_module/models/news/news_item.dart';
import 'package:flutter_module/utils/log_util.dart';
import 'package:flutter_module/widgets/news_ticker/model/model.dart';
import 'package:meta/meta.dart';

part 'news_ticker_event.dart';
part 'news_ticker_state.dart';

class NewsTickerBloc extends Bloc<NewsTickerEvent, NewsTickerState> {
  final NewsRepo repository;
  List<NewsItem>? list = [];

  NewsTickerBloc({required this.repository}) : super(NewsTickerLoading());

  @override
  Stream<NewsTickerState> mapEventToState(
    NewsTickerEvent event,
  ) async* {
    if (event is RefreshNewsTicker) {
      yield* _mapRefreshNewsTickerToState();
    }
  }

  Stream<NewsTickerState> _mapRefreshNewsTickerToState() async* {
    try {
      yield NewsTickerLoading();
      list = await repository.fetchNewsList();
      yield NewsTickerLoaded(list ?? []);
    } catch (e) {
      LogUtil.e('e=$e');
      yield NewsTickerError(code: '-1', msg: 'Something wrong');
    }
  }
}

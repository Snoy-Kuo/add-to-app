import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_module/utils/log_util.dart';
import 'package:flutter_module/models/news/news_item.dart';
import 'package:flutter_module/widgets/type_article_list/model/model.dart';
import 'package:meta/meta.dart';

part 'type_article_list_event.dart';

part 'type_article_list_state.dart';

class TypeArticleListBloc extends Bloc<TypeArticleListEvent, TypeArticleListState> {
  final TypeArticleRepo repository;
  List<NewsItem>? list = [];
  NewsType? type;

  TypeArticleListBloc({required this.repository}) : super(TypeArticleListLoading());

  @override
  Stream<TypeArticleListState> mapEventToState(
      TypeArticleListEvent event,
  ) async* {
    if (event is RefreshTypeArticleList) {
      yield* _mapRefreshTypeArticleListToState(event.type);
    }
  }

  Stream<TypeArticleListState> _mapRefreshTypeArticleListToState(NewsType type) async* {
    try {
      yield TypeArticleListLoading();
      list = await repository.fetchArticleList(type: type);
      this.type = type;
      yield TypeArticleListLoaded((list==null)? []: list!.sublist(0, 2));
    } catch (e) {
      LogUtil.e('e=$e');
      yield TypeArticleListError(code: '-1', msg: 'Something wrong');
    }
  }
}

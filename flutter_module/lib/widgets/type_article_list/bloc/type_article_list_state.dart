part of 'type_article_list_bloc.dart';

@immutable
abstract class TypeArticleListState extends Equatable {}

class TypeArticleListLoading extends TypeArticleListState {
  @override
  List<Object?> get props => [];
}

class TypeArticleListLoaded extends TypeArticleListState {
  final List<NewsItem> list;

  TypeArticleListLoaded([this.list = const []]);

  @override
  List<Object?> get props => [list];
}

class TypeArticleListError extends TypeArticleListState {
  final String msg;
  final String code;

  TypeArticleListError({required this.code, required this.msg});

  @override
  List<Object?> get props => [msg, code];
}

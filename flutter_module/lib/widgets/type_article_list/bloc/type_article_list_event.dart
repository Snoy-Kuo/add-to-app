part of 'type_article_list_bloc.dart';

@immutable
abstract class TypeArticleListEvent extends Equatable {}

class RefreshTypeArticleList extends TypeArticleListEvent {
  final NewsType type;

  RefreshTypeArticleList({required this.type});

  @override
  List<Object?> get props => [type];
}

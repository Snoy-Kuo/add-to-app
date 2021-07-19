import '../../../models/news/news_item.dart';

abstract class TypeArticleRepo {
  Future<List<NewsItem>?> fetchArticleList({required NewsType type});
}

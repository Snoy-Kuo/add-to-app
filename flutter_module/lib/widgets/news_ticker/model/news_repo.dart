import '../../../models/news/news_item.dart';

abstract class NewsRepo {
  Future<List<NewsItem>?> fetchNewsList();
}

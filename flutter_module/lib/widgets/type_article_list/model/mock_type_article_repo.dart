import 'package:flutter_module/widgets/type_article_list/model/type_article_repo.dart';

import '../../../models/news/news_item.dart';

class MockTypeArticleRepo implements TypeArticleRepo {
  final Duration delay;
  List<NewsItem>? fakeList;

  MockTypeArticleRepo([this.fakeList, this.delay = Duration.zero]);

  @override
  Future<List<NewsItem>?> fetchArticleList({required NewsType type}) async {
    List<NewsItem>? list;
    switch (type) {
      case NewsType.TypeRookie:
        {
          list = _defaultFakeRookieList();
        }
        break;
      case NewsType.TypeVeteran:
        {
          list = _defaultFakeVeteranList();
        }
        break;
      default:
        {
          list = [];
        }
        break;
    }
    return Future.delayed(delay, () => fakeList ?? list);
  }

  List<NewsItem> _defaultFakeRookieList() {
    return [
      NewsItem(
        id: 40,
        title: 'Rookie Article 1',
        type: NewsType.TypeRookie,
      ),
      NewsItem(
        id: 41,
        title: 'Rookie Article 2',
        type: NewsType.TypeRookie,
      ),
      NewsItem(
        id: 42,
        title: 'Rookie Article 3',
        type: NewsType.TypeRookie,
      ),
    ];
  }

  List<NewsItem> _defaultFakeVeteranList() {
    return [
      NewsItem(
        id: 50,
        title: 'Veteran Article 1',
        type: NewsType.TypeVeteran,
      ),
      NewsItem(
        id: 51,
        title: 'Veteran Article 2',
        type: NewsType.TypeVeteran,
      ),
      NewsItem(
        id: 52,
        title: 'Veteran Article 3',
        type: NewsType.TypeVeteran,
      ),
    ];
  }
}

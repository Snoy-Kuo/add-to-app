import '../../../models/news/news_item.dart';
import 'news_repo.dart';

class MockNewsRepo implements NewsRepo {
  final Duration delay;
  List<NewsItem>? fakeList;

  MockNewsRepo([this.fakeList, this.delay = Duration.zero]);

  @override
  Future<List<NewsItem>?> fetchNewsList() async {
    return Future.delayed(delay, () => fakeList ?? _defaultFakeList());
  }

  List<NewsItem> _defaultFakeList() {
    return [
      NewsItem(
        id: 0,
        title: 'Broken News 1',
        type: NewsType.TypeGood,
      ),
      NewsItem(
        id: 1,
        title: 'Breaking News 2',
        type: NewsType.TypeBad,
      ),
      NewsItem(
        id: 2,
        title: 'Will break News 3',
        type: NewsType.TypeGood,
      ),
    ];
  }
}

enum NewsType { Type1, Type2 }

class NewsItem {
  final int id;
  final String title;
  final NewsType type;

  NewsItem({required this.id, required this.title, required this.type});
}

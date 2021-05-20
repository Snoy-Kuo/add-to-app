import 'package:equatable/equatable.dart';

enum NewsType { Type1, Type2 }

class NewsItem extends Equatable {
  final int id;
  final String title;
  final NewsType type;

  NewsItem({required this.id, required this.title, required this.type});

  @override
  List<Object?> get props => [id, title, type];
}

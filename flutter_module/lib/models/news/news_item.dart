import 'package:equatable/equatable.dart';

enum NewsType {
  TypeGood,
  TypeBad,
  TypeFlash,
  TypeCalendar,
  TypeRookie,
  TypeVeteran
}

class NewsItem extends Equatable {
  final int id;
  final String title;
  final NewsType type;

  NewsItem({required this.id, required this.title, required this.type});

  @override
  List<Object?> get props => [id, title, type];
}

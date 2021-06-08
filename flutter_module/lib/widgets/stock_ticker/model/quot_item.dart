import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class QuotItem extends Equatable {
  final String id;
  final String name;
  double price;

  QuotItem({required this.id, required this.name, this.price = 0});

  QuotItem copyWith({String? id, String? name, double? price}) => QuotItem(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
      );

  @override
  List<Object?> get props => [id, name, price];
}

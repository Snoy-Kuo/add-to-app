import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';

import 'quot_repo.dart';

class MockQuotRepo implements QuotRepo {
  final Duration delay;
  List<QuotItem>? fakeList;

  MockQuotRepo([this.fakeList, this.delay = Duration.zero]);

  @override
  Future<List<QuotItem>?> fetchQuotList() {
    return Future.delayed(delay, () => fakeList ?? _defaultFakeList());
  }

  List<QuotItem> _defaultFakeList() {
    return [
      QuotItem(id: 'F', name: 'Flutter', price: 123.456),
      QuotItem(id: 'D', name: 'Dart', price: 234.567),
      QuotItem(id: 'A', name: 'Android', price: 345.678),
      QuotItem(id: 'K', name: 'Kotlin', price: 456.789),
      QuotItem(id: 'J', name: 'Java', price: 567.890),
    ];
  }
}

import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';

import 'quot_repo.dart';

class MockQuotRepo implements QuotRepo {
  final Duration delay;

  List<QuotItem>? _fakeList;

  MockQuotRepo([this._fakeList, this.delay = Duration.zero]);

  @override
  Future<List<QuotItem>?> fetchQuotList() {
    return Future.delayed(delay, () => _fakeList ?? _defaultFakeList());
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

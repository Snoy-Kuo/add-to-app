import 'dart:math';

import 'package:flutter_app/model/realtime_quot_repo.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';

class MockRealtimeQuotRepo implements RealtimeQuotRepo {
  final Duration delay;
  QuotItem? fakeItem;
  Random _random = Random();
  bool _isRealtime = false;
  static final Map<String, String> _mapProd = {
    'A': 'Android',
    'B': 'Basic',
    'C': 'C++',
    'D': 'Dart',
    'E': 'ECMAScript',
    'F': 'Flutter',
    'G': 'Go',
    'H': 'Haskell',
    'I': 'iOS',
    'J': 'Java',
    'K': 'Kotlin',
    'L': 'Lua',
    'M': 'MATLAB',
    'N': 'Nim',
    'O': 'ObjectiveC',
    'P': 'Python',
    'Q': 'Qt',
    'R': 'Ruby',
    'S': 'Swift',
    'T': 'TypeScript',
    'U': 'UNITY',
    'V': 'Visual FoxPro',
    'W': 'WebAssembly',
    'X': 'XML',
    'Y': 'YAML',
    'Z': 'Zsh',
  };

  MockRealtimeQuotRepo([this.fakeItem, this.delay = Duration.zero]);

  @override
  Future<QuotItem?> updateQuot() {
    return Future.delayed((delay != Duration.zero) ? delay : _randomDelay(),
        () => fakeItem ?? _defaultFakeItem());
  }

  QuotItem _defaultFakeItem() {
    var item = (_randomItem()..price = _randomPrice());
    return item;
  }

  ///random product from _mapProd
  QuotItem _randomItem() {
    List<MapEntry<String, String>> list = _mapProd.entries.toList();
    int index = _random.nextInt(list.length);
    return QuotItem(id: list[index].key, name: list[index].value);
  }

  ///random duration from 100ms~500ms
  Duration _randomDelay() {
    return Duration(milliseconds: _random.nextInt(400) + 100);
  }

  ///random price from 100~999
  double _randomPrice() {
    return double.parse(
        (_random.nextDouble() * (999 - 100) + 100).toStringAsFixed(3));
  }

  @override
  Future<void> toggleRealtimeQuote(bool enable) async {
    _isRealtime = enable;
  }

  @override
  Stream<QuotItem?> listenRealtimeQuote() async* {
    while (_isRealtime) {
      yield await updateQuot();
    }
  }
}

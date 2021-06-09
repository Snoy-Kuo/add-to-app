import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';

abstract class RealtimeQuotRepo {
  Stream<QuotItem?> listenRealtimeQuote();

  Future<void> toggleRealtimeQuote(bool enable);

  Future<QuotItem?> updateQuot();
}

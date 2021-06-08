import 'quot_item.dart';

abstract class QuotRepo {
  Future<List<QuotItem>?> fetchQuotList();
}

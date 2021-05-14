import 'banner_item.dart';

abstract class BannerRepo {
  Future<List<BannerItem>?> fetchBannerList();
}



import 'banner_item.dart';
import 'banner_repo.dart';

class MockBannerRepo implements BannerRepo {
  final Duration delay;
  List<BannerItem>? fakeList;

  MockBannerRepo([this.fakeList, this.delay = Duration.zero]);

  @override
  Future<List<BannerItem>?> fetchBannerList() async {
    return Future.delayed(delay, () => fakeList ?? _defaultFakeList());
  }

  List<BannerItem> _defaultFakeList() {
    return [
      BannerItem(
        id: 0,
        imageUrl:
            'https://www.advantagepetcare.com.au/sites/g/files/adhwdz311/files/styles/paragraph_image/public/2020-07/istock-871246578_unrestricted_1110x800.jpg?itok=wuuBaqf-',
        targetUrl:
            'https://www.advantagepetcare.com.au/au/puppy-kitten/what-expect-when-bringing-kitten-home/',
      ),
      BannerItem(
        id: 1,
        imageUrl:
            'https://www.pethealthnetwork.com/sites/default/files/why-should-i-spay-my-new-kitten-138101629.jpg',
        targetUrl:
            'https://www.pethealthnetwork.com/cat-health/cat-surgery-a-z/why-should-i-spay-my-new-kitten',
      ),
      BannerItem(
        id: 2,
        imageUrl:
            'https://www.medivet.co.uk/globalassets/assets/advice-articles/puppy-and-kitten/kitten-playing-with-toy.jpg?width=585',
        targetUrl:
            'https://www.medivet.co.uk/pet-care/pet-advice/kitten-play-is-important/',
      )
    ];
  }
}

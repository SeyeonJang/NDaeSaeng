import '../entity/banner_image.dart';

abstract interface class BannerRepository {
  Future<List<BannerImage>> findAllBanners();
}
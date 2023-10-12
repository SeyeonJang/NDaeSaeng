import 'package:dart_flutter/src/data/repository/supabase_banner_repository.dart';
import 'package:dart_flutter/src/domain/entity/banner_image.dart';
import 'package:dart_flutter/src/domain/repository/banner_repository.dart';

class BannerUseCase {
  final _bannerRepository = SupabaseBannerRepository();

  Future<List<BannerImage>> getBanners() async {
    return await _bannerRepository.findAllBanners();
  }
}

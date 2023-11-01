import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/data/repository/supabase_banner_repository.dart';
import 'package:dart_flutter/src/domain/entity/banner_image.dart';

class BannerUseCase {
  final _bannerRepository = SupabaseBannerRepository();
  final _userRepository = DartUserRepositoryImpl();

  Future<List<BannerImage>> getBanners() async {
    var banners = await _bannerRepository.findAllBanners();
    var user = await _userRepository.myInfo();

    List<BannerImage> filteredBanners = [];
    banners.forEach((banner) {
      bool shouldAddBanner = true;
      for (var key in banner.conditions.keys) {
        switch (key) {
          case 'target_gender':  // 특정 성별인 사람
            if ((banner.conditions[key] == 'MALE' && user.personalInfo?.gender != 'MALE') ||
                (banner.conditions[key] == 'FEMALE' && user.personalInfo?.gender != 'FEMALE')) {
              shouldAddBanner = false;
            }
            break;
          case 'target_birth_year':  // 특정 생년인 사람
            if (user.personalInfo?.birthYear != banner.conditions[key]) {
              shouldAddBanner = false;
            }
          case 'target_admission_year':  // 특정 학번인 사람
            if (user.personalInfo?.admissionYear != banner.conditions[key]) {
              shouldAddBanner = false;
            }
          case 'target_nickname_yn':  // 'n' 닉네임이 없는 사람
            if (user.personalInfo?.nickname != 'DEFAULT' || banner.conditions[key] == 'y') {
              shouldAddBanner = false;
            }
        }
      }
      if (shouldAddBanner) {
        filteredBanners.add(banner);
      }
    });
    return filteredBanners;
  }
}

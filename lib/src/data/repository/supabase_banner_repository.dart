import 'package:dart_flutter/src/data/datasource/supabase_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/banner_dto.dart';
import 'package:dart_flutter/src/domain/entity/banner_image.dart';
import 'package:dart_flutter/src/domain/repository/banner_repository.dart';

class SupabaseBannerRepository implements BannerRepository {
  @override
  Future<List<BannerImage>> findAllBanners() async {
    final supabase = SupabaseRemoteDatasource.supabase;
    final List<dynamic> result = await supabase
        .from('banner')
        .select('*');

    final List<BannerImageDto> dtos = result
        .map((data) => BannerImageDto.fromJson(data))
        .toList();

     return dtos
        .where((dto) => dto.enabledYn != 'n')
        .map((b) => b.toBannerImage())
        .toList();
  }
}

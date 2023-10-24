import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/blind_date_team_dto.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/repository/blind_date_team_repository.dart';

class DartTeamRepositoryImpl extends BlindDateTeamRepository {
  @override
  Future<BlindDateTeamDetail> getTeam(int id) async {
    return (await DartApiRemoteDataSource.getBlindDateTeamDetail(id)).newBlindDateTeamDetail();
  }

  @override
  Future<Pagination<BlindDateTeam>> getTeams({int page = 0, int size = 10, int targetLocationId = 0, bool targetCertificated = false, bool targetProfileImage = false}) async {
    print('[RepositoryImpl] targetLocationId: $targetLocationId, targetCertificated: $targetCertificated, targetProfileImage: $targetProfileImage');
    Pagination<BlindDateTeamDto> pageResponse = await DartApiRemoteDataSource.getBlindDateTeams(page: page, size: size, regionId: targetLocationId); // TODO: certificated, profileImage 추가
    return pageResponse.newContent(
      pageResponse.content?.map((team) => team.newBlindDateTeam()).toList() ?? []
    );
  }

  @override
  Future<Pagination<BlindDateTeam>> getTeamsMostLiked({int page = 0, int size = 10, int targetLocationId = 0, bool targetCertificated = false, bool targetProfileImage = false}) async {
    print('[RepositoryImpl] targetLocationId: $targetLocationId, targetCertificated: $targetCertificated, targetProfileImage: $targetProfileImage');
    // dummy
    Pagination<BlindDateTeamDto> pageResponse = await DartApiRemoteDataSource.getBlindDateTeams(page: page, size: size, regionId: targetLocationId);
    BlindDateTeam? firstTeam = pageResponse.content?.first.newBlindDateTeam();
    List<BlindDateTeam> firstTeamList = firstTeam != null ? [firstTeam] : [];
    return pageResponse.newContent(firstTeamList);
    // real
    // Pagination<BlindDateTeamDto> pageResponse = await DartApiRemoteDataSource.getBlindDateTeamsMostLiked(page: page, size: size, regionId: targetLocationId);
    // return pageResponse.newContent(
    //   pageResponse.content?.map((team) => team.newBlindDateTeam()).toList() ?? []
    // );
  }

  @override
  Future<Pagination<BlindDateTeam>> getTeamsMostSeen({int page = 0, int size = 10, int targetLocationId = 0, bool targetCertificated = false, bool targetProfileImage = false}) async {
    print('[RepositoryImpl] targetLocationId: $targetLocationId, targetCertificated: $targetCertificated, targetProfileImage: $targetProfileImage');
    // dummy
    Pagination<BlindDateTeamDto> pageResponse = await DartApiRemoteDataSource.getBlindDateTeams(page: page, size: size, regionId: targetLocationId);
    List<BlindDateTeam> firstTwoTeams = [];
    if (pageResponse.content != null) {
      for (int i = 0; i < 2 && i < pageResponse.content!.length; i++) {
        firstTwoTeams.add(pageResponse.content![i].newBlindDateTeam());
      }
    }
    return pageResponse.newContent(firstTwoTeams);
    // real
    // Pagination<BlindDateTeamDto> pageResponse = await DartApiRemoteDataSource.getBlindDateTeamsMostSeen(page: page, size: size, regionId: targetLocationId);
    // return pageResponse.newContent(
    //   pageResponse.content?.map((team) => team.newBlindDateTeam()).toList() ?? []
    // );
  }
}

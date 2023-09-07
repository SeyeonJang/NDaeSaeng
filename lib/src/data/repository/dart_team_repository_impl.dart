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
  Future<Pagination<BlindDateTeam>> getTeams({int page = 0, int size = 10, int targetLocationId = 0}) async {
    Pagination<BlindDateTeamDto> pageResponse = await DartApiRemoteDataSource.getBlindDateTeams(page: page, size: size, regionId: targetLocationId);
    return pageResponse.newContent(
      pageResponse.content?.map((team) => team.newBlindDateTeam()).toList() ?? []
    );
  }
}

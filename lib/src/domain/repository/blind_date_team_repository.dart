
import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';

abstract class BlindDateTeamRepository {
  Future<Pagination<BlindDateTeam>> getTeams({int page, int size, int targetLocationId});
  Future<BlindDateTeamDetail> getTeam(int id);
}

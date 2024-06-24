import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/type/team.dart';

class TeamMapper {
  static BlindDateTeamDetail toBlindDateTeamDetail(Team team) {
    return BlindDateTeamDetail(
      id: team.getId(),
      name: team.getName(),
      averageAge: team.getAverageAge(),
      regions: team.getRegions(),
      universityName: team.getUniversityName(),
      isCertifiedTeam: team.getIsCertifiedTeam(),
      teamUsers: team.getTeamUsers(),
      proposalStatus: false,
    );
  }
}
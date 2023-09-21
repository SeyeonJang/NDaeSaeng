import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/entity/type/team.dart';

class TeamMapper {
  static BlindDateTeamDetail toBlindDateTeamDetail(Team team) {
    return BlindDateTeamDetail(
      id: team.getId(),
      name: team.getName(),
      averageBirthYear: team.getAverageBirthYear(),
      regions: team.getRegions(),
      universityName: team.getUniversityName(),
      isCertifiedTeam: team.getIsCertifiedTeam(),
      teamUsers: team.getTeamUsers(),
      proposalStatus: false,
    );
  }


  // {required this.id,
  // required this.name,
  // required this.averageBirthYear,
  // required this.regions,
  // required this.universityName,
  // required this.isCertifiedTeam,
  // required this.teamUsers,
  // required this.proposalStatus});
}
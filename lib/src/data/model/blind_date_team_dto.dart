import 'package:dart_flutter/src/data/model/type/blind_date_user_dto.dart';
import 'package:dart_flutter/src/data/model/type/team_region.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';

class BlindDateTeamDto {
  int? id;
  String? name;
  double? averageAge;
  List<TeamRegion>? regions;
  String? universityName;
  bool? isCertifiedTeam;
  List<BlindDateUserDto>? teamUsers;

  BlindDateTeamDto(
      {this.id,
        this.name,
        this.averageAge,
        this.regions,
        this.universityName,
        this.isCertifiedTeam,
        this.teamUsers});

  BlindDateTeam newBlindDateTeam() {
    return BlindDateTeam(
        id: id ?? 0,
        name: name ?? "(알수없음)",
        averageBirthYear: averageAge ?? 1950.0,
        regions: regions?.map((region) => region.newLocation()).toList() ?? [],
        universityName: universityName ?? "(알수없음)",
        isCertifiedTeam: isCertifiedTeam ?? false,
        teamUsers: teamUsers?.map((user) => user.newBlindDateUser()).toList() ?? []
    );
  }

  BlindDateTeamDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    averageAge = json['averageAge'];
    if (json['regions'] != null) {
      regions = <TeamRegion>[];
      json['regions'].forEach((v) {
        regions!.add(TeamRegion.fromJson(v));
      });
    }
    universityName = json['universityName'];
    isCertifiedTeam = json['isCertifiedTeam'];
    if (json['teamUsers'] != null) {
      teamUsers = <BlindDateUserDto>[];
      json['teamUsers'].forEach((v) {
        teamUsers!.add(BlindDateUserDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['averageAge'] = averageAge;
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    data['universityName'] = universityName;
    data['isCertifiedTeam'] = isCertifiedTeam;
    if (teamUsers != null) {
      data['teamUsers'] = teamUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BlindDateTeamResponse{id: $id, name: $name, averageAge: $averageAge, regions: $regions, universityName: $universityName, isCertifiedTeam: $isCertifiedTeam, teamUsers: $teamUsers}';
  }
}

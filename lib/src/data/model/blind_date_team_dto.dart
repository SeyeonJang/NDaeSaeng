import 'package:dart_flutter/src/data/model/type/blind_date_user_dto.dart';
import 'package:dart_flutter/src/data/model/type/team_region.dart';

class BlindDateTeamDto {
  int? id;
  String? name;
  double? averageBirthYear;
  List<TeamRegion>? regions;
  String? universityName;
  bool? isCertifiedTeam;
  List<BlindDateUserDto>? teamUsers;

  BlindDateTeamDto(
      {this.id,
        this.name,
        this.averageBirthYear,
        this.regions,
        this.universityName,
        this.isCertifiedTeam,
        this.teamUsers});

  BlindDateTeamDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    averageBirthYear = json['averageBirthYear'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['averageBirthYear'] = this.averageBirthYear;
    if (this.regions != null) {
      data['regions'] = this.regions!.map((v) => v.toJson()).toList();
    }
    data['universityName'] = this.universityName;
    data['isCertifiedTeam'] = this.isCertifiedTeam;
    if (this.teamUsers != null) {
      data['teamUsers'] = this.teamUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BlindDateTeamResponse{id: $id, name: $name, averageBirthYear: $averageBirthYear, regions: $regions, universityName: $universityName, isCertifiedTeam: $isCertifiedTeam, teamUsers: $teamUsers}';
  }
}

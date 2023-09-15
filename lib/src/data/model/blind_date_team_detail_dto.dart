import 'package:dart_flutter/src/data/model/type/blind_date_user_detail_dto.dart';
import 'package:dart_flutter/src/data/model/type/team_region.dart';

class BlindDateTeamDetailDto {
  int? id;
  String? name;
  double? averageBirthYear;
  List<TeamRegion>? regions;
  String? universityName;
  bool? isCertifiedTeam;
  List<BlindDateUserDetailDto>? teamUsers;

  BlindDateTeamDetailDto(
      {this.id,
        this.name,
        this.averageBirthYear,
        this.regions,
        this.universityName,
        this.isCertifiedTeam,
        this.teamUsers});

  BlindDateTeamDetailDto.fromJson(Map<String, dynamic> json) {
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
      teamUsers = <BlindDateUserDetailDto>[];
      json['teamUsers'].forEach((v) {
        teamUsers!.add(BlindDateUserDetailDto.fromJson(v));
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
    return 'BlindDateTeamDetailResponse{id: $id, name: $name, averageBirthYear: $averageBirthYear, regions: $regions, universityName: $universityName, isCertifiedTeam: $isCertifiedTeam, teamUsers: $teamUsers}';
  }
}

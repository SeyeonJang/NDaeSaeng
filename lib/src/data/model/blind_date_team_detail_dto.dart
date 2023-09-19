import 'package:dart_flutter/src/data/model/type/blind_date_user_detail_dto.dart';
import 'package:dart_flutter/src/data/model/type/team_region.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';

class BlindDateTeamDetailDto {
  int? id;
  String? name;
  double? averageBirthYear;
  List<TeamRegion>? regions;
  String? universityName;
  bool? isCertifiedTeam;
  List<BlindDateUserDetailDto>? teamUsers;
  bool? proposalStatus; // TODO : 최현식

  BlindDateTeamDetailDto(
      {this.id,
        this.name,
        this.averageBirthYear,
        this.regions,
        this.universityName,
        this.isCertifiedTeam,
        this.teamUsers});

  BlindDateTeamDetail newBlindDateTeamDetail() {
    return BlindDateTeamDetail(
        id: id ?? 0,
        name: name ?? "(알수없음)",
        averageBirthYear: averageBirthYear ?? 1950.0,
        regions: regions?.map((region) => region.newLocation()).toList() ?? [],
        universityName: universityName ?? "(알수없음)",
        isCertifiedTeam: isCertifiedTeam ?? false,
        teamUsers: teamUsers?.map((user) => user.newBlindDateUserDetail()).toList() ?? [],
        proposalStatus: proposalStatus ?? true, // TODO : 최현식
    );
  }

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['averageBirthYear'] = averageBirthYear;
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
    return 'BlindDateTeamDetailResponse{id: $id, name: $name, averageBirthYear: $averageBirthYear, regions: $regions, universityName: $universityName, isCertifiedTeam: $isCertifiedTeam, teamUsers: $teamUsers}';
  }
}

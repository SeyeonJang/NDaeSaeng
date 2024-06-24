import 'package:dart_flutter/src/data/model/type/blind_date_user_detail_dto.dart';
import 'package:dart_flutter/src/data/model/type/team_region.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';

class BlindDateTeamDetailDto {
  int? id;
  String? name;
  double? averageAge;
  List<TeamRegion>? regions;
  String? universityName;
  bool? isCertifiedTeam;
  List<BlindDateUserDetailDto>? teamUsers;
  bool? proposalStatus;

  BlindDateTeamDetailDto(
      {this.id,
        this.name,
        this.averageAge,
        this.regions,
        this.universityName,
        this.isCertifiedTeam,
        this.teamUsers});

  BlindDateTeamDetail newBlindDateTeamDetail() {
    return BlindDateTeamDetail(
        id: id ?? 0,
        name: name ?? "(알수없음)",
        averageAge: averageAge ?? 0.0,
        regions: regions?.map((region) => region.newLocation()).toList() ?? [],
        universityName: universityName ?? "(알수없음)",
        isCertifiedTeam: isCertifiedTeam ?? false,
        teamUsers: teamUsers?.map((user) => user.newBlindDateUserDetail()).toList() ?? [],
        proposalStatus: proposalStatus ?? false,
    );
  }

  BlindDateTeamDetailDto.fromJson(Map<String, dynamic> json) {
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
      teamUsers = <BlindDateUserDetailDto>[];
      json['teamUsers'].forEach((v) {
        teamUsers!.add(BlindDateUserDetailDto.fromJson(v));
      });
    }
    proposalStatus = json['isAlreadyProposalTeam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['averageBirthYear'] = averageAge;
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    data['universityName'] = universityName;
    data['isCertifiedTeam'] = isCertifiedTeam;
    if (teamUsers != null) {
      data['teamUsers'] = teamUsers!.map((v) => v.toJson()).toList();
    }
    data['isAlreadyProposalTeam'] = proposalStatus ?? false;
    return data;
  }

  @override
  String toString() {
    return 'BlindDateTeamDetailResponse{id: $id, name: $name, averageBirthYear: $averageAge, regions: $regions, universityName: $universityName, isCertifiedTeam: $isCertifiedTeam, teamUsers: $teamUsers}';
  }
}

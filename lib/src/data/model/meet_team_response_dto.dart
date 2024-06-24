import 'package:dart_flutter/src/data/model/type/team_region.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';

import '../../domain/entity/meet_team.dart';

class MeetTeamResponseDto {
  int? teamId;
  String? name;
  bool? isVisibleToSameUniversity;
  List<UserDto>? teamUsers;
  List<TeamRegion>? teamRegions;

  MeetTeamResponseDto(
      {this.teamId,
        this.name,
        this.isVisibleToSameUniversity,
        this.teamUsers,
        this.teamRegions});

  MeetTeam newMeetTeam() {
    return MeetTeam(
      id: teamId ?? 0,
      name: name ?? "(알수없음)",
      university: teamUsers?[0].university?.newUniversity() ?? University(id: 0, name: "(알수없음)", department: "(알수없음)"),
      locations: teamRegions?.map((e) => e.newLocation()).toList() ?? [],
      canMatchWithSameUniversity: isVisibleToSameUniversity ?? false,
      members: teamUsers?.map((e) => e.newUser()).toList() ?? [],
    );
  }

  MeetTeamResponseDto.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'];
    name = json['name'];
    isVisibleToSameUniversity = json['isVisibleToSameUniversity'];
    if (json['teamUsers'] != null) {
      teamUsers = <UserDto>[];
      json['teamUsers'].forEach((v) {
        teamUsers!.add(UserDto.fromJson(v));
      });
    }
    if (json['teamRegions'] != null) {
      teamRegions = <TeamRegion>[];
      json['teamRegions'].forEach((v) {
        teamRegions!.add(TeamRegion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamId'] = teamId;
    data['name'] = name;
    data['isVisibleToSameUniversity'] = isVisibleToSameUniversity;
    if (teamUsers != null) {
      data['teamUsers'] = teamUsers!.map((v) => v.toJson()).toList();
    }
    if (teamRegions != null) {
      data['teamRegions'] = teamRegions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'MeetTeamResponseDto{teamId: $teamId, name: $name, isVisibleToSameUniversity: $isVisibleToSameUniversity, teamUsers: $teamUsers, teamRegions: $teamRegions}';
  }
}

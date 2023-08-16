import 'package:dart_flutter/src/data/model/type/team_region.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';

import '../../domain/entity/meet_team.dart';

class MeetTeamResponseDto {
  int? teamId;
  String? name;
  bool? isVisibleToSameUniversity;
  List<UserDto>? teamUser;
  List<TeamRegion>? teamRegion;

  MeetTeamResponseDto(
      {this.teamId,
        this.name,
        this.isVisibleToSameUniversity,
        this.teamUser,
        this.teamRegion});

  MeetTeam newMeetTeam() {
    return MeetTeam(
      id: teamId ?? 0,
      name: name ?? "(알수없음)",
      university: teamUser?[0].university?.newUniversity() ?? University(id: 0, name: "(알수없음)", department: "(알수없음)"),
      locations: teamRegion?.map((e) => e.newLocation()).toList() ?? [],
      canMatchWithSameUniversity: isVisibleToSameUniversity ?? false,
      members: teamUser?.map((e) => e.newUser()).toList() ?? [],
    );
  }

  MeetTeamResponseDto.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'];
    name = json['name'];
    isVisibleToSameUniversity = json['isVisibleToSameUniversity'];
    if (json['teamUser'] != null) {
      teamUser = <UserDto>[];
      json['teamUser'].forEach((v) {
        teamUser!.add(new UserDto.fromJson(v));
      });
    }
    if (json['teamRegion'] != null) {
      teamRegion = <TeamRegion>[];
      json['teamRegion'].forEach((v) {
        teamRegion!.add(new TeamRegion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamId'] = this.teamId;
    data['name'] = this.name;
    data['isVisibleToSameUniversity'] = this.isVisibleToSameUniversity;
    if (this.teamUser != null) {
      data['teamUser'] = this.teamUser!.map((v) => v.toJson()).toList();
    }
    if (this.teamRegion != null) {
      data['teamRegion'] = this.teamRegion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

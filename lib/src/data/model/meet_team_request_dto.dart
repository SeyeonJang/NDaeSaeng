import 'package:dart_flutter/src/domain/entity/meet_team.dart';

class MeetTeamRequestDto {
  String? name;
  bool? isVisibleToSameUniversity;
  List<int>? teamRegionIds;
  List<int>? teamUserIds;

  MeetTeamRequestDto(
      {this.name,
        this.isVisibleToSameUniversity,
        this.teamRegionIds,
        this.teamUserIds});

  MeetTeamRequestDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isVisibleToSameUniversity = json['isVisibleToSameUniversity'];
    teamRegionIds = json['teamRegionIds'].cast<int>();
    teamUserIds = json['teamUserIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isVisibleToSameUniversity'] = this.isVisibleToSameUniversity;
    data['teamRegionIds'] = this.teamRegionIds;
    data['teamUserIds'] = this.teamUserIds;
    return data;
  }

  static MeetTeamRequestDto fromMeetTeam(MeetTeam meetTeam) {
    return MeetTeamRequestDto(
      name: meetTeam.name,
      isVisibleToSameUniversity: meetTeam.canMatchWithSameUniversity,
      teamUserIds: meetTeam.members.map((user) => user.personalInfo!.id).toList(),
      teamRegionIds: meetTeam.locations.map((location) => location.id).toList(),
    );
  }
}

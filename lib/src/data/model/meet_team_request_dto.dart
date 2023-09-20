import 'package:dart_flutter/src/domain/entity/meet_team.dart';

class MeetTeamRequestDto {
  String? name;
  bool? isVisibleToSameUniversity;
  List<int>? teamRegionIds;
  List<int>? teamUserIds;
  List<_FriendDto>? friends;

  MeetTeamRequestDto(
      {this.name,
        this.isVisibleToSameUniversity,
        this.teamRegionIds,
        this.teamUserIds,
        this.friends});

  MeetTeamRequestDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isVisibleToSameUniversity = json['isVisibleToSameUniversity'];
    teamRegionIds = json['regionIds'].cast<int>();
    teamUserIds = json['userIds'].cast<int>();
    if (json['friends'] != null) {
      friends = <_FriendDto>[];
      json['friends'].forEach((v) {
        friends!.add(_FriendDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isVisibleToSameUniversity'] = isVisibleToSameUniversity;
    data['regionIds'] = teamRegionIds;
    data['userIds'] = teamUserIds;
    data['friends'] = friends;
    return data;
  }

  static MeetTeamRequestDto fromMeetTeam(MeetTeam meetTeam) {
    return MeetTeamRequestDto(
      name: meetTeam.name,
      isVisibleToSameUniversity: meetTeam.canMatchWithSameUniversity,
      teamUserIds: meetTeam.members.map((user) => user.getId()).toList(),
      teamRegionIds: meetTeam.locations.map((location) => location.id).toList(),
    );
  }
}

class _FriendDto {
  String? name;
  int? birthyear;
  int? universityId;
  String? porfileimageurl;

  _FriendDto({this.name, this.birthyear, this.universityId, this.porfileimageurl});

  _FriendDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthyear = json['birthyear'];
    universityId = json['universityId'];
    porfileimageurl = json['porfileimageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['birthyear'] = this.birthyear;
    data['universityId'] = this.universityId;
    data['porfileimageurl'] = this.porfileimageurl;
    return data;
  }
}

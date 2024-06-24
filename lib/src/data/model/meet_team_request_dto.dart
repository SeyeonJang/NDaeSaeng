import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/entity/type/student.dart';

class MeetTeamRequestDto {
  String? name;
  bool? isVisibleToSameUniversity;
  List<int>? teamRegionIds;
  List<int>? teamUserIds;
  List<_FriendDto>? friends;

  MeetTeamRequestDto({this.name, this.isVisibleToSameUniversity, this.teamRegionIds, this.teamUserIds, this.friends});

  MeetTeamRequestDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isVisibleToSameUniversity = json['isVisibleToSameUniversity'];
    teamRegionIds = json['regionIds'].cast<int>();
    teamUserIds = json['userIds'].cast<int>();
    if (json['singleTeamFriends'] != null) {
      friends = <_FriendDto>[];
      json['singleTeamFriends'].forEach((v) {
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
    data['singleTeamFriends'] = friends;
    return data;
  }

  static MeetTeamRequestDto fromMeetTeam(MeetTeam meetTeam) {
    List<int> teamUserIds = meetTeam.members.map((user) => user.getId()).toList();
    teamUserIds.removeWhere((element) => element == 0);

    List<_FriendDto> friends = [];
    if (teamUserIds.isEmpty) {
      friends = meetTeam.members.map((user) => _FriendDto.fromStudnet(user)).toList();
    }

    return MeetTeamRequestDto(
      name: meetTeam.name,
      isVisibleToSameUniversity: meetTeam.canMatchWithSameUniversity,
      teamUserIds: teamUserIds,
      teamRegionIds: meetTeam.locations.map((location) => location.id).toList(),
      friends: friends.isNotEmpty ? friends : null,
    );
  }
}

class _FriendDto {
  String? name;
  int? birthyear;
  int? universityId;
  String? profileImageUrl;

  _FriendDto({this.name, this.birthyear, this.universityId, this.profileImageUrl});

  static _FriendDto fromStudnet(Student student) {
    return _FriendDto(
        name: student.getName(),
        birthyear: student.getBirthYear(),
        universityId: student.getUniversityId(),
        profileImageUrl: student.getProfileImageUrl());
  }

  _FriendDto.fromJson(Map<String, dynamic> json) {
    name = json['nickname'];
    birthyear = json['birthYear'];
    universityId = json['universityId'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = name;
    data['birthYear'] = birthyear;
    data['universityId'] = universityId;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }

  @override
  String toString() {
    return '_FriendDto{name: $name, birthyear: $birthyear, universityId: $universityId, profileImageUrl: $profileImageUrl}';
  }
}

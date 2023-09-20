import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';
import 'package:dart_flutter/src/domain/entity/type/team.dart';
import 'package:dart_flutter/src/domain/mapper/blind_date_user_mapper.dart';

class BlindDateTeamDetail implements Team {
  final int id;
  final String name;
  final double averageBirthYear;
  final List<Location> regions;
  final String universityName;
  final bool isCertifiedTeam;
  final List<BlindDateUserDetail> teamUsers;
  final bool proposalStatus;

  BlindDateTeamDetail(
      {required this.id,
       required this.name,
       required this.averageBirthYear,
       required this.regions,
       required this.universityName,
       required this.isCertifiedTeam,
       required this.teamUsers,
       required this.proposalStatus});

  factory BlindDateTeamDetail.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedName = json['name'];
    final double parsedAverageBirthYear = json['averageBirthYear'];

    List<Location> parsedRegions = [];
    if (json['regions'] != null) {
      var regionsJsonList = json['regions'] as List<dynamic>;
      parsedRegions =
          regionsJsonList.map((v) => Location.fromJson(v)).toList();
    }

    final String parsedUniversityName = json['universityName'];
    final bool parsedIsCertifiedTeam = json['isCertifiedTeam'];

    List<BlindDateUserDetail> parsedTeamUsers = [];
    if (json['teamUsers'] != null) {
      var teamUsersJsonList = json['teamUsers'] as List<dynamic>;
      parsedTeamUsers =
          teamUsersJsonList.map((v) => BlindDateUserDetail.fromJson(v)).toList();
    }

    final bool parsedProposalStatus = json['proposalStatus'];

    return BlindDateTeamDetail(
        id:parsedId ,
        name:parsedName ,
        averageBirthYear:parsedAverageBirthYear ,
        regions :parsedRegions ,
        universityName :parsedUniversityName ,
        isCertifiedTeam :parsedIsCertifiedTeam ,
        teamUsers :parsedTeamUsers,
        proposalStatus: parsedProposalStatus
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['averageBirthYear'] = averageBirthYear;
    if (regions.isNotEmpty) {
      data['regions'] = regions.map((v) => v.toJson()).toList();
    }
    data['universityName'] = universityName;
    data['isCertifiedTeam'] = isCertifiedTeam;
    if (teamUsers.isNotEmpty) {
      data['teamUsers'] = teamUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BlindDateTeamDetailResponse{id: $id, name: $name, averageBirthYear: $averageBirthYear, regions: $regions, universityName: $universityName, isCertifiedTeam: $isCertifiedTeam, teamUsers: $teamUsers}';
  }

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }

  @override
  double getAverageBirthYear() {
    return averageBirthYear;
  }

  @override
  List<Location> getRegions() {
    return regions;
  }

  @override
  String getUniversityName() {
    return universityName;
  }

  @override
  bool getIsCertifiedTeam() {
    return isCertifiedTeam;
  }

  @override
  List<BlindDateUser> getTeamUsers() {
    return teamUsers.map((user) => BlindDateUserMapper.toBlindDateUser(user)).toList();
  }
}

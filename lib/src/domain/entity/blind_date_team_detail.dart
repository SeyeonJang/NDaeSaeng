import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';

class BlindDateTeamDetail {
  final int id;
  final String name;
  final double averageBirthYear;
  final List<Location> regions;
  final String universityName;
  final bool isCertifiedTeam;
  final List<BlindDateUserDetail> teamUsers;

  BlindDateTeamDetail(
      {required this.id,
       required this.name,
       required this.averageBirthYear,
       required this.regions,
       required this.universityName,
       required this.isCertifiedTeam,
       required this.teamUsers});

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

    return BlindDateTeamDetail(
        id:parsedId ,
        name:parsedName ,
        averageBirthYear:parsedAverageBirthYear ,
        regions :parsedRegions ,
        universityName :parsedUniversityName ,
        isCertifiedTeam :parsedIsCertifiedTeam ,
        teamUsers :parsedTeamUsers
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
}

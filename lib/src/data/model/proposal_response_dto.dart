import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';

class ProposalResponseDto {
  int? _proposalId;
  String? _createdTime;
  ProposalTeam? _requestingTeam;
  ProposalTeam? _requestedTeam;

  ProposalResponseDto(
      {int? proposalId,
        String? createdTime,
        ProposalTeam? requestingTeam,
        ProposalTeam? requestedTeam}) {
    if (proposalId != null) {
      _proposalId = proposalId;
    }
    if (createdTime != null) {
      _createdTime = createdTime;
    }
    if (requestingTeam != null) {
      _requestingTeam = requestingTeam;
    }
    if (requestedTeam != null) {
      _requestedTeam = requestedTeam;
    }
  }

  Proposal newProposal() {
    return Proposal(
      proposalId: _proposalId ?? 0,
      createdTime: _createdTime != null ? DateTime.parse(_createdTime!) : DateTime.now(),
      requestedTeam: _requestedTeam?.newBlindDateTeam() ?? emptyBlindDateTeam(),
      requestingTeam: _requestingTeam?.newBlindDateTeam() ?? emptyBlindDateTeam()
    );
  }

  static BlindDateTeam emptyBlindDateTeam() {
    return BlindDateTeam(
        id: 0,
        name: "(알수없음)",
        averageBirthYear: 0.0,
        regions: [],
        universityName: "(알수없음)",
        isCertifiedTeam: false,
        teamUsers: []
    );
  }

  int? get proposalId => _proposalId;
  set proposalId(int? proposalId) => _proposalId = proposalId;
  String? get createdTime => _createdTime;
  set createdTime(String? createdTime) => _createdTime = createdTime;
  ProposalTeam? get requestingTeam => _requestingTeam;
  set requestingTeam(ProposalTeam? requestingTeam) =>
      _requestingTeam = requestingTeam;
  ProposalTeam? get requestedTeam => _requestedTeam;
  set requestedTeam(ProposalTeam? requestedTeam) =>
      _requestedTeam = requestedTeam;

  ProposalResponseDto.fromJson(Map<String, dynamic> json) {
    _proposalId = json['proposalId'];
    _createdTime = json['createdTime'];
    _requestingTeam = json['requestingTeam'] != null
        ? ProposalTeam.fromJson(json['requestingTeam'])
        : null;
    _requestedTeam = json['requestedTeam'] != null
        ? ProposalTeam.fromJson(json['requestedTeam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['proposalId'] = _proposalId;
    data['createdTime'] = _createdTime;
    if (_requestingTeam != null) {
      data['requestingTeam'] = _requestingTeam!.toJson();
    }
    if (_requestedTeam != null) {
      data['requestedTeam'] = _requestedTeam!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ProposalResponseDto{_proposalId: $_proposalId, _createdTime: $_createdTime, _requestingTeam: $_requestingTeam, _requestedTeam: $_requestedTeam}';
  }
}

class ProposalTeam {
  int? _teamId;
  String? _name;
  double? _averageAge;
  List<Users>? _users;
  List<Regions>? _regions;

  ProposalTeam(
      {int? teamId,
        String? name,
        double? averageAge,
        List<Users>? users,
        List<Regions>? regions}) {
    if (teamId != null) {
      _teamId = teamId;
    }
    if (name != null) {
      _name = name;
    }
    if (averageAge != null) {
      _averageAge = averageAge;
    }
    if (users != null) {
      _users = users;
    }
    if (regions != null) {
      _regions = regions;
    }
  }

  BlindDateTeam newBlindDateTeam() {
    // 인증자가 있는 팀인지 확인
    bool isCertifiedTeam = false;
    if (users != null) {
      for (var user in users!) {
        if (IdCardVerificationStatus.fromValue(user._studentIdCardVerificationStatus).isVerificationSuccess) {
          isCertifiedTeam = true;
          break;
        }
      }
    }

    return BlindDateTeam(
        id: _teamId ?? 0,
        name: _name ?? "(알수없음)",
        averageBirthYear: _averageAge ?? 0.0,
        regions: regions?.map((region) => region.newLocation()).toList() ?? [],
        universityName: users?.first._university?._name ?? "(알수없음)",
        isCertifiedTeam: isCertifiedTeam,
        teamUsers: users?.map((user) => user.newBlindDateUser()).toList() ?? []
    );
  }

  int? get teamId => _teamId;
  set teamId(int? teamId) => _teamId = teamId;
  String? get name => _name;
  set name(String? name) => _name = name;
  double? get averageAge => _averageAge;
  set averageAge(double? averageAge) => _averageAge = averageAge;
  List<Users>? get users => _users;
  set users(List<Users>? users) => _users = users;
  List<Regions>? get regions => _regions;
  set regions(List<Regions>? regions) => _regions = regions;

  ProposalTeam.fromJson(Map<String, dynamic> json) {
    _teamId = json['teamId'];
    _name = json['name'];
    _averageAge = json['averageAge'];
    if (json['users'] != null) {
      _users = <Users>[];
      json['users'].forEach((v) {
        _users!.add(Users.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      _regions = <Regions>[];
      json['regions'].forEach((v) {
        _regions!.add(Regions.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamId'] = _teamId;
    data['name'] = _name;
    data['averageAge'] = _averageAge;
    if (_users != null) {
      data['users'] = _users!.map((v) => v.toJson()).toList();
    }
    if (_regions != null) {
      data['regions'] = _regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'RequestingTeam{_teamId: $_teamId, _name: $_name, _averageAge: $_averageAge, _users: $_users, _regions: $_regions}';
  }
}

class Users {
  int? _userId;
  String? _nickname;
  int? _birthYear;
  String? _studentIdCardVerificationStatus;
  String? _profileImageUrl;
  University? _university;

  Users(
      {int? userId,
        String? nickname,
        int? birthYear,
        String? studentIdCardVerificationStatus,
        String? profileImageUrl,
        University? university}) {
    if (userId != null) {
      _userId = userId;
    }
    if (nickname != null) {
      _nickname = nickname;
    }
    if (birthYear != null) {
      _birthYear = birthYear;
    }
    if (studentIdCardVerificationStatus != null) {
      _studentIdCardVerificationStatus = studentIdCardVerificationStatus;
    }
    if (profileImageUrl != null) {
      _profileImageUrl = profileImageUrl;
    }
    if (university != null) {
      _university = university;
    }
  }

  BlindDateUser newBlindDateUser() {
    return BlindDateUser(
      id: _userId ?? 0,
      name: _nickname ?? "(알수없음)",
      profileImageUrl: _profileImageUrl ?? "DEFAULT",
      department: _university?._department ?? "(알수없음)",
    );
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get nickname => _nickname;
  set nickname(String? nickname) => _nickname = nickname;
  int? get birthYear => _birthYear;
  set birthYear(int? birthYear) => _birthYear = birthYear;
  String? get studentIdCardVerificationStatus =>
      _studentIdCardVerificationStatus;
  set studentIdCardVerificationStatus(
      String? studentIdCardVerificationStatus) =>
      _studentIdCardVerificationStatus = studentIdCardVerificationStatus;
  String? get profileImageUrl => _profileImageUrl;
  set profileImageUrl(String? profileImageUrl) =>
      _profileImageUrl = profileImageUrl;
  University? get university => _university;
  set university(University? university) => _university = university;

  Users.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _nickname = json['nickname'];
    _birthYear = json['birthYear'];
    _studentIdCardVerificationStatus = json['studentIdCardVerificationStatus'];
    _profileImageUrl = json['profileImageUrl'];
    _university = json['university'] != null
        ? University.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = _userId;
    data['nickname'] = _nickname;
    data['birthYear'] = _birthYear;
    data['studentIdCardVerificationStatus'] =
        _studentIdCardVerificationStatus;
    data['profileImageUrl'] = _profileImageUrl;
    if (_university != null) {
      data['university'] = _university!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Users{_userId: $_userId, _nickname: $_nickname, _birthYear: $_birthYear, _studentIdCardVerificationStatus: $_studentIdCardVerificationStatus, _profileImageUrl: $_profileImageUrl, _university: $_university}';
  }
}

class University {
  int? _universityId;
  String? _name;
  String? _department;

  University({int? universityId, String? name, String? department}) {
    if (universityId != null) {
      _universityId = universityId;
    }
    if (name != null) {
      _name = name;
    }
    if (department != null) {
      _department = department;
    }
  }

  int? get universityId => _universityId;
  set universityId(int? universityId) => _universityId = universityId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get department => _department;
  set department(String? department) => _department = department;

  University.fromJson(Map<String, dynamic> json) {
    _universityId = json['universityId'];
    _name = json['name'];
    _department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['universityId'] = _universityId;
    data['name'] = _name;
    data['department'] = _department;
    return data;
  }
}

class Regions {
  int? _regionId;
  String? _name;

  Regions({int? regionId, String? name}) {
    if (regionId != null) {
      _regionId = regionId;
    }
    if (name != null) {
      _name = name;
    }
  }

  Location newLocation() {
    return Location(id: _regionId ?? 0, name: _name ?? "(알수없음)");
  }

  int? get regionId => _regionId;
  set regionId(int? regionId) => _regionId = regionId;
  String? get name => _name;
  set name(String? name) => _name = name;

  Regions.fromJson(Map<String, dynamic> json) {
    _regionId = json['regionId'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionId'] = _regionId;
    data['name'] = _name;
    return data;
  }

  @override
  String toString() {
    return 'Regions{_regionId: $_regionId, _name: $_name}';
  }
}

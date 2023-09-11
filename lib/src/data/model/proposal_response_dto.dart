class ProposalResponseDto {
  int? _proposalId;
  String? _createdTime;
  RequestingTeam? _requestingTeam;
  RequestedTeam? _requestedTeam;

  ProposalResponseDto(
      {int? proposalId,
        String? createdTime,
        RequestingTeam? requestingTeam,
        RequestedTeam? requestedTeam}) {
    if (proposalId != null) {
      this._proposalId = proposalId;
    }
    if (createdTime != null) {
      this._createdTime = createdTime;
    }
    if (requestingTeam != null) {
      this._requestingTeam = requestingTeam;
    }
    if (requestedTeam != null) {
      this._requestedTeam = requestedTeam;
    }
  }

  int? get proposalId => _proposalId;
  set proposalId(int? proposalId) => _proposalId = proposalId;
  String? get createdTime => _createdTime;
  set createdTime(String? createdTime) => _createdTime = createdTime;
  RequestingTeam? get requestingTeam => _requestingTeam;
  set requestingTeam(RequestingTeam? requestingTeam) =>
      _requestingTeam = requestingTeam;
  RequestedTeam? get requestedTeam => _requestedTeam;
  set requestedTeam(RequestedTeam? requestedTeam) =>
      _requestedTeam = requestedTeam;

  ProposalResponseDto.fromJson(Map<String, dynamic> json) {
    _proposalId = json['proposalId'];
    _createdTime = json['createdTime'];
    _requestingTeam = json['requestingTeam'] != null
        ? new RequestingTeam.fromJson(json['requestingTeam'])
        : null;
    _requestedTeam = json['requestedTeam'] != null
        ? new RequestedTeam.fromJson(json['requestedTeam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['proposalId'] = this._proposalId;
    data['createdTime'] = this._createdTime;
    if (this._requestingTeam != null) {
      data['requestingTeam'] = this._requestingTeam!.toJson();
    }
    if (this._requestedTeam != null) {
      data['requestedTeam'] = this._requestedTeam!.toJson();
    }
    return data;
  }
}

class RequestingTeam {
  int? _teamId;
  String? _name;
  double? _averageAge;
  List<Users>? _users;
  List<Regions>? _regions;

  RequestingTeam(
      {int? teamId,
        String? name,
        double? averageAge,
        List<Users>? users,
        List<Regions>? regions}) {
    if (teamId != null) {
      this._teamId = teamId;
    }
    if (name != null) {
      this._name = name;
    }
    if (averageAge != null) {
      this._averageAge = averageAge;
    }
    if (users != null) {
      this._users = users;
    }
    if (regions != null) {
      this._regions = regions;
    }
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

  RequestingTeam.fromJson(Map<String, dynamic> json) {
    _teamId = json['teamId'];
    _name = json['name'];
    _averageAge = json['averageAge'];
    if (json['users'] != null) {
      _users = <Users>[];
      json['users'].forEach((v) {
        _users!.add(new Users.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      _regions = <Regions>[];
      json['regions'].forEach((v) {
        _regions!.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamId'] = this._teamId;
    data['name'] = this._name;
    data['averageAge'] = this._averageAge;
    if (this._users != null) {
      data['users'] = this._users!.map((v) => v.toJson()).toList();
    }
    if (this._regions != null) {
      data['regions'] = this._regions!.map((v) => v.toJson()).toList();
    }
    return data;
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
      this._userId = userId;
    }
    if (nickname != null) {
      this._nickname = nickname;
    }
    if (birthYear != null) {
      this._birthYear = birthYear;
    }
    if (studentIdCardVerificationStatus != null) {
      this._studentIdCardVerificationStatus = studentIdCardVerificationStatus;
    }
    if (profileImageUrl != null) {
      this._profileImageUrl = profileImageUrl;
    }
    if (university != null) {
      this._university = university;
    }
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
        ? new University.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['nickname'] = this._nickname;
    data['birthYear'] = this._birthYear;
    data['studentIdCardVerificationStatus'] =
        this._studentIdCardVerificationStatus;
    data['profileImageUrl'] = this._profileImageUrl;
    if (this._university != null) {
      data['university'] = this._university!.toJson();
    }
    return data;
  }
}

class University {
  int? _universityId;
  String? _name;
  String? _department;

  University({int? universityId, String? name, String? department}) {
    if (universityId != null) {
      this._universityId = universityId;
    }
    if (name != null) {
      this._name = name;
    }
    if (department != null) {
      this._department = department;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['universityId'] = this._universityId;
    data['name'] = this._name;
    data['department'] = this._department;
    return data;
  }
}

class Regions {
  int? _regionId;
  String? _name;

  Regions({int? regionId, String? name}) {
    if (regionId != null) {
      this._regionId = regionId;
    }
    if (name != null) {
      this._name = name;
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regionId'] = this._regionId;
    data['name'] = this._name;
    return data;
  }
}

class RequestedTeam {
  int? _teamId;
  String? _name;
  int? _averageAge;
  List<Users>? _users;
  List<Regions>? _regions;

  RequestedTeam(
      {int? teamId,
        String? name,
        int? averageAge,
        List<Users>? users,
        List<Regions>? regions}) {
    if (teamId != null) {
      this._teamId = teamId;
    }
    if (name != null) {
      this._name = name;
    }
    if (averageAge != null) {
      this._averageAge = averageAge;
    }
    if (users != null) {
      this._users = users;
    }
    if (regions != null) {
      this._regions = regions;
    }
  }

  int? get teamId => _teamId;
  set teamId(int? teamId) => _teamId = teamId;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get averageAge => _averageAge;
  set averageAge(int? averageAge) => _averageAge = averageAge;
  List<Users>? get users => _users;
  set users(List<Users>? users) => _users = users;
  List<Regions>? get regions => _regions;
  set regions(List<Regions>? regions) => _regions = regions;

  RequestedTeam.fromJson(Map<String, dynamic> json) {
    _teamId = json['teamId'];
    _name = json['name'];
    _averageAge = json['averageAge'];
    if (json['users'] != null) {
      _users = <Users>[];
      json['users'].forEach((v) {
        _users!.add(new Users.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      _regions = <Regions>[];
      json['regions'].forEach((v) {
        _regions!.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamId'] = this._teamId;
    data['name'] = this._name;
    data['averageAge'] = this._averageAge;
    if (this._users != null) {
      data['users'] = this._users!.map((v) => v.toJson()).toList();
    }
    if (this._regions != null) {
      data['regions'] = this._regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';

class ChatroomDto {
  int? _chatRoomId;
  String? _latestChatMessageContent;
  String? _latestChatMessageTime;
  RequestingTeam? _requestingTeam;
  RequestingTeam? _requestedTeam;

  ChatroomDto(
      {int? chatRoomId,
      String? latestChatMessageContent,
      String? latestChatMessageTime,
      RequestingTeam? requestingTeam,
      RequestingTeam? requestedTeam}) {
    if (chatRoomId != null) {
      _chatRoomId = chatRoomId;
    }
    if (latestChatMessageContent != null) {
      _latestChatMessageContent = latestChatMessageContent;
    }
    if (latestChatMessageTime != null) {
      _latestChatMessageTime = latestChatMessageTime;
    }
    if (requestingTeam != null) {
      _requestingTeam = requestingTeam;
    }
    if (requestedTeam != null) {
      _requestedTeam = requestedTeam;
    }
  }

  ChatRoom newChatRoom(int userId) {
    // find my team
    var tempTeamA = teamDtoToBlindDateTeam(requestingTeam);
    var tempTeamB = teamDtoToBlindDateTeam(requestedTeam);

    BlindDateTeam myTeam;
    BlindDateTeam otherTeam;
    if (isMyTeam(tempTeamA, userId)) {
      myTeam = tempTeamA;
      otherTeam = tempTeamB;
    } else {
      myTeam = tempTeamB;
      otherTeam = tempTeamA;
    }

    // return
    return ChatRoom(
      id: _chatRoomId ?? 0,
      myTeam: myTeam,
      otherTeam: otherTeam,
      message: ChatMessage(
        userId: 0,
        message: _latestChatMessageContent ?? "",
        sendTime: DateTime.parse(_latestChatMessageTime ?? "0000-00-00 00:00:00"),
      ),
    );
  }

  bool isMyTeam(BlindDateTeam team, int userId) {
    for (var user in team.teamUsers) {
      if (user.getId() == userId) return true;
    }
    return false;
  }

  BlindDateTeam teamDtoToBlindDateTeam(RequestingTeam? rq) {
    return BlindDateTeam(
      id: rq?._teamId ?? 0,
      name: rq?._name ?? "(알수없음)",
      averageBirthYear: 0,
      regions: [],
      universityName: rq?._university?._name ?? "(알수없음)",
      isCertifiedTeam: rq?._isStudentIdCardVerified ?? false,
      teamUsers: rq?._teamUsers
              ?.map((user) => BlindDateUser(
                  id: user._userId ?? 0,
                  name: "(알수없음)",
                  profileImageUrl: user._profileImageUrl ?? "DEFAULT",
                  department: "(알수없음)"))
              .toList() ??
          [],
    );
  }

  int? get chatRoomId => _chatRoomId;

  set chatRoomId(int? chatRoomId) => _chatRoomId = chatRoomId;

  String? get latestChatMessageContent => _latestChatMessageContent;

  set latestChatMessageContent(String? latestChatMessageContent) =>
      _latestChatMessageContent = latestChatMessageContent;

  String? get latestChatMessageTime => _latestChatMessageTime;

  set latestChatMessageTime(String? latestChatMessageTime) => _latestChatMessageTime = latestChatMessageTime;

  RequestingTeam? get requestingTeam => _requestingTeam;

  set requestingTeam(RequestingTeam? requestingTeam) => _requestingTeam = requestingTeam;

  RequestingTeam? get requestedTeam => _requestedTeam;

  set requestedTeam(RequestingTeam? requestedTeam) => _requestedTeam = requestedTeam;

  ChatroomDto.fromJson(Map<String, dynamic> json) {
    _chatRoomId = json['chatRoomId'];
    _latestChatMessageContent = json['latestChatMessageContent'];
    _latestChatMessageTime = json['latestChatMessageTime'];
    _requestingTeam = json['requestingTeam'] != null ? RequestingTeam.fromJson(json['requestingTeam']) : null;
    _requestedTeam = json['requestedTeam'] != null ? RequestingTeam.fromJson(json['requestedTeam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = _chatRoomId;
    data['latestChatMessageContent'] = _latestChatMessageContent;
    data['latestChatMessageTime'] = _latestChatMessageTime;
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
    return 'ChatroomDto{_chatRoomId: $_chatRoomId, _latestChatMessageContent: $_latestChatMessageContent, _latestChatMessageTime: $_latestChatMessageTime, _requestingTeam: $_requestingTeam, _requestedTeam: $_requestedTeam}';
  }
}

class RequestingTeam {
  int? _teamId;
  String? _name;
  bool? _isStudentIdCardVerified;
  University? _university;
  List<TeamUsers>? _teamUsers;
  List<TeamRegions>? _teamRegions;

  RequestingTeam(
      {int? teamId,
      String? name,
      bool? isStudentIdCardVerified,
      University? university,
      List<TeamUsers>? teamUsers,
      List<TeamRegions>? teamRegions}) {
    if (teamId != null) {
      _teamId = teamId;
    }
    if (name != null) {
      _name = name;
    }
    if (isStudentIdCardVerified != null) {
      _isStudentIdCardVerified = isStudentIdCardVerified;
    }
    if (university != null) {
      _university = university;
    }
    if (teamUsers != null) {
      _teamUsers = teamUsers;
    }
    if (teamRegions != null) {
      _teamRegions = teamRegions;
    }
  }

  int? get teamId => _teamId;

  set teamId(int? teamId) => _teamId = teamId;

  String? get name => _name;

  set name(String? name) => _name = name;

  bool? get isStudentIdCardVerified => _isStudentIdCardVerified;

  set isStudentIdCardVerified(bool? isStudentIdCardVerified) => _isStudentIdCardVerified = isStudentIdCardVerified;

  University? get university => _university;

  set university(University? university) => _university = university;

  List<TeamUsers>? get teamUsers => _teamUsers;

  set teamUsers(List<TeamUsers>? teamUsers) => _teamUsers = teamUsers;

  List<TeamRegions>? get teamRegions => _teamRegions;

  set teamRegions(List<TeamRegions>? teamRegions) => _teamRegions = teamRegions;

  RequestingTeam.fromJson(Map<String, dynamic> json) {
    _teamId = json['teamId'];
    _name = json['name'];
    _isStudentIdCardVerified = json['isStudentIdCardVerified'];
    _university = json['university'] != null ? University.fromJson(json['university']) : null;
    if (json['teamUsers'] != null) {
      _teamUsers = <TeamUsers>[];
      json['teamUsers'].forEach((v) {
        _teamUsers!.add(TeamUsers.fromJson(v));
      });
    }
    if (json['teamRegions'] != null) {
      _teamRegions = <TeamRegions>[];
      json['teamRegions'].forEach((v) {
        _teamRegions!.add(TeamRegions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamId'] = _teamId;
    data['name'] = _name;
    data['isStudentIdCardVerified'] = _isStudentIdCardVerified;
    if (_university != null) {
      data['university'] = _university!.toJson();
    }
    if (_teamUsers != null) {
      data['teamUsers'] = _teamUsers!.map((v) => v.toJson()).toList();
    }
    if (_teamRegions != null) {
      data['teamRegions'] = _teamRegions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'RequestingTeam{_teamId: $_teamId, _name: $_name, _isStudentIdCardVerified: $_isStudentIdCardVerified, _university: $_university, _teamUsers: $_teamUsers, _teamRegions: $_teamRegions}';
  }
}

class University {
  int? _universityId;
  String? _name;

  University({int? universityId, String? name}) {
    if (universityId != null) {
      _universityId = universityId;
    }
    if (name != null) {
      _name = name;
    }
  }

  int? get universityId => _universityId;

  set universityId(int? universityId) => _universityId = universityId;

  String? get name => _name;

  set name(String? name) => _name = name;

  University.fromJson(Map<String, dynamic> json) {
    _universityId = json['universityId'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['universityId'] = _universityId;
    data['name'] = _name;
    return data;
  }

  @override
  String toString() {
    return 'University{_universityId: $_universityId, _name: $_name}';
  }
}

class TeamUsers {
  int? _userId;
  String? _profileImageUrl;

  TeamUsers({int? userId, String? profileImageUrl}) {
    if (userId != null) {
      _userId = userId;
    }
    if (profileImageUrl != null) {
      _profileImageUrl = profileImageUrl;
    }
  }

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  String? get profileImageUrl => _profileImageUrl;

  set profileImageUrl(String? profileImageUrl) => _profileImageUrl = profileImageUrl;

  TeamUsers.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = _userId;
    data['profileImageUrl'] = _profileImageUrl;
    return data;
  }
}

class TeamRegions {
  int? _regionId;
  String? _name;

  TeamRegions({int? regionId, String? name}) {
    if (regionId != null) {
      _regionId = regionId;
    }
    if (name != null) {
      _name = name;
    }
  }

  int? get regionId => _regionId;

  set regionId(int? regionId) => _regionId = regionId;

  String? get name => _name;

  set name(String? name) => _name = name;

  TeamRegions.fromJson(Map<String, dynamic> json) {
    _regionId = json['regionId'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionId'] = _regionId;
    data['name'] = _name;
    return data;
  }
}

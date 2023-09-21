import 'package:dart_flutter/src/common/chat/chat_connection.dart';
import 'package:dart_flutter/src/common/chat/message_sub.dart';
import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';

import '../../domain/entity/chat_message.dart';

class ChatroomDetailDto {
  int? _chatRoomId;
  String? _latestChatMessageContent;
  String? _latestChatMessageTime;
  RequestingTeam? _requestingTeam;
  RequestingTeam? _requestedTeam;

  ChatroomDetailDto({int? chatRoomId,
    String? latestChatMessageContent,
    String? latestChatMessageTime,
    RequestingTeam? requestingTeam,
    RequestingTeam? requestedTeam}) {
    if (chatRoomId != null) {
      this._chatRoomId = chatRoomId;
    }
    if (latestChatMessageContent != null) {
      this._latestChatMessageContent = latestChatMessageContent;
    }
    if (latestChatMessageTime != null) {
      this._latestChatMessageTime = latestChatMessageTime;
    }
    if (requestingTeam != null) {
      this._requestingTeam = requestingTeam;
    }
    if (requestedTeam != null) {
      this._requestedTeam = requestedTeam;
    }
  }

  ChatRoomDetail newChatRoomDetail(String baseUrl, int userId, Pagination<MessageSub> messages) {
    // find my team
    var tempTeamA = teamDtoToBlindDateTeam(requestingTeam);
    var tempTeamB = teamDtoToBlindDateTeam(requestedTeam);

    BlindDateTeamDetail myTeam;
    BlindDateTeamDetail otherTeam;
    if (isMyTeam(tempTeamA, userId)) {
      myTeam = tempTeamA;
      otherTeam = tempTeamB;
    } else {
      myTeam = tempTeamB;
      otherTeam = tempTeamA;
    }

    // set messages
    List<ChatMessage> chatMessages = messages.content?.map((msg) => ChatMessage(userId: msg.senderId, message: msg.content, sendTime: msg.createdTime)).toList() ?? [];

    // return
    return ChatRoomDetail(
      id: _chatRoomId ?? 0,
      myTeam: myTeam,
      otherTeam: otherTeam,
      messages: chatMessages,
      connection: ChatConnection(baseUrl, _chatRoomId ?? 0),
    );
  }

  bool isMyTeam(BlindDateTeamDetail team, int userId) {
    for (var user in team.teamUsers) {
      if (user.getId() == userId) return true;
    }
    return false;
  }

  BlindDateTeamDetail teamDtoToBlindDateTeam(RequestingTeam? rq) {
    var averageYear = getAverageAge(rq?._teamUsers?.map((user) => user._birthYear ?? 0).toList() ?? []);

    return BlindDateTeamDetail(
      id: rq?._teamId ?? 0,
      name: rq?._name ?? "(알수없음)",
      averageBirthYear: averageYear,
      regions: rq?._teamRegions?.map((region) => region.newLocation()).toList() ?? [],
      universityName: rq?._university?._name ?? "(알수없음)",
      isCertifiedTeam: rq?._isStudentIdCardVerified ?? false,
      teamUsers: rq?._teamUsers
          ?.map((user) =>
          BlindDateUserDetail(
              id: user._userId ?? 0,
              name: user._nickname ?? "(알수없음)",
              profileImageUrl: user._profileImageUrl ?? "DEFAULT",
              department: user._university?._department ?? "(알수없음)",
              isCertifiedUser: false,  //TODO 인증여부 서버에서 받아야함
              birthYear: user._birthYear ?? 0,
              profileQuestionResponses: [
              ]))
          .toList() ??
          [],
      proposalStatus: rq?._teamProposalStatus ?? true // TODO : 최현식
    );
  }

  int? get chatRoomId => _chatRoomId;

  set chatRoomId(int? chatRoomId) => _chatRoomId = chatRoomId;

  String? get latestChatMessageContent => _latestChatMessageContent;

  set latestChatMessageContent(String? latestChatMessageContent) =>
      _latestChatMessageContent = latestChatMessageContent;

  String? get latestChatMessageTime => _latestChatMessageTime;

  set latestChatMessageTime(String? latestChatMessageTime) =>
      _latestChatMessageTime = latestChatMessageTime;

  RequestingTeam? get requestingTeam => _requestingTeam;

  set requestingTeam(RequestingTeam? requestingTeam) =>
      _requestingTeam = requestingTeam;

  RequestingTeam? get requestedTeam => _requestedTeam;

  set requestedTeam(RequestingTeam? requestedTeam) =>
      _requestedTeam = requestedTeam;

  ChatroomDetailDto.fromJson(Map<String, dynamic> json) {
    _chatRoomId = json['chatRoomId'];
    _latestChatMessageContent = json['latestChatMessageContent'];
    _latestChatMessageTime = json['latestChatMessageTime'];
    _requestingTeam = json['requestingTeam'] != null
        ? new RequestingTeam.fromJson(json['requestingTeam'])
        : null;
    _requestedTeam = json['requestedTeam'] != null
        ? new RequestingTeam.fromJson(json['requestedTeam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatRoomId'] = this._chatRoomId;
    data['latestChatMessageContent'] = this._latestChatMessageContent;
    data['latestChatMessageTime'] = this._latestChatMessageTime;
    if (this._requestingTeam != null) {
      data['requestingTeam'] = this._requestingTeam!.toJson();
    }
    if (this._requestedTeam != null) {
      data['requestedTeam'] = this._requestedTeam!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ChatroomDetailDto{_chatRoomId: $_chatRoomId, _latestChatMessageContent: $_latestChatMessageContent, _latestChatMessageTime: $_latestChatMessageTime, _requestingTeam: $_requestingTeam, _requestedTeam: $_requestedTeam}';
  }
}

class RequestingTeam {
  int? _teamId;
  String? _name;
  bool? _isStudentIdCardVerified;
  University? _university;
  List<TeamUsers>? _teamUsers;
  List<TeamRegions>? _teamRegions;
  bool? _teamProposalStatus; // TODO : 최현식

  RequestingTeam({int? teamId,
    String? name,
    bool? isStudentIdCardVerified,
    University? university,
    List<TeamUsers>? teamUsers,
    List<TeamRegions>? teamRegions,
    bool? proposalStatus}) { // TODO : 최현식
    if (teamId != null) {
      this._teamId = teamId;
    }
    if (name != null) {
      this._name = name;
    }
    if (isStudentIdCardVerified != null) {
      this._isStudentIdCardVerified = isStudentIdCardVerified;
    }
    if (university != null) {
      this._university = university;
    }
    if (teamUsers != null) {
      this._teamUsers = teamUsers;
    }
    if (teamRegions != null) {
      this._teamRegions = teamRegions;
    }
    if (proposalStatus != null) { // TODO : 최현식
      this._teamProposalStatus = _teamProposalStatus;
    }
  }

  int? get teamId => _teamId;

  set teamId(int? teamId) => _teamId = teamId;

  String? get name => _name;

  set name(String? name) => _name = name;

  bool? get isStudentIdCardVerified => _isStudentIdCardVerified;

  set isStudentIdCardVerified(bool? isStudentIdCardVerified) =>
      _isStudentIdCardVerified = isStudentIdCardVerified;

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
    _university = json['university'] != null
        ? new University.fromJson(json['university'])
        : null;
    if (json['teamUsers'] != null) {
      _teamUsers = <TeamUsers>[];
      json['teamUsers'].forEach((v) {
        _teamUsers!.add(new TeamUsers.fromJson(v));
      });
    }
    if (json['teamRegions'] != null) {
      _teamRegions = <TeamRegions>[];
      json['teamRegions'].forEach((v) {
        _teamRegions!.add(new TeamRegions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamId'] = this._teamId;
    data['name'] = this._name;
    data['isStudentIdCardVerified'] = this._isStudentIdCardVerified;
    if (this._university != null) {
      data['university'] = this._university!.toJson();
    }
    if (this._teamUsers != null) {
      data['teamUsers'] = this._teamUsers!.map((v) => v.toJson()).toList();
    }
    if (this._teamRegions != null) {
      data['teamRegions'] = this._teamRegions!.map((v) => v.toJson()).toList();
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

class TeamUsers {
  int? _userId;
  String? _nickname;
  int? _birthYear;
  String? _profileImageUrl;
  University? _university;
  List<ProfileQuestions>? _profileQuestions;

  TeamUsers({int? userId,
    String? nickname,
    int? birthYear,
    String? profileImageUrl,
    University? university,
    List<ProfileQuestions>? profileQuestions}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (nickname != null) {
      this._nickname = nickname;
    }
    if (birthYear != null) {
      this._birthYear = birthYear;
    }
    if (profileImageUrl != null) {
      this._profileImageUrl = profileImageUrl;
    }
    if (university != null) {
      this._university = university;
    }
    if (profileQuestions != null) {
      this._profileQuestions = profileQuestions;
    }
  }

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  String? get nickname => _nickname;

  set nickname(String? nickname) => _nickname = nickname;

  int? get birthYear => _birthYear;

  set birthYear(int? birthYear) => _birthYear = birthYear;

  String? get profileImageUrl => _profileImageUrl;

  set profileImageUrl(String? profileImageUrl) =>
      _profileImageUrl = profileImageUrl;

  University? get university => _university;

  set university(University? university) => _university = university;

  List<ProfileQuestions>? get profileQuestions => _profileQuestions;

  set profileQuestions(List<ProfileQuestions>? profileQuestions) =>
      _profileQuestions = profileQuestions;

  TeamUsers.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _nickname = json['nickname'];
    _birthYear = json['birthYear'];
    _profileImageUrl = json['profileImageUrl'];
    _university = json['university'] != null
        ? new University.fromJson(json['university'])
        : null;
    if (json['profileQuestions'] != null) {
      _profileQuestions = <ProfileQuestions>[];
      json['profileQuestions'].forEach((v) {
        _profileQuestions!.add(new ProfileQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['nickname'] = this._nickname;
    data['birthYear'] = this._birthYear;
    data['profileImageUrl'] = this._profileImageUrl;
    if (this._university != null) {
      data['university'] = this._university!.toJson();
    }
    if (this._profileQuestions != null) {
      data['profileQuestions'] =
          this._profileQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'TeamUsers{_userId: $_userId, _nickname: $_nickname, _birthYear: $_birthYear, _profileImageUrl: $_profileImageUrl, _university: $_university, _profileQuestions: $_profileQuestions}';
  }
}

class ProfileQuestions {
  int? _profileQuestionId;
  Question? _question;
  int? _count;

  ProfileQuestions({int? profileQuestionId, Question? question, int? count}) {
    if (profileQuestionId != null) {
      this._profileQuestionId = profileQuestionId;
    }
    if (question != null) {
      this._question = question;
    }
    if (count != null) {
      this._count = count;
    }
  }

  int? get profileQuestionId => _profileQuestionId;

  set profileQuestionId(int? profileQuestionId) =>
      _profileQuestionId = profileQuestionId;

  Question? get question => _question;

  set question(Question? question) => _question = question;

  int? get count => _count;

  set count(int? count) => _count = count;

  ProfileQuestions.fromJson(Map<String, dynamic> json) {
    _profileQuestionId = json['profileQuestionId'];
    _question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileQuestionId'] = this._profileQuestionId;
    if (this._question != null) {
      data['question'] = this._question!.toJson();
    }
    data['count'] = this._count;
    return data;
  }
}

class Question {
  int? _questionId;
  String? _content;

  Question({int? questionId, String? content}) {
    if (questionId != null) {
      this._questionId = questionId;
    }
    if (content != null) {
      this._content = content;
    }
  }

  int? get questionId => _questionId;

  set questionId(int? questionId) => _questionId = questionId;

  String? get content => _content;

  set content(String? content) => _content = content;

  Question.fromJson(Map<String, dynamic> json) {
    _questionId = json['questionId'];
    _content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this._questionId;
    data['content'] = this._content;
    return data;
  }
}

class TeamRegions {
  int? _regionId;
  String? _name;

  TeamRegions({int? regionId, String? name}) {
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

  Location newLocation() {
    return Location(id: _regionId ?? 0, name: _name ?? "(알수없음)");
  }

  TeamRegions.fromJson(Map<String, dynamic> json) {
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

double getAverageAge(List<int> userAges) {
  var validAges = userAges.where((age) => age != 0);

  if (validAges.isEmpty) {
    return 0.0;
  }

  var sum = validAges.reduce((value, element) => value + element);

  return sum / validAges.length;
}

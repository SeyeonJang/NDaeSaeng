import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'vote.g.dart';

@JsonSerializable()
class VoteRequest {
  int? userId, voteId;
  int? pickUserId, firstUserId, secondUserId, ThirdUserId, FourthUserId;
  final Question question;

  VoteRequest(
      {required this.userId,
      required this.voteId,
      required this.pickUserId,
      required this.firstUserId,
      required this.secondUserId,
      required this.ThirdUserId,
      required this.FourthUserId,
      required this.question});

  VoteRequest.from(Map<String, dynamic> json)
  : userId = json['userId'],
    voteId = json['voteId'],
    pickUserId = json['pickUserId'],
    firstUserId = json['firstUserId'],
    secondUserId = json['secondUserId'],
    ThirdUserId = json['ThirdUserId'],
    FourthUserId = json['FourthUserId'],
    question = json['question'];

  VoteRequest.fromVoteResponse(VoteResponse voteResponse)
  : userId = voteResponse.userId,
    voteId = voteResponse.voteId,
    question = voteResponse.question;

  Map<String, dynamic> toJson() => _$VoteRequestToJson(this);
  static VoteRequest fromJson(Map<String, dynamic> json) => _$VoteRequestFromJson(json);
}

@JsonSerializable()
class VoteResponse {
  final int userId, voteId;
  final int pickUserAdmissionNumber;
  final String pickUserSex;
  final Hint hint;
  final Question question;
  final DateTime pickedAt;

  VoteResponse(
      {required this.userId,
      required this.voteId,
      required this.pickUserAdmissionNumber,
      required this.pickUserSex,
      required this.hint,
      required this.question,
      required this.pickedAt});

  VoteResponse.from(Map<String, dynamic> json)
  : userId = json['userId'],
    voteId = json['voteId'],
    pickUserAdmissionNumber = json['pickUserAdmissionNumber'],
    pickUserSex = json['pickUserSex'],
    hint = json['hint'],
    question = json['question'],
    pickedAt = json['pickedAt'];

  Map<String, dynamic> toJson() => _$VoteResponseToJson(this);
  static VoteResponse fromJson(Map<String, dynamic> json) => _$VoteResponseFromJson(json);
}

@JsonSerializable()
class Question {
  final int questionId;
  final String div1, div2, question;

  Question(
      {required this.questionId,
      required this.div1,
      required this.div2,
      required this.question});

  Question.from(Map<String, dynamic> json)
  : questionId = json['questionId'],
    div1 = json['div1'],
    div2 = json['div2'],
    question = json['question'];

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
  static Question fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}

@JsonSerializable()
class Hint {
  final int voteId;
  final String hint1;
  final String hint2;
  final String hint3;
  final String hint4;
  final String hint5;

  Hint(
      {required this.voteId,
      required this.hint1,
      required this.hint2,
      required this.hint3,
      required this.hint4,
      required this.hint5});

  Hint.from(Map<String, dynamic> json)
  : voteId = json['voteId'],
    hint1 = json['hint1'],
    hint2 = json['hint2'],
    hint3 = json['hint3'],
    hint4 = json['hint4'],
    hint5 = json['hint5'];

  Map<String, dynamic> toJson() => _$HintToJson(this);
  static Hint fromJson(Map<String, dynamic> json) => _$HintFromJson(json);
}

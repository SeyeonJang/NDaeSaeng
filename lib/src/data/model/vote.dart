import 'dart:core';

import 'package:dart_flutter/src/data/model/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vote.g.dart';

@JsonSerializable()
class VoteRequest {
  int questionId;
  int pickUserId, firstUserId, secondUserId, thirdUserId, fourthUserId;

  VoteRequest(
      {required this.pickUserId,
      required this.firstUserId,
      required this.secondUserId,
      required this.thirdUserId,
      required this.fourthUserId,
      required this.questionId});

  VoteRequest.from(Map<String, dynamic> json)
  : pickUserId = json['pickUserId'],
    firstUserId = json['firstUserId'],
    secondUserId = json['secondUserId'],
    thirdUserId = json['ThirdUserId'],
    fourthUserId = json['FourthUserId'],
    questionId = json['questionId'];

  Map<String, dynamic> toJson() => _$VoteRequestToJson(this);
  static VoteRequest fromJson(Map<String, dynamic> json) => _$VoteRequestFromJson(json);

  @override
  String toString() {
    return 'VoteRequest{questionId: $questionId, pickUserId: $pickUserId, firstUserId: $firstUserId, secondUserId: $secondUserId, thirdUserId: $thirdUserId, fourthUserId: $fourthUserId}';
  }
}

@JsonSerializable()
class VoteResponse {
  final int userId, voteId;
  final int pickUserAdmissionNumber;
  final String pickUserSex;
  final Question question;
  final DateTime pickedAt;

  VoteResponse(
      {required this.userId,
      required this.voteId,
      required this.pickUserAdmissionNumber,
      required this.pickUserSex,
      required this.question,
      required this.pickedAt});

  VoteResponse.from(Map<String, dynamic> json)
  : userId = json['userId'],
    voteId = json['voteId'],
    pickUserAdmissionNumber = json['pickUserAdmissionNumber'],
    pickUserSex = json['pickUserSex'],
    question = json['question'],
    pickedAt = json['pickedAt'];

  Map<String, dynamic> toJson() => _$VoteResponseToJson(this);
  static VoteResponse fromJson(Map<String, dynamic> json) => _$VoteResponseFromJson(json);
}

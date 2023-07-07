import 'dart:core';

import 'package:dart_flutter/src/data/model/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vote.g.dart';

@JsonSerializable()
class VoteRequest {
  int questionId;
  int pickedUserId, firstUserId, secondUserId, thirdUserId, fourthUserId;

  VoteRequest(
      {required this.pickedUserId,
      required this.firstUserId,
      required this.secondUserId,
      required this.thirdUserId,
      required this.fourthUserId,
      required this.questionId});

  VoteRequest.from(Map<String, dynamic> json)
  : pickedUserId = json['pickedUserId'],
    firstUserId = json['firstUserId'],
    secondUserId = json['secondUserId'],
    thirdUserId = json['ThirdUserId'],
    fourthUserId = json['FourthUserId'],
    questionId = json['questionId'];

  Map<String, dynamic> toJson() => _$VoteRequestToJson(this);
  static VoteRequest fromJson(Map<String, dynamic> json) => _$VoteRequestFromJson(json);

  @override
  String toString() {
    return 'VoteRequest{questionId: $questionId, pickedUserId: $pickedUserId, firstUserId: $firstUserId, secondUserId: $secondUserId, thirdUserId: $thirdUserId, fourthUserId: $fourthUserId}';
  }
}

class VoteResponse {
  int? voteId;
  Question? question;
  PickedUser? pickedUser;
  DateTime? pickedTime;

  VoteResponse({this.voteId, this.question, this.pickedUser, this.pickedTime});

  VoteResponse.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    pickedUser = json['pickedUser'] != null
        ? new PickedUser.fromJson(json['pickedUser'])
        : null;
    pickedTime = DateTime.parse(json['pickedTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voteId'] = this.voteId;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    if (this.pickedUser != null) {
      data['pickedUser'] = this.pickedUser!.toJson();
    }
    data['pickedTime'] = this.pickedTime?.toIso8601String();
    return data;
  }

  @override
  String toString() {
    return 'VoteResponse{voteId: $voteId, question: $question, pickedUser: $pickedUser, pickedTime: $pickedTime}';
  }
}

class PickedUser {
  int? userId;
  int? universityId;
  String? name;
  String? phone;
  String? gender;
  String? universityName;
  String? department;
  Null? nextVoteDateTime;

  PickedUser(
      {this.userId,
        this.universityId,
        this.name,
        this.phone,
        this.gender,
        this.universityName,
        this.department,
        this.nextVoteDateTime});

  PickedUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    universityId = json['universityId'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    universityName = json['universityName'];
    department = json['department'];
    nextVoteDateTime = json['nextVoteDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['universityId'] = this.universityId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['universityName'] = this.universityName;
    data['department'] = this.department;
    data['nextVoteDateTime'] = this.nextVoteDateTime;
    return data;
  }
}

import 'dart:core';

import 'package:dart_flutter/src/data/model/question.dart';
import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/data/model/user.dart';
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
    question = json['question'] != null ? Question.fromJson(json['question']) : null;
    pickedUser = json['pickedUser'] != null ? PickedUser.fromJson(json['pickedUser']) : null;
    pickedTime = DateTime.parse(json['pickedTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['voteId'] = voteId;
    if (question != null) {
      data['question'] = question!.toJson();
    }
    if (pickedUser != null) {
      data['pickedUser'] = pickedUser!.toJson();
    }
    data['pickedTime'] = pickedTime?.toIso8601String();
    return data;
  }

  @override
  String toString() {
    return 'VoteResponse{voteId: $voteId, question: $question, pickedUser: $pickedUser, pickedTime: $pickedTime}';
  }
}

class PickedUser {
  User? user;
  University? university;

  PickedUser({this.user, this.university});

  PickedUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    university = json['university'] != null ? University.fromJson(json['university']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'PickedUser{user: $user, university: $university}';
  }
}

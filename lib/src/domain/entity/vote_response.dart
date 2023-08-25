
import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';

class VoteResponse {
  int? voteId;
  Question? question;
  PickingUser? pickingUser;
  DateTime? pickedTime;

  VoteResponse({this.voteId, this.question, this.pickingUser, this.pickedTime});

  VoteResponse.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null ? Question.fromJson(json['question']) : null;
    pickingUser = json['pickingUser'] != null ? PickingUser.fromJson(json['pickingUser']) : null;
    pickedTime = DateTime.parse(json['pickedTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['voteId'] = voteId;
    if (question != null) {
      data['question'] = question!.toJson();
    }
    if (pickingUser != null) {
      data['pickingUser'] = pickingUser!.toJson();
    }
    data['pickedTime'] = pickedTime?.toIso8601String();
    return data;
  }

  @override
  String toString() {
    return 'VoteResponse{voteId: $voteId, question: $question, pickingUser: $pickingUser, pickedTime: $pickedTime}';
  }
}

class PickingUser {
  PersonalInfo? user;
  University? university;

  PickingUser({this.user, this.university});

  PickingUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? PersonalInfo.fromJson(json['user']) : null;
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
    return 'PickingUser{user: $user, university: $university}';
  }
}


import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class VoteResponse {
  int? voteId;
  Question? question;
  _PickedUser? pickedUser;
  DateTime? pickedTime;

  VoteResponse({this.voteId, this.question, this.pickedUser, this.pickedTime});

  VoteResponse.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null ? Question.fromJson(json['question']) : null;
    pickedUser = json['pickedUser'] != null ? _PickedUser.fromJson(json['pickedUser']) : null;
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

class _PickedUser {
  User? user;
  University? university;

  _PickedUser({this.user, this.university});

  _PickedUser.fromJson(Map<String, dynamic> json) {
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

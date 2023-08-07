import 'package:dart_flutter/src/data/model/question_dto.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';

class VoteResponseDto {
  int? voteId;
  QuestionDto? question;
  _PickedUser? pickedUser;
  DateTime? pickedTime;

  VoteResponseDto({this.voteId, this.question, this.pickedUser, this.pickedTime});

  VoteResponseDto.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null ? QuestionDto.fromJson(json['question']) : null;
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
  UserDto? user;
  UniversityDto? university;

  _PickedUser({this.user, this.university});

  _PickedUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    university = json['university'] != null ? UniversityDto.fromJson(json['university']) : null;
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

import 'package:dart_flutter/src/data/model/question_dto.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';

class VoteResponseDto {
  int? voteId;
  QuestionDto? question;
  _PickingUserDto? pickingUser;
  DateTime? pickedTime;

  VoteResponseDto({this.voteId, this.question, this.pickingUser, this.pickedTime});

  VoteResponseDto.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null ? QuestionDto.fromJson(json['question']) : null;
    pickingUser = json['pickingUser'] != null ? _PickingUserDto.fromJson(json['pickingUser']) : null;
    pickedTime = DateTime.parse(json['pickedTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

  VoteResponse newVoteResponse() {
    return VoteResponse(
      voteId: voteId,
      question: question?.newQuestion(),
      pickingUser: pickingUser?.newPickedUser(),
      pickedTime: pickedTime,
    );
  }

  @override
  String toString() {
    return 'VoteResponse{voteId: $voteId, question: $question, pickingUser: $pickingUser, pickedTime: $pickedTime}';
  }
}

class _PickingUserDto {
  PersonalInfoDto? user;
  UniversityDto? university;

  _PickingUserDto();

  _PickingUserDto.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? PersonalInfoDto.fromJson(json['user']) : null;
    university = json['university'] != null ? UniversityDto.fromJson(json['university']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    return data;
  }

  PickingUser newPickedUser() {
    return PickingUser(
      user: user?.newUser(),
      university: university?.newUniversity(),
    );
  }

  @override
  String toString() {
    return 'PickingUser{user: $user, university: $university}';
  }
}

import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:dart_flutter/src/data/model/question_dto.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';

class VoteDetailDto {
  int? voteId;
  QuestionDto? question;
  _PickingUserDto? pickingUser;
  DateTime? pickedTime;
  List<UserDto>? candidates;

  VoteDetailDto({this.voteId, this.question, this.pickingUser, this.pickedTime, this.candidates});

  VoteDetailDto.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null ? QuestionDto.fromJson(json['question']) : null;
    pickingUser = json['pickingUser'] != null ? _PickingUserDto.fromJson(json['pickingUser']) : null;
    pickedTime = DateTime.parse(json['pickedTime']);
    if (json['candidates'] != null) {
      candidates = [];
      if (json['candidates'] is List) {
        json['candidates'].forEach((v) {
          candidates!.add(UserDto.fromJson(v));
        });
      }
    }
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
    data['pickedTime'] = pickedTime?.toString();
    if (candidates != null) {
      data['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  VoteDetail newVoteDetail() {
    return VoteDetail(
      voteId: voteId,
      question: question?.newQuestion(),
      pickingUser: pickingUser?.newPickedUser(),
      pickedTime: pickedTime,
      candidates: candidates?.map((userDto) => userDto.newUser()).toList() ?? [],
    );
  }

  @override
  String toString() {
    return 'VoteDetailDto{voteId: $voteId, question: $question, pickingUser: $pickingUser, pickedTime: $pickedTime, candidates: $candidates}';
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

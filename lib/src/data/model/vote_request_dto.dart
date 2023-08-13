import 'dart:core';

import 'package:dart_flutter/src/domain/entity/vote_request.dart';

class VoteRequestDto {
  late int questionId;
  late int pickedUserId, firstUserId, secondUserId, thirdUserId, fourthUserId;

  VoteRequestDto(
      {required this.pickedUserId,
      required this.firstUserId,
      required this.secondUserId,
      required this.thirdUserId,
      required this.fourthUserId,
      required this.questionId});

  VoteRequestDto.from(Map<String, dynamic> json)
      : pickedUserId = json['pickedUserId'],
        firstUserId = json['firstUserId'],
        secondUserId = json['secondUserId'],
        thirdUserId = json['ThirdUserId'],
        fourthUserId = json['FourthUserId'],
        questionId = json['questionId'];

  VoteRequestDto.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    pickedUserId = json['pickedUserId'];
    firstUserId = json['firstUserId'];
    secondUserId = json['secondUserId'];
    thirdUserId = json['thirdUserId'];
    fourthUserId = json['fourthUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['pickedUserId'] = this.pickedUserId;
    data['firstUserId'] = this.firstUserId;
    data['secondUserId'] = this.secondUserId;
    data['thirdUserId'] = this.thirdUserId;
    data['fourthUserId'] = this.fourthUserId;
    return data;
  }

  VoteRequest newVoteRequest() {
    return VoteRequest(
      questionId: questionId,
      pickedUserId: pickedUserId,
      firstUserId: firstUserId,
      secondUserId: secondUserId,
      thirdUserId: thirdUserId,
      fourthUserId: fourthUserId,
    );
  }

  static VoteRequestDto fromVoteRequest(VoteRequest voteRequest) {
    return VoteRequestDto(
        questionId: voteRequest.questionId,
        pickedUserId: voteRequest.pickedUserId,
        firstUserId: voteRequest.firstUserId,
        secondUserId: voteRequest.secondUserId,
        thirdUserId: voteRequest.thirdUserId,
        fourthUserId: voteRequest.fourthUserId
    );
  }

  @override
  String toString() {
    return 'VoteRequest{questionId: $questionId, pickedUserId: $pickedUserId, firstUserId: $firstUserId, secondUserId: $secondUserId, thirdUserId: $thirdUserId, fourthUserId: $fourthUserId}';
  }
}

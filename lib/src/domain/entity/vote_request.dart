import 'dart:core';

import 'package:dart_flutter/src/data/model/vote_request_dto.dart';

class VoteRequest {
  late int questionId;
  late int pickedUserId, firstUserId, secondUserId, thirdUserId, fourthUserId;

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

  VoteRequest.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'VoteRequest{questionId: $questionId, pickedUserId: $pickedUserId, firstUserId: $firstUserId, secondUserId: $secondUserId, thirdUserId: $thirdUserId, fourthUserId: $fourthUserId}';
  }
}

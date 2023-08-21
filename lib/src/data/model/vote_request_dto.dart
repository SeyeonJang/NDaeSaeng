import 'dart:core';

import 'package:dart_flutter/src/domain/entity/vote_request.dart';

class VoteRequestDto {
  late int questionId;
  late int pickedUserId;
  late List<int> candidateIds;

  VoteRequestDto(
      {required this.pickedUserId,
        required this.candidateIds,
      required this.questionId});

  // VoteRequestDto.from(Map<String, dynamic> json)
  //     : pickedUserId = json['pickedUserId'],
  //       candidateIds = json['candidateIds'],
  //       questionId = json['questionId'];
  //
  // VoteRequestDto.fromJson(Map<String, dynamic> json) {
  //   questionId = json['questionId'];
  //   pickedUserId = json['pickedUserId'];
  //   firstUserId = json['firstUserId'];
  //   secondUserId = json['secondUserId'];
  //   thirdUserId = json['thirdUserId'];
  //   fourthUserId = json['fourthUserId'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['pickedUserId'] = this.pickedUserId;
    data['candidateIds'] = this.candidateIds;
    return data;
  }

  VoteRequest newVoteRequest() {
    return VoteRequest(
      questionId: questionId,
      pickedUserId: pickedUserId,
      firstUserId: candidateIds[0],
      secondUserId: candidateIds[1],
      thirdUserId: candidateIds[2],
      fourthUserId: candidateIds[3],
    );
  }

  static VoteRequestDto fromVoteRequest(VoteRequest voteRequest) {
    return VoteRequestDto(
        questionId: voteRequest.questionId,
        pickedUserId: voteRequest.pickedUserId,
        candidateIds: [voteRequest.firstUserId, voteRequest.secondUserId, voteRequest.thirdUserId, voteRequest.fourthUserId]
    );
  }

  @override
  String toString() {
    return 'VoteRequestDto{questionId: $questionId, pickedUserId: $pickedUserId, candidateIds: $candidateIds}';
  }
}

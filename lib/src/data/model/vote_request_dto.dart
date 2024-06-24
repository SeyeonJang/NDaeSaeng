import 'dart:core';

import 'package:dart_flutter/src/domain/entity/vote_request.dart';

class VoteRequestDto {
  late int questionId;
  late int pickedUserId;
  late List<int?> candidateIds;

  VoteRequestDto(
      {required this.pickedUserId,
        required this.candidateIds,
      required this.questionId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['pickedUserId'] = pickedUserId;
    data['candidateIds'] = candidateIds;
    return data;
  }

  VoteRequest newVoteRequest() {
    return VoteRequest(
      questionId: questionId,
      pickedUserId: pickedUserId,
      firstUserId: candidateIds[0] ?? 0,
      secondUserId: candidateIds[1] ?? 0,
      thirdUserId: candidateIds[2] ?? 0,
      fourthUserId: candidateIds[3] ?? 0,
    );
  }

  static VoteRequestDto fromVoteRequest(VoteRequest voteRequest) {
    int? firstUserId = voteRequest.firstUserId == 0 ? null : voteRequest.firstUserId;
    int? secondUserId = voteRequest.secondUserId == 0 ? null : voteRequest.secondUserId;
    int? thirdUserId = voteRequest.thirdUserId == 0 ? null : voteRequest.thirdUserId;
    int? fourthUserId = voteRequest.fourthUserId == 0 ? null : voteRequest.fourthUserId;

    return VoteRequestDto(
        questionId: voteRequest.questionId,
        pickedUserId: voteRequest.pickedUserId,
        candidateIds: [firstUserId, secondUserId, thirdUserId, fourthUserId]
        // candidateIds: [voteRequest.firstUserId, voteRequest.secondUserId, voteRequest.thirdUserId, voteRequest.fourthUserId]
    );
  }

  @override
  String toString() {
    return 'VoteRequestDto{questionId: $questionId, pickedUserId: $pickedUserId, candidateIds: $candidateIds}';
  }
}

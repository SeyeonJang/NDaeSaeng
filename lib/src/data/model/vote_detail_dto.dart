import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/data/model/vote_response_dto.dart';
import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/data/model/vote_response_dto.dart';
import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class VoteDetailDto {
  VoteResponseDto? voteResponse;
  List<UserDto>? candidates;

  VoteDetailDto({this.voteResponse, this.candidates});

  VoteDetailDto.fromJson(Map<String, dynamic> json) {
    voteResponse = json['voteResponse'] != null ? VoteResponseDto.fromJson(json['voteResponse']) : null;

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
    if (voteResponse != null) {
      data['voteResponse'] = voteResponse!.toJson();
    }
    if (candidates != null) {
      data['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  VoteDetail newVoteDetail() {
    return VoteDetail(
      voteResponse: voteResponse?.newVoteResponse(),
      candidates: candidates?.map((userDto) => userDto.newUser()).toList() ?? [],
    );
  }

  @override
  String toString() {
    return 'VoteDetailDto{voteResponse: $voteResponse, candidates: $candidates}';
  }
}

import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class VoteDetailDto {
  VoteResponse? voteResponse;
  List<User>? candidates;

  VoteDetailDto({this.voteResponse, this.candidates});

  VoteDetailDto.fromJson(Map<String, dynamic> json) {
    voteResponse = json['voteResponse'] != null ? VoteResponse.fromJson(json['voteResponse']) : null;
    if (json['candidates'] != null) {
      candidates = [];
      if (json['candidates'] is List) {
        json['candidates'].forEach((v) {
          candidates!.add(User.fromJson(v));
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
      voteResponse: voteResponse,
      candidates: candidates
    );
  }

  @override
  String toString() {
    return 'VoteDetailDto{voteResponse: $voteResponse, candidates: $candidates}';
  }
}
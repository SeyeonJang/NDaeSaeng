import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class VoteDetail {
  VoteResponse? voteResponse;
  late List<User> candidates;

  VoteDetail({this.voteResponse, required this.candidates});

  VoteDetail.fromJson(Map<String, dynamic> json) {
    voteResponse = json['voteResponse'] != null ? VoteResponse.fromJson(json['voteResponse']) : null;
    candidates = (json['candidates'] as List<dynamic>).map((e) => User.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (voteResponse != null) {
      data['voteResponse'] = voteResponse!.toJson();
    }
    data['candidates'] = candidates!.map((candidates) => candidates.toJson());
    return data;
  }
}
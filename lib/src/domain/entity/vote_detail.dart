import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class VoteDetail {
  int? voteId;
  Question? question;
  PickingUser? pickingUser;
  DateTime? pickedTime;
  late List<User> candidates;

  VoteDetail({this.voteId, this.question, this.pickingUser, this.pickedTime, required this.candidates});

  VoteDetail.fromJson(Map<String, dynamic> json) {
    voteId = json['voteId'];
    question = json['question'] != null ? Question.fromJson(json['question']) : null;
    pickingUser = json['pickingUser'] != null ? PickingUser.fromJson(json['pickingUser']) : null;
    pickedTime = DateTime.parse(json['pickedTime']);
    candidates = (json['candidates'] as List<dynamic>).map((e) => User.fromJson(e)).toList();
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
    data['candidates'] = candidates.map((candidates) => candidates.toJson());
    return data;
  }

  @override
  String toString() {
    return 'VoteDetail{voteId: $voteId, question: $question, pickingUser: $pickingUser, pickedTime: $pickedTime, candidates: $candidates}';
  }
}
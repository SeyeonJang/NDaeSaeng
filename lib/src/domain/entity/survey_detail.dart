import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';

class SurveyDetail {
  final int id;
  final String question;
  final List<Option> options;
  final bool picked;
  final int pickedOption;
  final DateTime createdAt;
  final String latestComment;
  final List<Comment> comments;

  SurveyDetail({
    required this.id,
    required this.question,
    required this.options,
    required this.picked,
    required this.pickedOption,
    required this.createdAt,
    required this.latestComment,
    required this.comments,
  });

  factory SurveyDetail.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedQuestion = json['question'];

    List<Option> parsedOptions = [];
    if (json['options'] != null) {
      var optionsList = json['options'] as List<dynamic>;
      parsedOptions = optionsList.map((v) => Option.fromJson(v)).toList();
    }

    final bool parsedPicked = json['picked'];
    final int parsedPickedOption = json['pickedOption'];
    final DateTime parsedCreatedAt = json['createdAt'];
    final String parsedLatestComment = json['latestComment'];

    List<Comment> parsedComments = [];
    if (json['comments'] != null) {
      var commentsList = json['comments'] as List<dynamic>;
      parsedComments = commentsList.map((v) => Comment.fromJson(v)).toList();
    }

    return SurveyDetail(
        id: parsedId,
        question: parsedQuestion,
        options: parsedOptions,
        picked: parsedPicked,
        pickedOption: parsedPickedOption,
        createdAt: parsedCreatedAt,
        latestComment: parsedLatestComment,
        comments: parsedComments,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['picked'] = picked;
    data['pickedOption'] = pickedOption;
    data['createdAt'] = createdAt;
    data['latestComment'] = latestComment;
    return data;
  }

  @override
  String toString() {
    return 'SurveyDetail{id: $id, question: $question, options: $options, picked: $picked, pickedOption: $pickedOption, createdAt: $createdAt, latestComment: $latestComment, comments: $comments}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyDetail &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  bool isPicked() {
    if (picked == true) {
      return true;
    } else {
      return false;
    }
  }
}
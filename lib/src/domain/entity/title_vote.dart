import 'package:dart_flutter/src/domain/entity/question.dart';

class TitleVote {
  Question question;
  int count;

  TitleVote._internal({
    required this.question,
    required this.count,
  });

  factory TitleVote({
    Question? question,
    int? count,
  }) {
    return TitleVote._internal(
      question: question ?? Question(questionId: 0, content: "", icon: ""),
      count: count ?? 0,
    );
  }

  static TitleVote fromJson(Map<String, dynamic> json) {
    return TitleVote(
      question: Question.fromJson(json['question']),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return 'TitleVote{question: $question, count: $count}';
  }
}

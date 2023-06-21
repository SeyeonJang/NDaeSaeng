// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteResponse _$VoteResponseFromJson(Map<String, dynamic> json) => VoteResponse(
      userId: json['userId'] as int,
      voteId: json['voteId'] as int,
      pickUserAdmissionNumber: json['pickUserAdmissionNumber'] as int,
      pickUserSex: json['pickUserSex'] as String,
      hint: Hint.fromJson(json['hint'] as Map<String, dynamic>),
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
      pickedAt: DateTime.parse(json['pickedAt'] as String),
    );

Map<String, dynamic> _$VoteResponseToJson(VoteResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'voteId': instance.voteId,
      'pickUserAdmissionNumber': instance.pickUserAdmissionNumber,
      'pickUserSex': instance.pickUserSex,
      'hint': instance.hint,
      'question': instance.question,
      'pickedAt': instance.pickedAt.toIso8601String(),
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      questionId: json['questionId'] as int,
      div1: json['div1'] as String,
      div2: json['div2'] as String,
      question: json['question'] as String,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionId': instance.questionId,
      'div1': instance.div1,
      'div2': instance.div2,
      'question': instance.question,
    };

Hint _$HintFromJson(Map<String, dynamic> json) => Hint(
      voteId: json['voteId'] as int,
      hint1: json['hint1'] as String,
      hint2: json['hint2'] as String,
      hint3: json['hint3'] as String,
      hint4: json['hint4'] as String,
      hint5: json['hint5'] as String,
    );

Map<String, dynamic> _$HintToJson(Hint instance) => <String, dynamic>{
      'voteId': instance.voteId,
      'hint1': instance.hint1,
      'hint2': instance.hint2,
      'hint3': instance.hint3,
      'hint4': instance.hint4,
      'hint5': instance.hint5,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteRequest _$VoteRequestFromJson(Map<String, dynamic> json) => VoteRequest(
      pickUserId: json['pickUserId'] as int,
      firstUserId: json['firstUserId'] as int,
      secondUserId: json['secondUserId'] as int,
      thirdUserId: json['thirdUserId'] as int,
      fourthUserId: json['fourthUserId'] as int,
      questionId: json['questionId'] as int,
    );

Map<String, dynamic> _$VoteRequestToJson(VoteRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'pickUserId': instance.pickUserId,
      'firstUserId': instance.firstUserId,
      'secondUserId': instance.secondUserId,
      'thirdUserId': instance.thirdUserId,
      'fourthUserId': instance.fourthUserId,
    };

VoteResponse _$VoteResponseFromJson(Map<String, dynamic> json) => VoteResponse(
      userId: json['userId'] as int,
      voteId: json['voteId'] as int,
      pickUserAdmissionNumber: json['pickUserAdmissionNumber'] as int,
      pickUserSex: json['pickUserSex'] as String,
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
      pickedAt: DateTime.parse(json['pickedAt'] as String),
    );

Map<String, dynamic> _$VoteResponseToJson(VoteResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'voteId': instance.voteId,
      'pickUserAdmissionNumber': instance.pickUserAdmissionNumber,
      'pickUserSex': instance.pickUserSex,
      'question': instance.question,
      'pickedAt': instance.pickedAt.toIso8601String(),
    };

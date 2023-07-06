// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteRequest _$VoteRequestFromJson(Map<String, dynamic> json) => VoteRequest(
      pickedUserId: json['pickedUserId'] as int,
      firstUserId: json['firstUserId'] as int,
      secondUserId: json['secondUserId'] as int,
      thirdUserId: json['thirdUserId'] as int,
      fourthUserId: json['fourthUserId'] as int,
      questionId: json['questionId'] as int,
    );

Map<String, dynamic> _$VoteRequestToJson(VoteRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'pickedUserId': instance.pickedUserId,
      'firstUserId': instance.firstUserId,
      'secondUserId': instance.secondUserId,
      'thirdUserId': instance.thirdUserId,
      'fourthUserId': instance.fourthUserId,
    };

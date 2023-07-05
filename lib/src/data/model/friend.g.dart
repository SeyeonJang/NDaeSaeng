// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      userId: json['userId'] as int,
      admissionNumber: json['admissionNum'] as int,
      mutualFriend: json['mutualFriend'] as int? ?? 0,
      name: json['name'] as String,
      university:
          University.fromJson(json['university'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'userId': instance.userId,
      'admissionNumber': instance.admissionNumber,
      'mutualFriend': instance.mutualFriend,
      'name': instance.name,
      'university': instance.university,
    };

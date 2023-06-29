// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      userId: json['friendUserId'] as int,
      admissionNumber: json['admissionNum'] as int,
      mutualFriend: json['mutualFriend'] as int? ?? 0,
      name: json['friendName'] as String,
      university: University(id: 100, name: 'xxxxxx', department: '홍삼학과'),
      // university:
      //     University.fromJson(json['university'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'userId': instance.userId,
      'admissionNumber': instance.admissionNumber,
      'mutualFriend': instance.mutualFriend,
      'name': instance.name,
      'university': instance.university,
    };

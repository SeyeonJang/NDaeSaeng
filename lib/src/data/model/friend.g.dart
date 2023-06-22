// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      userId: json['userId'] as int,
      university:
          University.fromJson(json['university'] as Map<String, dynamic>),
      admissionNumber: json['admissionNumber'] as int,
      mutualFriend: json['mutualFriend'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      signUp: json['signUp'] as bool,
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'userId': instance.userId,
      'university': instance.university,
      'admissionNumber': instance.admissionNumber,
      'mutualFriend': instance.mutualFriend,
      'name': instance.name,
      'phone': instance.phone,
      'signUp': instance.signUp,
    };

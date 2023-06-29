import 'package:dart_flutter/src/data/model/university.dart';
import 'package:json_annotation/json_annotation.dart';
part 'friend.g.dart';

@JsonSerializable()
class Friend {
  final int userId;
  final int admissionNumber;
  final int mutualFriend;
  final String name;
  final University university;

  Friend({
    required this.userId,
    required this.admissionNumber,
    this.mutualFriend = 0,
    required this.name,
    required this.university,
  });

  Map<String, dynamic> toJson() => _$FriendToJson(this);
  static Friend fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  @override
  String toString() {
    return 'Friend{userId: $userId, admissionNumber: $admissionNumber, mutualFriend: $mutualFriend, name: $name, university: $university}';
  }
}

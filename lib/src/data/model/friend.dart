import 'package:dart_flutter/src/data/model/university.dart';

class Friend {
  final int userId;
  final University university;
  final int admissionNumber, mutualFriend;
  final String name, phone;
  final bool signUp;

  Friend(
      {required this.userId,
      required this.university,
      required this.admissionNumber,
      required this.mutualFriend,
      required this.name,
      required this.phone,
      required this.signUp});

  Friend.from(Map<String, dynamic> json)
      : userId = json['userId'],
        university = University.fromJson(json),
        admissionNumber = json['admissionNumber'],
        mutualFriend = json['mutualFriend'],
        name = json['name'],
        phone = json['phone'],
        signUp = json['signUp'];
}

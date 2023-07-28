import 'package:dart_flutter/src/data/model/university.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'user.g.dart';

class UserResponse {
  User? user;
  University? university;

  UserResponse({this.user, this.university});

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    university = json['university'] != null
        ? University.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? gender;
  int? admissionYear;
  int? birthYear;
  String? recommendationCode;

  User({this.id,
        this.name,
        this.phone,
        this.gender,
        this.admissionYear,
        this.recommendationCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    admissionYear = json['admissionYear'];
    birthYear = json['birthYear'];
    recommendationCode = json['recommendationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['admissionYear'] = admissionYear;
    data['birthYear'] = birthYear;
    data['recommendationCode'] = recommendationCode;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, phone: $phone, gender: $gender, admissionYear: $admissionYear, birthYear: $birthYear, recommendationCode: $recommendationCode}';
  }
}

//
// @JsonSerializable()
// class UserResponse {
//   final int? userId, univId;
//   final int? admissionNumber, point;
//   final String? name, phone;
//   final String? universityName, department;
//   final DateTime? nextVoteDateTime;
//
//   UserResponse({
//     required this.userId,
//     required this.univId,
//     required this.admissionNumber,
//     required this.point,
//     required this.name,
//     required this.phone,
//     required this.universityName,
//     required this.department,
//     required this.nextVoteDateTime
//   });
//
//   UserResponse.from(Map<String, dynamic> json)
//   : userId = json['userId'],
//     univId = json['universityId'],
//     admissionNumber = json['admissionNumber'],
//     point = json['point'],
//     name = json['name'],
//     phone = json['phone'],
//     universityName = json['universityName'],
//     department = json['department'],
//     nextVoteDateTime = json['nextVoteDateTime'];
//
//   Map<String, dynamic> toJson() => _$UserResponseToJson(this);
//   static UserResponse fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
//
//   @override
//   String toString() {
//     return 'UserResponse{userId: $userId, univId: $univId, admissionNumber: $admissionNumber, point: $point, name: $name, phone: $phone, universityName: $universityName, department: $department, nextVoteDateTime: $nextVoteDateTime}';
//   }
// }

class UserRequest {
  final int univId;
  final int admissionYear, birthYear;
  final String name, phone, gender;

  UserRequest({
    required this.univId,
    required this.admissionYear,
    required this.birthYear,
    required this.name,
    required this.phone,
    required this.gender
  });

  UserRequest.from(Map<String, dynamic> json)
  : univId = json['univId'],
    admissionYear = json['admissionYear'],
    birthYear = json['birthYear'],
    name = json['name'],
    phone = json['phone'],
    gender = json['gender'];

  Map<String, dynamic> toJson() {
    return {
      'universityId': univId,
      'admissionYear': admissionYear,
      'birthYear': birthYear,
      'name': name,
      'phone': phone,
      'gender': gender
    };
  }

  @override
  String toString() {
    return 'UserRequest{univId: $univId, admissionYear: $admissionYear, birthYear: $birthYear, name: $name, phone: $phone, gender: $gender}';
  }
}

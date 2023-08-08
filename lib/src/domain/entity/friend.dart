import 'package:dart_flutter/src/domain/entity/university.dart';

class Friend {
  int? userId;
  String? name;
  int? admissionYear;
  String? gender;
  University? university;

  Friend({this.userId, this.name, this.admissionYear, this.gender, this.university});

  Friend.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    admissionYear = json['admissionYear'];
    university = json['university'] != null
        ? University.fromJson(json['university'])
        : null;
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['name'] = name;
    data['admissionYear'] = admissionYear;
    if (university != null) {
      data['university'] = university!.toJson();
    }
    data['gender'] = gender;
    return data;
  }

  @override
  bool operator == (Object other) {
    if (userId == (other as Friend).userId) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'Friend{userId: $userId, name: $name, gender: $gender, admissionYear: $admissionYear, university: $university}';
  }
}

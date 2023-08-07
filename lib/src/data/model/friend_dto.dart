import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';

class FriendDto {
  int? userId;
  String? name;
  int? admissionYear;
  String? gender;
  UniversityDto? university;

  FriendDto({this.userId, this.name, this.admissionYear, this.gender, this.university});

  FriendDto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    admissionYear = json['admissionYear'];
    university = json['university'] != null
        ? UniversityDto.fromJson(json['university'])
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

  Friend newFriend() {
    return Friend(
      userId: userId,
      name: name,
      admissionYear: admissionYear,
      gender: gender,
      university: university?.newUniversity(),
    );
  }

  @override
  bool operator == (Object other) {
    if (userId == (other as FriendDto).userId) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'Friend{userId: $userId, name: $name, gender: $gender, admissionYear: $admissionYear, university: $university}';
  }
}

import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:flutter/foundation.dart';

@immutable
class User {
  final int id;
  final String name;
  final String nickname;
  final String profileImageUrl;
  final IdCardVerificationStatus verification;
  final String phone;
  final String gender;
  final int admissionYear;
  final int birthYear;
  final String recommendationCode;
  final int point;

  const User({required this.id,
      required this.name,
      required this.nickname,
      required this.profileImageUrl,
      required this.verification,
      required this.phone,
      required this.gender,
      required this.birthYear,
      required this.admissionYear,
      required this.recommendationCode,
      required this.point});

  User copyWith({
    int? id, String? name, String? nickname, String? profileImageUrl, IdCardVerificationStatus? verification, String? phone, String? gender, int? admissionYear, int? birthYear, String? recommendationCode, int? point
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      verification: verification ?? this.verification,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      admissionYear: admissionYear ?? this.admissionYear,
      birthYear: birthYear ?? this.birthYear,
      recommendationCode: recommendationCode ?? this.recommendationCode,
      point: point ?? this.point
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      profileImageUrl: json['profileImageUrl'],
      verification: json['verification'],
      phone: json['phone'],
      gender: json['gender'],
      admissionYear: json['admissionYear'],
      birthYear: json['birthYear'],
      recommendationCode: json['recommendationCode'],
      point: json['point'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['nickname'] = nickname;
    data['profileImageUrl'] = profileImageUrl;
    data['verification'] = verification;
    data['phone'] = phone;
    data['gender'] = gender;
    data['admissionYear'] = admissionYear;
    data['birthYear'] = birthYear;
    data['recommendationCode'] = recommendationCode;
    data['point'] = point;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, nickname: $nickname, profileUrl: $profileImageUrl, verification: $verification, phone: $phone, gender: $gender, admissionYear: $admissionYear, birthYear: $birthYear, recommendationCode: $recommendationCode, point: $point}';
  }
}

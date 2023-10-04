import 'package:dart_flutter/src/common/util/nickname_dict_util.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';

import '../../domain/entity/personal_info.dart';

class PersonalInfoDto {
  int? id;
  String? name;
  String? nickname;
  String? profileImageUrl;
  String? studentIdCardVerificationStatus;
  String? phone;
  String? gender;
  int? admissionYear;
  int? birthYear;
  String? recommendationCode;
  int? point;

  PersonalInfoDto({this.id,
        this.name,
        this.nickname,
        this.profileImageUrl,
        this.studentIdCardVerificationStatus,
        this.phone,
        this.gender,
        this.birthYear,
        this.admissionYear,
        this.recommendationCode,
        this.point});

  PersonalInfoDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    studentIdCardVerificationStatus = json['studentIdCardVerificationStatus'];
    phone = json['phone'];
    gender = json['gender'];
    admissionYear = json['admissionYear'];
    birthYear = json['birthYear'];
    recommendationCode = json['recommendationCode'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['nickname'] = nickname;
    data['profileImageUrl'] = profileImageUrl;
    data['studentIdCardVerificationStatus'] = studentIdCardVerificationStatus;
    data['phone'] = phone;
    data['gender'] = gender;
    data['admissionYear'] = admissionYear;
    data['birthYear'] = birthYear;
    data['recommendationCode'] = recommendationCode;
    data['point'] = point;
    return data;
  }

  PersonalInfo newUser() {
    return PersonalInfo(
        id: id ?? 0,
        name: name ?? NicknameDictUtil.getRandomNickname(maxLength: 4),
        nickname: nickname ?? "",
        profileImageUrl: profileImageUrl ?? "DEFAULT",
        verification: IdCardVerificationStatus.fromValue(studentIdCardVerificationStatus),
        phone: phone ?? "01000000000",
        gender: gender ?? "UNKNOWN",
        admissionYear: admissionYear ?? 0000,
        birthYear: birthYear ?? 0000,
        recommendationCode: recommendationCode ?? "내 코드가 없습니다",
        point: point ?? 0,
    );
  }

  static PersonalInfoDto fromUser(PersonalInfo user) {
    return PersonalInfoDto(
      id: user.id,
      name: user.name,
      nickname: user.nickname,
      profileImageUrl: user.profileImageUrl,
      studentIdCardVerificationStatus: user.verification.toValue(),
      phone: user.phone,
      gender: user.gender,
      admissionYear: user.admissionYear,
      birthYear: user.birthYear,
      recommendationCode: user.recommendationCode,
      point: user.point,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, nickname: $nickname, profileImageUrl: $profileImageUrl, verification: $studentIdCardVerificationStatus, phone: $phone, gender: $gender, admissionYear: $admissionYear, birthYear: $birthYear, recommendationCode: $recommendationCode, point: $point}';
  }
}

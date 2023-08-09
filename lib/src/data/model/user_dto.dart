import '../../domain/entity/user.dart';

class UserDto {
  int? id;
  String? name;
  String? nickname;
  String? profileImageUrl;
  String? verification;
  String? phone;
  String? gender;
  int? admissionYear;
  int? birthYear;
  String? recommendationCode;
  int? point;

  UserDto({this.id,
        this.name,
        this.nickname,
        this.profileImageUrl,
        this.verification,
        this.phone,
        this.gender,
        this.birthYear,
        this.admissionYear,
        this.recommendationCode,
        this.point});

  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    verification = json['verification'];
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
    data['verification'] = verification;
    data['phone'] = phone;
    data['gender'] = gender;
    data['admissionYear'] = admissionYear;
    data['birthYear'] = birthYear;
    data['recommendationCode'] = recommendationCode;
    data['point'] = point;
    return data;
  }

  User newUser() {
    return User(
        id: id ?? 0,
        name: name ?? "(알수없음)",
        nickname: nickname ?? "",
        profileImageUrl: profileImageUrl ?? "",
        verification: verification ?? "인증전",
        phone: phone ?? "01000000000",
        gender: gender ?? "UNKNOWN",
        admissionYear: admissionYear ?? 0000,
        birthYear: birthYear ?? 0000,
        recommendationCode: recommendationCode ?? "내 코드가 없습니다",
        point: point ?? 0,
    );
  }

  static UserDto fromUser(User user) {
    return UserDto(
      id: user.id,
      name: user.name,
      nickname: user.nickname,
      profileImageUrl: user.profileImageUrl,
      verification: user.verification,
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
    return 'User{id: $id, name: $name, nickname: $nickname, profileImageUrl: $profileImageUrl, verification: $verification, phone: $phone, gender: $gender, admissionYear: $admissionYear, birthYear: $birthYear, recommendationCode: $recommendationCode, point: $point}';
  }
}

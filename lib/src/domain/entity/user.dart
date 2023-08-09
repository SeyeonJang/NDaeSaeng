class User {
  final int id;
  final String name;
  final String nickname;
  final String profileImageUrl;
  final String verification;
  final String phone;
  final String gender;
  final int admissionYear;
  final int birthYear;
  final String recommendationCode;
  final int point;

  User({required this.id,
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

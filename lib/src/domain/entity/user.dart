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
        this.birthYear,
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

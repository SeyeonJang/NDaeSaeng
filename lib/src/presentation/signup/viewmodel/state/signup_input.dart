import 'package:dart_flutter/src/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_input.g.dart';

@JsonSerializable()
class SignupInput {
  String? name;
  String? phone;
  int? admissionNumber;
  int? univId;
  String? tempUnivName;
  String? tempUnivDepartment;
  // String? gender;
  Gender? gender;

  Map<String, dynamic> toJson() => _$SignupInputToJson(this);
  static SignupInput fromJson(Map<String, dynamic> json) => _$SignupInputFromJson(json);
  UserRequest toUserRequest() => UserRequest(
    name: name!,
    phone: phone!,
    admissionNumber: admissionNumber!,
    univId: univId!,
  );

  @override
  String toString() {
    return 'SignupInput{name: $name, phone: $phone, admissionNumber: $admissionNumber, univId: $univId, tempUnivName: $tempUnivName, tempUnivDepartment: $tempUnivDepartment, gender: $gender}';
  }
}

enum Gender {
  male, female
}

extension GenderExtension on Gender {
  static const MALE_WORD = 'M';
  static const FEMALE_WORD = 'F';

  String get word {
    switch (this) {
      case Gender.male:
        return MALE_WORD;
      case Gender.female:
        return FEMALE_WORD;
    }
  }

  static Gender from(String word) {
    switch (word) {
      case MALE_WORD:
        return Gender.male;
      case FEMALE_WORD:
        return Gender.female;
      default:
        throw Exception("Invalid gender word");
    }
  }
}

import 'package:dart_flutter/src/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_input.g.dart';

@JsonSerializable()
class SignupInput {
  String? name;
  String? phone;
  int? admissionNumber;
  int? birthYear;
  int? univId;
  String? tempUnivName;
  String? tempUnivDepartment;
  String? gender;
  // Gender? gender;

  Map<String, dynamic> toJson() => _$SignupInputToJson(this);
  static SignupInput fromJson(Map<String, dynamic> json) => _$SignupInputFromJson(json);
  UserRequest toUserRequest() => UserRequest(
    name: name!,
    phone: phone!,
    admissionYear: admissionNumber!,
    birthYear: birthYear!,
    univId: univId!,
    gender: gender!,
  );

  @override
  String toString() {
    return 'SignupInput{name: $name, phone: $phone, admissionNumber: $admissionNumber, birthYear: $birthYear, univId: $univId, tempUnivName: $tempUnivName, tempUnivDepartment: $tempUnivDepartment, gender: $gender}';
  }
}

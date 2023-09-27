import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/state/signup_input.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_state.g.dart';

@JsonSerializable()
class SignupState {
  late bool isLoading;
  late SignupInput inputState;
  late List<University> universities;
  late SignupStep signupStep;
  late String loginType;
  late String memo;

  SignupState({
    required this.isLoading,
    required this.inputState,
    required this.universities,
    required this.signupStep,
    required this.loginType,
    required this.memo,
  });

  SignupState.init() {
    isLoading = false;
    inputState = SignupInput();
    universities = [];
    signupStep = SignupStep.school;
    loginType = "email";
    memo = "";
  }

  SignupState copy() => SignupState(
    isLoading: isLoading,
    inputState: inputState,
    universities: universities,
    signupStep: signupStep,
    loginType: loginType,
    memo: memo,
  );

  Map<String, dynamic> toJson() => _$SignupStateToJson(this);
  SignupState fromJson(Map<String, dynamic> json) => _$SignupStateFromJson(json);

  @override
  String toString() {
    return 'SignupState{isLoading: $isLoading, inputState: $inputState, universities: ${universities.length}개, signupStep: $signupStep}';
  }
}

enum SignupStep {
  school, department, admissionNumber, name, phone, validatePhone, gender;

  bool get isSchool => this == SignupStep.school;
  bool get isDepartment => this == SignupStep.department;
  bool get isAdmissionNumber => this == SignupStep.admissionNumber;
  bool get isName => this == SignupStep.name;
  bool get isPhone => this == SignupStep.phone;
  bool get isValidatePhone => this == SignupStep.validatePhone;
  bool get isGender => this == SignupStep.gender;
}

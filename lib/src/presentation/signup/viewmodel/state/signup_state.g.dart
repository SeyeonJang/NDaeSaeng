// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupState _$SignupStateFromJson(Map<String, dynamic> json) => SignupState(
      isLoading: json['isLoading'] as bool,
      inputState:
          SignupInput.fromJson(json['inputState'] as Map<String, dynamic>),
      universities: (json['universities'] as List<dynamic>)
          .map((e) => University.fromJson(e as Map<String, dynamic>))
          .toList(),
      signupStep: $enumDecode(_$SignupStepEnumMap, json['signupStep']),
      loginType: json['loginType'] as String,
      memo: json['memo'] as String,
    );

Map<String, dynamic> _$SignupStateToJson(SignupState instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'inputState': instance.inputState,
      'universities': instance.universities,
      'signupStep': _$SignupStepEnumMap[instance.signupStep]!,
      'loginType': instance.loginType,
      'memo': instance.memo,
    };

const _$SignupStepEnumMap = {
  SignupStep.school: 'school',
  SignupStep.department: 'department',
  SignupStep.admissionNumber: 'admissionNumber',
  SignupStep.name: 'name',
  SignupStep.phone: 'phone',
  SignupStep.validatePhone: 'validatePhone',
  SignupStep.gender: 'gender',
};

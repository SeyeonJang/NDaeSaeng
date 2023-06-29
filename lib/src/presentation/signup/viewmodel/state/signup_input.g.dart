// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupInput _$SignupInputFromJson(Map<String, dynamic> json) => SignupInput()
  ..name = json['name'] as String?
  ..phone = json['phone'] as String?
  ..admissionNumber = json['admissionNumber'] as int?
  ..univId = json['univId'] as int?
  ..tempUnivName = json['tempUnivName'] as String?
  ..tempUnivDepartment = json['tempUnivDepartment'] as String?
  ..gender = $enumDecodeNullable(_$GenderEnumMap, json['gender']);

Map<String, dynamic> _$SignupInputToJson(SignupInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'admissionNumber': instance.admissionNumber,
      'univId': instance.univId,
      'tempUnivName': instance.tempUnivName,
      'tempUnivDepartment': instance.tempUnivDepartment,
      'gender': _$GenderEnumMap[instance.gender],
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

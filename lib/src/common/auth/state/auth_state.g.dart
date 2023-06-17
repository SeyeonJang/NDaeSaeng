// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      isLoading: json['isLoading'] as bool,
      step: $enumDecode(_$AuthStepEnumMap, json['step']),
      socialAccessToken: json['socialAccessToken'] as String,
      expiredAt: DateTime.parse(json['expiredAt'] as String),
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'isLoading': instance.isLoading,
      'step': _$AuthStepEnumMap[instance.step]!,
      'socialAccessToken': instance.socialAccessToken,
      'expiredAt': instance.expiredAt.toIso8601String(),
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
    };

const _$AuthStepEnumMap = {
  AuthStep.land: 'land',
  AuthStep.signup: 'signup',
  AuthStep.login: 'login',
};

const _$LoginTypeEnumMap = {
  LoginType.kakao: 'kakao',
  LoginType.apple: 'apple',
  LoginType.email: 'email',
};

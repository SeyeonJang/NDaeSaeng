// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dart_auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DartAuthState _$AuthStateFromJson(Map<String, dynamic> json) => DartAuthState(
      isLoading: json['isLoading'] as bool,
      step: $enumDecode(_$AuthStepEnumMap, json['step']),
      dartAccessToken: json['dartAccessToken'] as String,
      socialAccessToken: json['socialAccessToken'] as String,
      expiredAt: DateTime.parse(json['expiredAt'] as String),
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
      memo: json['memo'] as String,
      tutorialStatus: $enumDecode(_$TutorialStateEnumMap, json['tutorialStatus']),
      appVersionStatus: $enumDecode(_$AppVersionStateEnumMap, json['appVersionStatus']),
      appUpdateComment: json['appUpdateComment'] as String,
);

Map<String, dynamic> _$AuthStateToJson(DartAuthState instance) => <String, dynamic>{
      'isLoading': instance.isLoading,
      'step': _$AuthStepEnumMap[instance.step]!,
      'dartAccessToken': instance.dartAccessToken,
      'socialAccessToken': instance.socialAccessToken,
      'expiredAt': instance.expiredAt.toIso8601String(),
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'memo': instance.memo,
      'tutorialStatus':  _$TutorialStateEnumMap[instance.tutorialStatus]!,
      'appVersionStatus':  _$AppVersionStateEnumMap[instance.appVersionStatus]!,
      'appUpdateComment': instance.appUpdateComment
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

const _$TutorialStateEnumMap = {
  TutorialStatus.shown: 'shown',
  TutorialStatus.notShown: 'notShown',
};

const _$AppVersionStateEnumMap = {
  AppVersionStatus.latest: 'latest',
  AppVersionStatus.update: 'update',
  AppVersionStatus.mustUpdate: 'mustUpdate',
};

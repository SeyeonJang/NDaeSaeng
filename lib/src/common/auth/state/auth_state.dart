import 'package:json_annotation/json_annotation.dart';
part 'auth_state.g.dart';

enum LoginType {
  kakao, apple, email;
}

enum AuthStep {
  land, signup, login;
}

enum AppVersionStatus {
  latest, update, mustUpdate;

  bool get isLatest => this == AppVersionStatus.latest;
  bool get isUpdate => this == AppVersionStatus.update;
  bool get isMustUpdate => this == AppVersionStatus.mustUpdate;
}

enum TutorialStatus {
  notShown,
  shown,
}

@JsonSerializable()
class AuthState {
  bool isLoading;
  AuthStep step;
  String dartAccessToken;
  String socialAccessToken;
  DateTime expiredAt;
  LoginType loginType;
  String memo;
  TutorialStatus tutorialStatus;
  AppVersionStatus appVersionStatus;
  String appUpdateComment;

  AuthState({
    required this.isLoading,
    required this.step,
    required this.dartAccessToken,
    required this.socialAccessToken,
    required this.expiredAt,
    required this.loginType,
    required this.memo,
    required this.tutorialStatus,
    required this.appVersionStatus,
    required this.appUpdateComment,
  });

  AuthState setDartAuth({
    required String dartAccessToken,
    required DateTime expiredAt,
  }) {
    this.dartAccessToken = dartAccessToken;
    this.expiredAt = expiredAt;
    return this;
  }

  AuthState setSocialAuth({
    required LoginType loginType,
    required String socialAccessToken,
  }) {
    this.loginType = loginType;
    this.socialAccessToken = socialAccessToken;
    return this;
  }

  AuthState setStep(AuthStep step) {
    this.step = step;
    return this;
  }

  AuthState setMemo(String memo) {
    this.memo = memo;
    return this;
  }

  AuthState setLoading(bool boolean) {
    isLoading = boolean;
    return this;
  }

  AuthState setTutorialStatus(TutorialStatus status) {
    tutorialStatus = status;
    return this;
  }

  AuthState setAppVersionStatus(AppVersionStatus status) {
    appVersionStatus = status;
    return this;
  }

  AuthState copy() => AuthState(
    isLoading: isLoading,
    step: step,
    dartAccessToken: dartAccessToken,
    socialAccessToken: socialAccessToken,
    expiredAt: expiredAt,
    loginType: loginType,
    memo: memo,
    tutorialStatus: tutorialStatus,
    appVersionStatus: appVersionStatus,
    appUpdateComment: appUpdateComment,
  );

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
  AuthState fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  @override
  String toString() {
    return 'AuthState{isLoading: $isLoading, step: $step, dartAccessToken: $dartAccessToken, socialAccessToken: $socialAccessToken, expiredAt: $expiredAt, loginType: $loginType, tutorialStatus: $tutorialStatus, appVersionStatus: $appVersionStatus, appUpdateComment: $appUpdateComment}';
  }
}

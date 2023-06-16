enum LoginType {
  kakao, apple, email;
}

enum AuthStep {
  land, signup, login;
}

class AuthState {
  bool isLoading;
  AuthStep step;
  String socialAccessToken;
  DateTime expiredAt;
  LoginType loginType;

  AuthState({
    required this.isLoading,
    required this.step,
    required this.socialAccessToken,
    required this.expiredAt,
    required this.loginType
  });

  AuthState setSocialAuth({
    required LoginType loginType,
    required String socialAccessToken,
    required DateTime expiredAt,
  }) {
    this.loginType = loginType;
    this.socialAccessToken = socialAccessToken;
    this.expiredAt = expiredAt;
    return this;
  }

  AuthState setStep(AuthStep step) {
    this.step = step;
    return this;
  }

  AuthState setLoading(bool boolean) {
    isLoading = boolean;
    return this;
  }

  AuthState copy() => AuthState(
    isLoading: isLoading,
    step: step,
    socialAccessToken: socialAccessToken,
    expiredAt: expiredAt,
    loginType: loginType,
  );

  @override
  String toString() {
    return 'AuthState{isLoading: $isLoading, step: $step, accessToken: $socialAccessToken, expiredAt: $expiredAt, loginType: $loginType}';
  }
}

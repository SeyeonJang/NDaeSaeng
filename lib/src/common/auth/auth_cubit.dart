import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/data/model/dart_auth.dart';
import 'package:dart_flutter/src/data/model/kakao_user.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  static final KakaoLoginRepository _kakaoLoginRepository = KakaoLoginRepository();
  static final DartAuthRepository _authRepository = DartAuthRepository();
  static final DartUserRepository _userRepository = DartUserRepository();

  AuthCubit()
      : super(AuthState(
          isLoading: false,
          step: AuthStep.land,
          dartAccessToken: '',
          socialAccessToken: '',
          expiredAt: DateTime.now().add(const Duration(days: 30)),
          loginType: LoginType.email,
        ));

  Future<void> kakaoLogout() async {
    try {
      await _kakaoLoginRepository.logout();
      // 로그아웃 성공 후 처리할 로직 추가
      print("로그아웃 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('로그아웃 실패: $error');
    }

    state.setStep(AuthStep.land).setSocialAuth(loginType: LoginType.email, socialAccessToken: "");
    emit(state.copy());
  }

  Future<void> kakaoWithdrawal() async {
    try {
      await _kakaoLoginRepository.withdrawal();
      await _userRepository.drawal();
      // 로그아웃 성공 후 처리할 로직 추가
      print("회원탈퇴 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('회원탈퇴 실패: $error');
    }

    state.setStep(AuthStep.land);
    emit(state.copy());
  }

  void kakaoLogin() async {
    // loading 상태로 만든다.
    emit(state.setLoading(true).copy());

    // 카카오 로그인 진행
    KakaoUser kakaoUser = await _kakaoLoginRepository.loginWithKakaoTalk();

    // Dart 서버 로그인 진행
    DartAuth dartAuth = await _authRepository.loginWithKakao(kakaoUser.accessToken);
    state
        .setDartAuth(dartAccessToken: dartAuth.accessToken, expiredAt: DateTime.now().add(const Duration(days: 10)))
        .setSocialAuth(loginType: LoginType.kakao, socialAccessToken: kakaoUser.accessToken);

    // Dart 내 정보를 확인해서 이미 가입한 사용자인지 확인
    UserResponse userResponse = await _userRepository.myInfo();
    if (userResponse.univId == null) {
      state.setStep(AuthStep.signup);
    } else {
      state.setStep(AuthStep.login);
    }
    print(state.toString());

    state.setLoading(false);
    emit(state.copy());
  }

  void doneSignup() {
    state.setStep(AuthStep.login);
    print(state);
    emit(state.copy());
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) => state.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthState state) => state.toJson();
}

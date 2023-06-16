import 'package:dart_flutter/src/common/auth/auth_state.dart';
import 'package:dart_flutter/src/data/model/kakao_user.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  static final KakaoLoginRepository _kakaoLoginRepository = KakaoLoginRepository();
  static final DartAuthRepository _authRepository = DartAuthRepository();

  AuthCubit()
      : super(AuthState(
          isLoading: false,
          step: AuthStep.land,
          socialAccessToken: '',
          expiredAt: DateTime.now().add(const Duration(days: 30)),
          loginType: LoginType.email,
        ));

  void kakaoLogin() async {
    // loading 상태로 만든다.
    emit(state.setLoading(true).copy());
    print(state);

    // 대기
    await Future.delayed(const Duration(seconds: 3));
    // 카카오 로그인 진행
    KakaoUser kakaoUser = await _kakaoLoginRepository.loginWithKakaoTalk();

    // Dart 서버 로그인 진행
    // _authRepository.loginWithKakao(kakaoUser.accessToken);

    // 정보 등록
    emit(state
        .setSocialAuth(
            loginType: LoginType.kakao,
            socialAccessToken: kakaoUser.accessToken,
            expiredAt: DateTime.now().add(const Duration(days: 30)))
        .setStep(AuthStep.signup)
        .setLoading(false)
        .copy());
    print(state);
  }
}

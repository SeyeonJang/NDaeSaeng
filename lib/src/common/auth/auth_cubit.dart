import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/data/model/kakao_user.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  static final KakaoLoginRepository _kakaoLoginRepository = KakaoLoginRepository();
  static final DartAuthRepository _authRepository = DartAuthRepository();

  AuthCubit()
      : super(AuthState(
          isLoading: false,
          step: AuthStep.land,
          dartAccessToken: '',
          socialAccessToken: '',
          expiredAt: DateTime.now().add(const Duration(days: 30)),
          loginType: LoginType.email,
        ));

  void kakaoLogout() async {
    try {
      await _kakaoLoginRepository.logout();
      // 로그아웃 성공 후 처리할 로직 추가
      print("로그아웃 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('로그아웃 실패: $error');
    }

    emit(state.setStep(AuthStep.land));
  }

  void kakaoWithdrawal() async {
    try {
      await _kakaoLoginRepository.withdrawal();
      // 로그아웃 성공 후 처리할 로직 추가
      print("회원탈퇴 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('회원탈퇴 실패: $error');
    }

    emit(state.setStep(AuthStep.land));
  }

  void kakaoLogin() async {
    // loading 상태로 만든다.
    emit(state.setLoading(true).copy());
    print(state.toJson());

    // 대기
    await Future.delayed(const Duration(seconds: 3));

    // 카카오 로그인 진행
    KakaoUser kakaoUser = await _kakaoLoginRepository.loginWithKakaoTalk();

    // TODO Dart 서버 로그인 진행
    // DartAuth dartAuth = await _authRepository.loginWithKakao(kakaoUser.accessToken);
    // if (dartAuth) ... state.setDartAuth(dartAccessToken: ----, expiredAt: ----).setStep(AuthStep.login).setLoading(false).copy();

    // 정보 등록
    state.setSocialAuth(
        loginType: LoginType.kakao,
        socialAccessToken: kakaoUser.accessToken,
        )
        .setStep(AuthStep.signup)
        .setLoading(false);
    emit(state.copy());
  }

  void testLogin() {
    state.setStep(AuthStep.signup);
    emit(state.copy());
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) => state.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthState state) => state.toJson();
}

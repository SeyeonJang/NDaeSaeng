import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/push_notification_util.dart';
import 'package:dart_flutter/src/data/model/dart_auth.dart';
import 'package:dart_flutter/src/data/model/kakao_user.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:dart_flutter/src/data/repository/apple_login_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../datasource/dart_api_remote_datasource.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  static final KakaoLoginRepository _kakaoLoginRepository = KakaoLoginRepository();
  static final AppleLoginRepository _appleLoginRepository = AppleLoginRepository();
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
          memo: '',
          tutorialStatus: TutorialStatus.notShown
        ));

  void setLandPage() {
    if (state.step == AuthStep.signup) {
      state.setStep(AuthStep.land);
    }
    state.setLoading(false);
  }

  void setAccessToken(String accessToken) {
    DartApiRemoteDataSource.addAuthorizationToken(accessToken);
  }

  Future<AuthState> kakaoLogout() async {
    try {
      await _kakaoLoginRepository.logout();
      _userRepository.logout();
      // 로그아웃 성공 후 처리할 로직 추가
      print("로그아웃 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('로그아웃 실패: $error');
    }

    final newState = state.setStep(AuthStep.land).setSocialAuth(loginType: LoginType.email, socialAccessToken: "").copy();
    emit(newState);
    return newState;
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
    state.setLoading(true);
    print(state.toString());
    emit(state.copy());

    try {
      KakaoUser kakaoUser = await _kakaoLoginRepository.loginWithKakaoTalk();
      DartAuth dartAuth = await _authRepository.loginWithKakao(kakaoUser.accessToken);
      state
          .setDartAuth(dartAccessToken: dartAuth.accessToken, expiredAt: DateTime.now().add(const Duration(days: 10)))
          .setSocialAuth(loginType: LoginType.kakao, socialAccessToken: kakaoUser.accessToken);

      UserResponse userResponse = await _userRepository.myInfo();

      String userId = userResponse.user!.id!.toString();
      AnalyticsUtil.setUserId(userId);
      if (userResponse.user?.name == null) {
        PushNotificationUtil.setUserId(userId);
        state.setStep(AuthStep.signup);
      } else {
        state.setStep(AuthStep.login);
      }
    }
    catch (e, stackTrace) {
      print("login error: $e, $stackTrace");
      throw Error();
    } finally {
      state.setLoading(false);
      emit(state.copy());
    }
  }

  void appleLogin() async {
    // loading 상태로 만든다.
    state.setLoading(true);
    emit(state.copy());

    final appleUser = await _appleLoginRepository.login();
    print(appleUser.toString());
    print(appleUser.authorizationCode);
    print(appleUser.identityToken);

    try {
      DartAuth dartAuth = await _authRepository.loginWithApple(appleUser.identityToken!);
      state
          .setDartAuth(dartAccessToken: dartAuth.accessToken, expiredAt: DateTime.now().add(const Duration(days: 10)))
          .setSocialAuth(loginType: LoginType.apple, socialAccessToken: appleUser.authorizationCode)
          .setMemo('${appleUser.familyName ?? "오"}${appleUser.givenName ?? "늘"}');

      UserResponse userResponse = await _userRepository.myInfo();

      String userId = userResponse.user!.id!.toString();
      AnalyticsUtil.setUserId(userId);
      if (userResponse.user?.name == null) {
        PushNotificationUtil.setUserId(userId);
        state.setStep(AuthStep.signup);
      } else {
        state.setStep(AuthStep.login);
      }
    }
    catch (e, stackTrace) {
      print("login error: $e, $stackTrace");
      throw Error();
    } finally {
      state.setLoading(false);
      emit(state.copy());
    }
    print(state.toString());
  }

  void doneSignup() {
    state.setStep(AuthStep.login);
    print(state);
    emit(state.copy());
  }

  void markTutorialShown() { // 온보딩 튜토리얼
    state.setTutorialStatus(TutorialStatus.shown);
    emit(state.copy());
    print('shown으로 변경');
    print(state.copy());
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) => state.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthState state) => state.toJson();
}


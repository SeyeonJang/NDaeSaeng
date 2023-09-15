import 'package:dart_flutter/src/common/auth/state/dart_auth_state.dart';
import 'package:dart_flutter/src/common/chat/chat_connection.dart';
import 'package:dart_flutter/src/common/exception/authroization_exception.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/push_notification_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/common/util/version_comparator.dart';
import 'package:dart_flutter/src/domain/entity/kakao_user.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/app_platform_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/auth_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';

import '../../data/datasource/dart_api_remote_datasource.dart';
import '../../domain/entity/dart_auth.dart';

class DartAuthCubit extends HydratedCubit<DartAuthState> {
  static final AppPlatformUseCase _appPlatformUseCase = AppPlatformUseCase();
  static final AuthUseCase _authUseCase = AuthUseCase();
  static final UserUseCase _userUseCase = UserUseCase();

  DartAuthCubit()
      : super(DartAuthState(
          isLoading: false,
          step: AuthStep.land,
          dartAccessToken: '',
          socialAccessToken: '',
          expiredAt: DateTime.now().add(const Duration(days: 30)),
          loginType: LoginType.email,
          memo: '',
          tutorialStatus: TutorialStatus.notShown,
          appVersionStatus: AppVersionStatus.latest,
          appUpdateComment: '',
        ));

  void setLandPage() {
    if (state.step == AuthStep.signup) {
      state.setStep(AuthStep.land);
    }
    state.setLoading(false);
  }

  void appVersionCheck() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    final (minVer, latestVer) = await _appPlatformUseCase.getRemoteConfigAppVersion();

    state.setAppVersionStatus(VersionComparator.compareVersions(version, minVer, latestVer));
    if (!state.appVersionStatus.isLatest) {
      state.appUpdateComment = await _appPlatformUseCase.getUpdateComment();
    }
    emit(state.copy());
  }

  Future<bool> healthCheck() async {
    try {
      print(await DartApiRemoteDataSource.healthCheck());
      return true;
    } on DioException catch(e, trace) {
      print(e);
      print(trace);
      if (e.error is AuthorizationException) {
        emit(cleanUpAuthInformation());
        ToastUtil.showToast("인증 정보가 만료되었어요 😢");
        await Future.delayed(const Duration(seconds: 2));
        Restart.restartApp();
      }
    }
    ToastUtil.showToast("로그인 요청 실패");
    return false;
  }

  void setAccessToken(String accessToken) {
    DartApiRemoteDataSource.addAuthorizationToken(accessToken);
    ChatConnection.accessToken = accessToken;
  }

  DartAuthState cleanUpAuthInformation() {
    return state.setStep(AuthStep.land).setSocialAuth(loginType: LoginType.email, socialAccessToken: "").copy();
  }

  Future<DartAuthState> kakaoLogout() async {
    try {
      _authUseCase.logoutWithKakaoTalk();
      _userUseCase.logout();
      // 로그아웃 성공 후 처리할 로직 추가
      print("로그아웃 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('로그아웃 실패: $error');
    }

    var newState = cleanUpAuthInformation();
    emit(newState);
    return newState;
  }

  Future<void> kakaoWithdrawal() async {
    try {
      _authUseCase.withdrawalWithKakaoTalk();
      _userUseCase.withdrawal();
      // 로그아웃 성공 후 처리할 로직 추가
      print("회원탈퇴 성공");
    } catch (error) {
      // 로그아웃 실패 처리
      print('회원탈퇴 실패: $error');
    }

    var newState = cleanUpAuthInformation();
    emit(newState);
  }

  void kakaoLogin() async {
    // loading 상태로 만든다.
    state.setLoading(true);
    print(state.toString());
    emit(state.copy());

    try {
      KakaoUser kakaoUser = await _authUseCase.loginWithKakaoTalk();
      DartAuth dartAuth = await _authUseCase.loginWithKakao(kakaoUser.accessToken);
      state
          .setDartAuth(dartAccessToken: dartAuth.accessToken, expiredAt: DateTime.now().add(const Duration(days: 10)))
          .setSocialAuth(loginType: LoginType.kakao, socialAccessToken: kakaoUser.accessToken);

      User userResponse = await _userUseCase.myInfo();

      String userId = userResponse.personalInfo!.id.toString();
      AnalyticsUtil.setUserId(userId);
      if (userResponse.personalInfo?.name == null || userResponse.personalInfo?.name == "(알수없음)") {
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

    try {
      final appleUser = await _authUseCase.loginWithAppleID();
      DartAuth dartAuth = await _authUseCase.loginWithApple(appleUser.identityToken!);
      state
          .setDartAuth(dartAccessToken: dartAuth.accessToken, expiredAt: DateTime.now().add(const Duration(days: 10)))
          .setSocialAuth(loginType: LoginType.apple, socialAccessToken: appleUser.authorizationCode)
          .setMemo('${appleUser.familyName ?? "오"}${appleUser.givenName ?? "늘"}');

      User userResponse = await _userUseCase.myInfo();

      String userId = userResponse.personalInfo!.id!.toString();
      AnalyticsUtil.setUserId(userId);
      if (userResponse.personalInfo?.name == null || userResponse.personalInfo?.name == "(알수없음)") {
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

  void setAnalyticsUserInformation() async {
    User userResponse = await _userUseCase.myInfo();
    if (userResponse.personalInfo == null) return;
    AnalyticsUtil.setUserId(userResponse.personalInfo!.id.toString());
    AnalyticsUtil.setUserInformation(userResponse.toAnalytics());
    print("onesignal id ${userResponse.personalInfo!.id}");
  }

  void setPushNotificationUserId() async {
    User userResponse = await _userUseCase.myInfo();
    if (userResponse.personalInfo == null) return;
    PushNotificationUtil.setUserId(userResponse.personalInfo!.id.toString());
  }

  @override
  DartAuthState fromJson(Map<String, dynamic> json) => state.fromJson(json);

  @override
  Map<String, dynamic> toJson(DartAuthState state) => state.toJson();
}


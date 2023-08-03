import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/res/app_theme.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/common/util/push_notification_util.dart';
import 'package:dart_flutter/src/common/util/timeago_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 랜딩페이지
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const BUILD_TYPE = String.fromEnvironment('BUILD_TYPE', defaultValue: 'DEFAULT');
  AppEnvironment.setupEnv(BuildType.from(BUILD_TYPE));
  if (AppEnvironment.buildType == BuildType.dev) ToastUtil.showToast("실행환경: Develop");
  if (AppEnvironment.buildType == BuildType.stage) ToastUtil.showToast("실행환경: Staging");
  print("실행환경: ${AppEnvironment.getEnv.toString()}");

  AnalyticsUtil.initialize();
  KakaoSdk.init(nativeAppKey: AppEnvironment.getEnv.getKakaoSdkKey());
  PushNotificationUtil.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());

  runApp(BlocProvider(
      create: (BuildContext context) => AuthCubit()..appVersionCheck()..setLandPage(),
      child: MaterialApp(
        home: const MyApp(),
        theme: AppTheme.lightThemeData,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // 기준 사이즈 지정
    TimeagoUtil().initKorean();

    // 로그인하지 않은 유저는 LandingPages로, 로그인한 유저는 MainPage로 이동
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.step == AuthStep.login && state.dartAccessToken.length > 20 && DateTime.now().microsecondsSinceEpoch < state.expiredAt.microsecondsSinceEpoch) {
              print("now accessToken: ${state.dartAccessToken}");
              BlocProvider.of<AuthCubit>(context).setAccessToken(state.dartAccessToken);
              return const LandPages();
            }
            return const LandPages();
          },
        ),
      ),
    );
  }
}

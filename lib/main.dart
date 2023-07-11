import 'package:dart_flutter/res/app_theme.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/common/util/timeago_util.dart';
import 'package:dart_flutter/src/presentation/page_view.dart';
import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 랜딩페이지
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'c83df49e14c914b9bda9b902b6624da2',
  );
  
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("1f36be12-544d-4bb5-9d9a-c54789698647");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());

  runApp(MaterialApp(
    home: BlocProvider(
      create: (BuildContext context) => AuthCubit()..setLandPage(),
      child: const MyApp(),
    ),
    theme: AppTheme.lightThemeData,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // 기준 사이즈 지정
    TimeagoUtil().initKorean();

    // 로그인하지 않은 유저는 LandingPages로, 로그인한 유저는 MainPage로 이동
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state.step == AuthStep.login && state.dartAccessToken.length > 20 && DateTime.now().microsecondsSinceEpoch < state.expiredAt.microsecondsSinceEpoch) {
            print("now accessToken: ${state.dartAccessToken}");
            BlocProvider.of<AuthCubit>(context).setAccessToken(state.dartAccessToken);
            return const DartPageView();
          }
          return const LandPages();
        },
      ),
    );
  }
}

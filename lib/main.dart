import 'package:dart_flutter/res/app_theme.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/util/timeago_util.dart';
import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:path_provider/path_provider.dart';

// 랜딩페이지
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'c83df49e14c914b9bda9b902b6624da2',
  );
  TimeagoUtil().initKorean();

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());

  runApp(MaterialApp(
    home: BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: const MyApp(),
    ),
    theme: AppTheme.lightThemeData,
  ));
}

// stless 입력으로 기존 기본 템플릿 -> stateless로 변경
// stless(변경 필요한 data x) vs stful(변경된 부분을 위젯에 반영하는 동적 위젯)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // 기준 사이즈 지정
    return const LandPages();
  }
}

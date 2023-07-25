import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/presentation/signup/land_page.dart';
import 'package:dart_flutter/src/presentation/signup/signup_pages.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:dart_flutter/src/presentation/standby/standby_loading.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/standby_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LandPages extends StatefulWidget {
  const LandPages({Key? key}) : super(key: key);

  @override
  State<LandPages> createState() => _LandPagesState();
}

class _LandPagesState extends State<LandPages> {
  Future<String> getAndroidKeyHash() async {
    String key = await KakaoSdk.origin;
    return key;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          if (state.step == AuthStep.land) {
            return const LandingPage();
          }
          if (state.step == AuthStep.signup) {
            // 소셜 로그인을 했지만, 아직 우리 회원가입은 안햇을 때
            return BlocProvider<SignupCubit>(
              create: (BuildContext context) => SignupCubit()..initState(
                BlocProvider.of<AuthCubit>(context).state.memo,
                BlocProvider.of<AuthCubit>(context).state.loginType.toString(),
              ),
              child: const SignupPages(),
            );
          }
          if (state.step == AuthStep.login) {
            return BlocProvider<StandbyCubit>(
              create: (BuildContext context) => StandbyCubit()..initPages(),
              child: const StandbyLoading(),
            );
          }
          return const SizedBox();
        }),
      ],
      // 화면 분배
    );
  }
}

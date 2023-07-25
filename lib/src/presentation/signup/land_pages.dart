import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/auth/state/auth_state.dart';
import 'package:dart_flutter/src/presentation/page_view.dart';
import 'package:dart_flutter/src/presentation/signup/land_page.dart';
import 'package:dart_flutter/src/presentation/signup/signup_pages.dart';
import 'package:dart_flutter/src/presentation/signup/tutorial_slide.dart';
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
            if (state.tutorialStatus == TutorialStatus.notShown) {
              return TutorialSlide(
                onTutorialFinished: () {
                  // 튜토리얼이 완료되면 AuthCubit을 사용하여 상태 변경
                  BlocProvider.of<AuthCubit>(context).markTutorialShown();
                },
              );
            }
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

        // BlocBuilder<AuthCubit, AuthState>(
        //   builder: (context, state) {
        //     if (!state.isLoading) {
        //       return SafeArea(
        //           child: Text(state.toJson().toString(), style: const TextStyle(fontSize: 15, color: Colors.red)));
        //       // return const SizedBox();
        //     }
        //     return const SafeArea(child: Center(child: CircularProgressIndicator()));
        //   },
        // ),

        // Andorid Key Hash 확인 로직
        // FutureBuilder<String>(
        //   future: getAndroidKeyHash(),
        //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       // 데이터 로딩 중인 경우 로딩 표시를 보여줍니다.
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (snapshot.hasError) {
        //       // 에러 발생 시 에러 메시지를 보여줍니다.
        //       return Center(
        //         child: Text('데이터를 불러오는 동안 오류가 발생했습니다.'),
        //       );
        //     } else {
        //       // 데이터가 성공적으로 로드된 경우 값을 표시합니다.
        //       return SizedBox(
        //         width: 200,
        //         height: 200,
        //         child: Center(
        //           child: Text(snapshot.data!),
        //         ),
        //       );
        //     }
        //   },
        // ),
      ],
      // 화면 분배
    );
  }
}

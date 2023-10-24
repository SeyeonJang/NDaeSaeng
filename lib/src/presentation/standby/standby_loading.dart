import 'dart:async';

import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/auth/dart_auth_cubit.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/standby_cubit.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/state/standby_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../page_view.dart';

class StandbyLoading extends StatefulWidget {
  StandbyLoading({Key? key}) : super(key: key);

  @override
  State<StandbyLoading> createState() => _StandbyLoadingState();
}

class _StandbyLoadingState extends State<StandbyLoading> {
  late int logoutLeftSeconds;
  late Timer logoutTimer;

  // 로딩화면에서 7초이상 머무를시 로그아웃 동작 (무한로딩 방지)
  void onTick(Timer timer) {
    logoutLeftSeconds--;
    print(logoutLeftSeconds);

    if (logoutLeftSeconds <= 0) {
      ToastUtil.showToast("연결 상태가 좋지 않습니다.");
      timer.cancel();
      BlocProvider.of<DartAuthCubit>(context).cleanUpAuthInformation();
    }
  }

  @override
  void initState() {
    super.initState();
    logoutLeftSeconds = 7;
    logoutTimer = Timer.periodic(const Duration(seconds: 1), onTick);

    BlocProvider.of<DartAuthCubit>(context).verifyTokenExpired();  // 토큰 만료 여부 체크
  }

  @override
  void dispose() {
    logoutTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: [
                    Color.fromARGB(100, 98, 105, 234),
                    Color.fromARGB(100, 71, 126, 211),
                    Color.fromARGB(100, 118, 204, 217),
                    Color.fromARGB(100, 218, 204, 213),
                  ],
                ),
              ),
            ),
            BlocBuilder<StandbyCubit, StandbyState>(
              builder: (context, state) {
                // 회원정보 로딩이 완료된 후에 페이지를 넘긴다
                if (!state.isLoading) {
                  // 내 정보를 분석툴에 저장
                  print("내정보: ${state.userResponse.toString()}");
                  AnalyticsUtil.setUserInformation(state.userResponse.toAnalytics());

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DartPageView(initialPage: 2,)),
                        (route) => false);
                  });
                }

                // 로딩 동그라미
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

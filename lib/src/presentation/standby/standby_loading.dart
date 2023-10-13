import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/standby_cubit.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/state/standby_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../page_view.dart';

class StandbyLoading extends StatelessWidget {
  const StandbyLoading({Key? key}) : super(key: key);

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
                            builder: (context) => DartPageView(
                                  initialPage: 2,
                                )),
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

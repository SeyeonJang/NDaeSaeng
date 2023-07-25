import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/mypage/my_page_landing.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPages extends StatelessWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          BlocBuilder<MyPagesCubit, MyPagesState>(
              builder: (context, state) {
                if (state.isMyLandPage) {
                  AnalyticsUtil.logEvent("내정보_마이_접속");
                  return const MyPageLanding();
                }
                return SafeArea(child: Center(child: Text(state.toString())));
              }
          ),
          BlocBuilder<MyPagesCubit, MyPagesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            },
          ),

          // BlocBuilder<MyPagesCubit, MyPagesState>(
          //   builder: (context, state) {
          //       return SafeArea(child: Text(state.toString()));
          //   },
          // ),
        ]
    );
  }
}

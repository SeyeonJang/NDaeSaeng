import 'package:dart_flutter/src/presentation/standby/standby_landing_page.dart';
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
        child: Center(
          child: Stack(
            children: [
              BlocBuilder<StandbyCubit, StandbyState> (
                builder: (context, state) {
                  if (state.isFirstCommCompleted) {
                    // 친구가 4명이상이면 메인화면으로 이동
                    int count = state.addedFriends.length;
                    if (count >= 4) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) => const DartPageView()), (route) => false);
                      });
                    } else {
                      // 친구가 없으면 스탠바이 페이지로 이동
                      return const StandbyLandingPage();
                    }
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

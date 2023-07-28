import 'dart:async';

import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteTimer extends StatefulWidget {
  const VoteTimer({Key? key}) : super(key: key);

  @override
  State<VoteTimer> createState() => _VoteTimerState();
}

class _VoteTimerState extends State<VoteTimer> {
  late int totalSeconds;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds <= 0) {
      setState(() {
        timer.cancel();
        BlocProvider.of<VoteCubit>(context).stepWait();
      });
    } else {
      setState(() {
        totalSeconds = BlocProvider.of<VoteCubit>(context).state.leftNextVoteTime();
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds).toString(); // 시간형식으로 나타내줌 0:00:00.000000

    List<String> parts = duration.split(":"); // 콜론을 기준으로 문자열을 분할합니다.
    String hh = parts[1]; // 시간 부분을 hh에 저장합니다.
    String ss = parts[2].split(".")[0]; // 초 부분을 ss에 저장합니다. (소수점 이하 자릿수를 제거하기 위해 "."을 기준으로 분할)

    return "$hh:$ss"; // 가운데 hh:ss 형식으로 반환합니다.
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    totalSeconds = BlocProvider.of<VoteCubit>(context).state.leftNextVoteTime();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                flex: 2,
                child: SizedBox(),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "다시 시작하기까지",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 3.7,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          AnalyticsUtil.logEvent("투표_타이머_시간", properties: {"남은 시간": totalSeconds});
                        },
                        child: Text(
                          format(totalSeconds),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: SizeConfig.defaultSize * 9,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.06),
                    Text(
                      "새로운 질문들이 준비되면 알림을 드릴게요!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.defaultSize * 2,
                      ),
                    ),
                  ],
                ),
              ),
              // Flexible( // TODO : MVP 출시 이후 복구하기
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("바로 시작하려면?", style: TextStyle(fontSize: SizeConfig.defaultSize * 3.2)),
              //       SizedBox(height:SizeConfig.defaultSize * 1),
              //       ElevatedButton(
              //         onPressed: () {
              //           // BlocProvider.of<VoteCubit>(context).stepWait();
              //           BlocProvider.of<VoteCubit>(context).inviteFriend();
              //         },
              //         child: Text(
              //           "친구 초대하기",
              //           style: TextStyle(
              //             fontSize: SizeConfig.defaultSize * 4,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const Flexible(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

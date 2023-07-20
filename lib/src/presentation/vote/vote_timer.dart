import 'dart:async';

import 'package:dart_flutter/res/size_config.dart';
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
        // totalSeconds--;
        totalSeconds = BlocProvider.of<VoteCubit>(context).state.leftNextVoteTime();
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds); // 시간형식으로 나타내줌 0:00:00.000000
    String time = duration.toString().split(".").first.substring(2);

    if (time.startsWith(':')) {
      time.substring(1);
    }

    return time;
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
                      child: Text(
                        format(totalSeconds),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 9,
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

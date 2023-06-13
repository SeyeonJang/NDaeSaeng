import 'dart:async';

import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/vote/vote_pages.dart';
import 'package:flutter/material.dart';

class VoteTimer extends StatefulWidget {
  const VoteTimer({Key? key}) : super(key: key);

  @override
  State<VoteTimer> createState() => _VoteTimerState();
}

class _VoteTimerState extends State<VoteTimer> {
  static const fourtyMins = 2400;
  int leftMins = fourtyMins;
  late Timer timer;

  void onTick(Timer timer) {
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "다시 시작하기까지",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 4,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "40:00",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: SizeConfig.defaultSize * 9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("바로 시작하려면?", style: TextStyle(fontSize: SizeConfig.defaultSize * 3.2)),
                    SizedBox(height:SizeConfig.defaultSize * 1),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VotePages()));
                      },
                      child: Text(
                        "친구 초대하기",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

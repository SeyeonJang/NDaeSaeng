import 'dart:async';

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
        padding: const EdgeInsets.all(50),
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
                      child: const Text(
                        "다시 시작하기까지",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: const Text(
                          "40:00",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 80,
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
                    Text("바로 시작하려면?", style: TextStyle(fontSize: 30)),
                    SizedBox(height:10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VotePages()));
                      },
                      child: const Text(
                        "친구 초대하기",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

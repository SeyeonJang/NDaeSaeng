import 'package:dart_flutter/src/presentation/vote/vote_timer.dart';
import 'package:flutter/material.dart';

class VoteResultView extends StatelessWidget {
  const VoteResultView({Key? key}) : super(key: key);

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
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    "축하해요!",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Flexible(
                // flex: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: const Icon(Icons.emoji_emotions, size: 200)
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    "Dart를 통해 얻은 Point, 30!",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VoteTimer()));
                  },
                  child: const Text(
                    "포인트 받기",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
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

import 'package:dart_flutter/src/presentation/vote/vote_list_view.dart';
import 'package:flutter/material.dart';

class VoteDetailView extends StatelessWidget {
  const VoteDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text("20학번 여학생이 보낸 Dart",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 25)),
                ),
              ),
              const Flexible(
                flex: 1,
                child: Icon(Icons.emoji_emotions, size: 200),
              ),
              const Flexible(
                flex: 2,
                child: Text(
                  "가장 배고픈 사람을 골라주세요. 글자가 많아지면 어떻게될까요?",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoteListView()));
                      },
                      child: const Text(
                        "보낸 사람 힌트 보기",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoteListView()));
                      },
                      child: const Text(
                        "닫기",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

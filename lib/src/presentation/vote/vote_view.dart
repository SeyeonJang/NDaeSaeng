import 'package:dart_flutter/src/presentation/vote/vote_result_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoteView extends StatelessWidget {
  const VoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              VoteStoryBar(),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceFriendButton(name: "최현식", enterYear: "17", department: "정보통신공학공학"),
                        ChoiceFriendButton(name: "최현식", enterYear: "17", department: "정보통신공학공학"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceFriendButton(name: "최현식", enterYear: "17", department: "정보통신공학공학"),
                        ChoiceFriendButton(name: "최현식", enterYear: "17", department: "정보통신공학공학"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.shuffle)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VoteResultView()));
                            },
                            icon: const Icon(Icons.skip_next)),
                      ],
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

class VoteStoryBar extends StatefulWidget {
  const VoteStoryBar({
    super.key,
  });

  @override
  State<VoteStoryBar> createState() => _VoteStoryBarState();
}

class _VoteStoryBarState extends State<VoteStoryBar> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: Container(height: 5, color: Colors.black,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.black,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.blueGrey,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.blueGrey,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.blueGrey,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.blueGrey,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.blueGrey,)),
              SizedBox(width: 5),
              Expanded(child: Container(height: 5, color: Colors.blueGrey,)),
            ],
          ),
        ),
      ],
    );
  }
}

class ChoiceFriendButton extends StatelessWidget {
  final String name;
  final String enterYear;
  final String department;

  const ChoiceFriendButton({
    super.key,
    required this.name,
    required this.enterYear,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            "$enterYear학번, $department부",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

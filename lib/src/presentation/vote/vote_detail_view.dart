import 'package:dart_flutter/src/presentation/vote/vote_list_view.dart';
import 'package:flutter/material.dart';

import '../../../res/size_config.dart';

class VoteDetailView extends StatelessWidget {
  const VoteDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              // horizontal: SizeConfig.defaultSize * 5,
              vertical: SizeConfig.defaultSize * 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoteListView()));
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded,
                          size: SizeConfig.defaultSize * 3)),
                  Text("여학생이 보낸 Dart",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 2.5)),
                  SizedBox(width: SizeConfig.defaultSize * 5),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 5,
                      vertical: SizeConfig.defaultSize * 2),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: SizeConfig.defaultSize * 3),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              Icon(Icons.emoji_emotions,
                                  size: SizeConfig.defaultSize * 22),
                              Text(
                                "가장 배고픈 사람을 골라주세요. 글자가 많아지면 어떻게될까요?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: SizeConfig.defaultSize * 2.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("누가 보냈는지 궁금하다면?"),
                              HintButton(buttonName: '학번 보기', point: 100),
                              HintButton(buttonName: '학과 보기', point: 150),
                              HintButton(buttonName: '초성 보기 한 글자 보기', point: 500),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HintButton extends StatelessWidget {
  final String buttonName;
  final int point;

  const HintButton({
    super.key,
    required this.buttonName,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize * 40,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "$buttonName (${point}P)",
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 2,
          ),
        ),
      ),
    );
  }
}

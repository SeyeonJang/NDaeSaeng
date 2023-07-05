import 'package:flutter/material.dart';
import '../../../res/size_config.dart';

class MeetTwoDone extends StatelessWidget {
  const MeetTwoDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.defaultSize * 10,),
              Text("팀 선택 7월 말 OPEN!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.defaultSize * 4,
                ),),
              Text("이성 팀 목록이 오픈되면 알림을 드릴게요!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.defaultSize * 2,
                ),),
              SizedBox(height: SizeConfig.defaultSize * 5,),
              // 팀 프로필 보기
              // 본인 프로필 수정 불가능 (기능 넣지 말기)
              // 기다리는 동안 친구들과 투표하기
              // 기다리는 동안 얼른 열어주세요 하트 누르기?

            ],
          )
      ),
    );
  }
}

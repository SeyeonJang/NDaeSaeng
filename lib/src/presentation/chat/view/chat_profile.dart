import 'package:flutter/material.dart';

import '../../../../res/config/size_config.dart';

class ChatProfile extends StatelessWidget {
  const ChatProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                      'assets/images/profile-mockup3.png',
                      width: SizeConfig.screenWidth * 0.5, // 이미지 크기
                      height: SizeConfig.screenWidth * 0.5
                  ),
                ),
              ),
                SizedBox(height: SizeConfig.defaultSize * 1.6,),

              Text("닉네임", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 2,
                fontWeight: FontWeight.w600
              ),),
                SizedBox(height: SizeConfig.defaultSize * 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("가톨릭대학교", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.7
                  ),),
                  Text("02년생", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7
                  ),)
                ],
              ),
                SizedBox(height: SizeConfig.defaultSize,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("정보통신전자공학부", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7
                  ),),
                    SizedBox(width: SizeConfig.defaultSize * 0.5,),
                  // if (chatState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                    Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.5),
                ],
              ),
                SizedBox(height: SizeConfig.defaultSize * 3,),

              Container(
                height: SizeConfig.defaultSize * 12.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      // userResponse.titleVotes.length > i ?
                      // VoteView(userResponse.titleVotes[i].question.content ?? "(알수없음)", userResponse.titleVotes[i].count) :
                      NoVoteView(),
                  ],
                ),
              ),
                SizedBox(height: SizeConfig.defaultSize * 12),

              Column(
                children: [
                  Text("OOO를 친구로 추가해서 투표하고 싶다면"),
                  Text("채팅방에서 서로 코드를 공유해요!")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoVoteView extends StatelessWidget { // 받은 투표 없을 때
  const NoVoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AnalyticsUtil.logEvent("과팅_팀만들기_카드_투표_터치", properties: {
        //   'questionName': "빈칸",
        //   'count': 0
        // });
      },
      child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.defaultSize * 3.8,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text("아직 프로필에 받은 투표를 넣지 않았어요!", style: TextStyle(
              color: Color(0xffFF5C58),
              fontSize: SizeConfig.defaultSize * 1.45
          ),)
      ),
    );
  }
}
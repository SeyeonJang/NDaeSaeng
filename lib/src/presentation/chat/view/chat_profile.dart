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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container( // 버리는 사진
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
              Text("닉네임"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("가톨릭대학교"),
                  Text("02년생")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("정보통신전자공학부"),
                  // if (chatState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                    Image.asset("assets/images/check.png", width: SizeConfig.defaultSize),
                ],
              ),
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

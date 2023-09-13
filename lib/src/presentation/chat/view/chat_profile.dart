import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';
import 'package:flutter/material.dart';

import '../../../../res/config/size_config.dart';

class ChatProfile extends StatelessWidget {
  final String university;
  final BlindDateUserDetail profile;

  const ChatProfile({super.key, required this.university, required this.profile});

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
              ClipOval(
                  child: profile.profileImageUrl == 'DEFAULT' || !profile.profileImageUrl.startsWith('https://')
                      ? Image.asset(
                      'assets/images/profile-mockup3.png',
                      width: SizeConfig.screenWidth * 0.5,
                      height: SizeConfig.screenWidth * 0.5
                  )
                      : Image.network(profile.profileImageUrl,
                    width: SizeConfig.screenWidth * 0.5,
                    height: SizeConfig.screenWidth * 0.5,
                    fit: BoxFit.cover,)
              ),
                SizedBox(height: SizeConfig.defaultSize * 1.6,),

              Text(profile.name == 'DEFAULT' ? '닉네임 없음' : profile.name, style: TextStyle(
                fontSize: SizeConfig.defaultSize * 2,
                fontWeight: FontWeight.w600
              ),),
                SizedBox(height: SizeConfig.defaultSize * 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(university, style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.7
                  ),),
                  Text('${profile.birthYear.toString().substring(2,4)}년생', style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7
                  ),)
                ],
              ),
                SizedBox(height: SizeConfig.defaultSize,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(profile.department, style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7
                  ),),
                    SizedBox(width: SizeConfig.defaultSize * 0.5,),
                  if (profile.isCertifiedUser ?? false)
                    Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.5),
                ],
              ),
                SizedBox(height: SizeConfig.defaultSize * 3,),

              SizedBox(
                height: SizeConfig.defaultSize * 12.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      profile.profileQuestionResponses.length > i
                          ? VoteView(profile.profileQuestionResponses[i].question.content ?? "(알수없음)", profile.profileQuestionResponses[i].count)
                          : const NoVoteView(),
                  ],
                ),
              ),
                SizedBox(height: SizeConfig.defaultSize * 12),

              Column(
                children: [
                  Text("${profile.name=='DEFAULT'?'(닉네임없음)':profile.name}를 친구로 추가해서 투표하고 싶다면"),
                  const Text("채팅방에서 서로 코드를 공유해요!")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VoteView extends StatelessWidget { // 받은 투표 있을 때
  final String questionName;
  final int count;

  const VoteView(
      this.questionName, this.count
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AnalyticsUtil.logEvent("과팅_팀만들기_카드_투표_터치", properties: {
        //   'questionName': questionName,
        //   'count': count
        // });
      },
      child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.defaultSize * 3.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffFF5C58)
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(questionName, style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.defaultSize * 1.3
                ),),
                Text("$count",  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.defaultSize * 1.3
                ),)
              ],
            ),
          )
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
              color: const Color(0xffFF5C58),
              fontSize: SizeConfig.defaultSize * 1.45
          ),)
      ),
    );
  }
}
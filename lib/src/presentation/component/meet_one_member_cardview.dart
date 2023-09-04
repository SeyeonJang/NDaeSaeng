import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import '../../../res/config/size_config.dart';

class MeetOneMemberCardview extends StatelessWidget {
  final User userResponse;

  const MeetOneMemberCardview({super.key, required this.userResponse});

  @override
  Widget build(BuildContext context) {
    return Container( // 팀원 한 명
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 21.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row( // 위층 (받은 투표 윗 부분 Row)
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("과팅_팀만들기_카드_프사_터치");
                      },
                      child: userResponse.personalInfo?.profileImageUrl == "DEFAULT" || userResponse.personalInfo?.profileImageUrl == null
                          ? ClipOval(
                        child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 6.2, fit: BoxFit.cover,),
                      )
                          : ClipOval(
                          child: Image.network(userResponse.personalInfo!.profileImageUrl,
                            width: SizeConfig.defaultSize * 6.2,
                            height: SizeConfig.defaultSize * 6.2,
                            fit: BoxFit.cover,)
                      ),
                    ),
                    SizedBox(width: SizeConfig.defaultSize * 0.8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: SizeConfig.defaultSize * 3.3,
                          child: Row( // 위층 (이름 ~ 년생)
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: SizeConfig.defaultSize * 26,
                                height: SizeConfig.defaultSize * 3.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        AnalyticsUtil.logEvent("과팅_팀만들기_카드_정보_터치", properties: {
                                          'nickname': userResponse.personalInfo?.nickname ?? "닉네임없음",
                                          'birthYear': userResponse.personalInfo?.birthYear.toString().substring(2,4)??"??",
                                          'verification': userResponse.personalInfo?.verification.isVerificationSuccess.toString() ?? "false"
                                        });
                                      },
                                      child: Row(
                                          children: [
                                            SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                            Text(
                                              userResponse.personalInfo?.nickname == 'DEFAULT'
                                                  ? ('${userResponse.personalInfo?.name}' ?? '이름')
                                                  : (userResponse.personalInfo?.nickname ?? '닉네임'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig.defaultSize * 1.6,
                                                color: Colors.black,
                                              ),),
                                            SizedBox(width: SizeConfig.defaultSize * 0.3),

                                            if (userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),

                                            SizedBox(width: SizeConfig.defaultSize * 0.5),
                                            Text(
                                              "∙ ${userResponse.personalInfo?.birthYear.toString().substring(2,4)??"??"}년생",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig.defaultSize * 1.6,
                                                color: Colors.black,
                                              ),),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row( // 2층
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                              Container(
                                width: SizeConfig.screenWidth * 0.56,
                                child: GestureDetector(
                                  onTap: () {
                                    AnalyticsUtil.logEvent("과팅_팀만들기_카드_학부_터치", properties: {
                                      'department': userResponse.university?.department ?? "알수없음"
                                    });
                                  },
                                  child: Text(
                                    userResponse.university?.department ?? "??학부",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // TODO : 받은 투표가 있다면 VoteView, 없으면 NoVoteView
            Container(
              height: SizeConfig.defaultSize * 11.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 3; i++)
                    userResponse.titleVotes.length > i ?
                    VoteView(userResponse.titleVotes[i].question.content ?? "(알수없음)", userResponse.titleVotes[i].count) :
                    NoVoteView(),
                ],
              ),
            )
          ],
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
              color: Color(0xffFF5C58)
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
        AnalyticsUtil.logEvent("과팅_팀만들기_카드_투표_터치", properties: {
          'questionName': "빈칸",
          'count': 0
        });
      },
      child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.defaultSize * 3.5,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text("내정보 탭에서 받은 투표를 프로필로 넣어보세요!", style: TextStyle(
              color: Color(0xffFF5C58),
              fontSize: SizeConfig.defaultSize * 1.3
          ),)
      ),
    );
  }
}
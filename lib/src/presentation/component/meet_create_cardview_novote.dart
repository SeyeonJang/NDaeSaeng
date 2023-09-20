import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import '../../../res/config/size_config.dart';
import '../../domain/entity/type/blind_date_user_detail.dart';

// TODO : Analytics 수정하기

class MeetCreateCardviewNovote extends StatelessWidget {
  final BlindDateUserDetail userResponse;
  final String university;

  const MeetCreateCardviewNovote({super.key, required this.userResponse, required this.university});

  @override
  Widget build(BuildContext context) {
    return Container( // 팀원 한 명
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 12.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2.0,
            offset: Offset(0,1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                          child: userResponse.profileImageUrl == "DEFAULT" || userResponse.profileImageUrl == null
                              ? ClipOval(
                            child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 9, fit: BoxFit.cover,),
                          )
                              : ClipOval(
                              child: Image.network(userResponse.profileImageUrl,
                                width: SizeConfig.defaultSize * 9,
                                height: SizeConfig.defaultSize * 9,
                                fit: BoxFit.cover,)
                          ),
                        ),
                        SizedBox(width: SizeConfig.defaultSize * 1.7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeConfig.defaultSize * 2.5,
                            child: Row( // 위층 (이름 ~ 년생)
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.defaultSize * 21,
                                  height: SizeConfig.defaultSize * 3.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          AnalyticsUtil.logEvent("과팅_팀만들기_카드_정보_터치", properties: {
                                            'nickname': userResponse.name,
                                            'birthYear': userResponse.birthYear.toString().substring(2,4),
                                            'verification': userResponse.isCertifiedUser
                                          });
                                        },
                                        child: Row(
                                            children: [
                                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                              Text(
                                                userResponse.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: SizeConfig.defaultSize * 1.6,
                                                  color: Colors.black,
                                                ),),
                                              SizedBox(width: SizeConfig.defaultSize * 0.3),

                                              // if (userResponse.isCertifiedUser)
                                              //   Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),

                                              SizedBox(width: SizeConfig.defaultSize * 0.5),
                                              Text(
                                                "∙ ${userResponse.birthYear.toString().substring(2,4)}년생",
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
                            height: SizeConfig.defaultSize * 2.5,
                            child: Row( // 2층
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                Container(
                                  width: SizeConfig.screenWidth * 0.55,
                                  child: GestureDetector(
                                    onTap: () {
                                      AnalyticsUtil.logEvent("과팅_팀만들기_카드_학교_터치", properties: {
                                        'university': university
                                      });
                                    },
                                    child: Text(
                                      university ,
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
                          Container(
                            width: SizeConfig.defaultSize * 22,
                            height: SizeConfig.defaultSize * 2.5,
                            child: Row( // 2층
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                Container(
                                  width: SizeConfig.screenWidth * 0.55,
                                  child: GestureDetector(
                                    onTap: () {
                                      AnalyticsUtil.logEvent("과팅_팀만들기_카드_학부_터치", properties: {
                                        'department': userResponse.department
                                      });
                                    },
                                    child: Text(
                                      userResponse.department,
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

              // Container(
              //   height: SizeConfig.defaultSize * 11.5,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       for (int i = 0; i < 3; i++)
              //         userResponse.profileQuestionResponses.length > i ?
              //         VoteView(userResponse.profileQuestionResponses[i].question.content ?? "(알수없음)", userResponse.profileQuestionResponses[i].count) :
              //         NoVoteView(),
              //     ],
              //   ),
              // )
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
                count<5
                    ? Text(" ", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.3,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis
                    ),)
                    : Text("${(count~/5)*5}+", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.3,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis
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
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text("아직 받은 투표를 프로필에 넣지 않았어요!", style: TextStyle(
              color: Color(0xffFF5C58),
              fontSize: SizeConfig.defaultSize * 1.3
          ),)
      ),
    );
  }
}
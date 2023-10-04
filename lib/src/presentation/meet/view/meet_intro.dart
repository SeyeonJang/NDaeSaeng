import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team_input.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_my_team_detail.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/state/meet_state.dart';

class MeetIntro extends StatelessWidget {
  const MeetIntro({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsUtil.logEvent('홈_접속');
    return Scaffold(
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: BodySection(),
      ),

      bottomNavigationBar:
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context,state) {
            return state.isLoading
                ? Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.defaultSize * 12,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(color: Colors.grey, ),
                          SizedBox(width: SizeConfig.defaultSize * 2),
                        Text("내 정보를 불러오고 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),),
                      ],
                    ),
                  )
                : state.myTeams.isEmpty ? MakeTeamButton(ancestorContext: context) : SeeMyTeamButton(ancestorContext: context, teamId: state.myTeams[0].id,);
          }
        )
    );
  }
}

class BodySection extends StatelessWidget {
  const BodySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5, vertical: SizeConfig.defaultSize * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            SizedBox(height: SizeConfig.defaultSize * 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.defaultSize * 22,
                height: SizeConfig.defaultSize * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("친구가 앱에 없어도 👀", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
              )
            ],
          ),
            SizedBox(height: SizeConfig.defaultSize * 0.9,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: SizeConfig.defaultSize * 21,
                height: SizeConfig.defaultSize * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("친구 정보로 팀 만들고", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
              )
            ],
          ),
            SizedBox(height: SizeConfig.defaultSize * 0.9,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.defaultSize * 21,
                height: SizeConfig.defaultSize * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("바로 과팅 시작! 🥰❤️", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
              )
            ],
          ),
            SizedBox(height: SizeConfig.defaultSize * 5,),
          SizedBox(
            height: SizeConfig.defaultSize * 4,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("only   ", style: TextStyle(color: Colors.grey),),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text("   3단계", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 5,),

          ClipOval(
            child: Container(
              width: SizeConfig.defaultSize * 2.8, // 원의 너비
              height: SizeConfig.defaultSize * 2.8, // 원의 높이
              color: const Color(0xffFE6059), // 빨간색 배경
              child: Center(
                child: Text('1', style: TextStyle(
                    color: Colors.white, // 흰색 텍스트
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize * 1.7 // 텍스트 크기
                  ),
                ),
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Container( // 1번 내용
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/meet_intro.png')
                      )
                  ),
                  SizedBox(height: SizeConfig.defaultSize),
                  Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.defaultSize * 3.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("팀명, 만나고 싶은 지역, 팀원 정보를 입력한다", style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),)
                  )
                ],
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),

          ClipOval(
            child: Container(
              width: SizeConfig.defaultSize * 2.8, // 원의 너비
              height: SizeConfig.defaultSize * 2.8, // 원의 높이
              color: const Color(0xffFE6059), // 빨간색 배경
              child: Center(
                child: Text('2', style: TextStyle(
                    color: Colors.white, // 흰색 텍스트
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize * 1.7 // 텍스트 크기
                ),
                ),
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Container( // 2번 내용
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.defaultSize),
                          child: Image.asset('assets/images/likesend.png'),
                        )
                    )
                  ),
                    SizedBox(height: SizeConfig.defaultSize),
                  Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.defaultSize * 3.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("마음에 드는 팀에게 호감을 보낸다", style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),)
                  )
                ],
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),

          ClipOval(
            child: Container(
              width: SizeConfig.defaultSize * 2.8, // 원의 너비
              height: SizeConfig.defaultSize * 2.8, // 원의 높이
              color: const Color(0xffFE6059), // 빨간색 배경
              child: Center(
                child: Text('3', style: TextStyle(
                    color: Colors.white, // 흰색 텍스트
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize * 1.7 // 텍스트 크기
                ),
                ),
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Container( // 3번 내용
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.defaultSize * 25,
                                  height: SizeConfig.defaultSize * 6,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13), bottomRight: Radius.circular(13)),
                                  ),
                                  child: const Text("안녕하세요! 저희는 OOOO학과\n학생들이에요! 대화해보고 싶어요! ☺️"),
                                ),
                              ],
                            ),
                               SizedBox(height: SizeConfig.defaultSize,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: SizeConfig.defaultSize * 27.2,
                                  height: SizeConfig.defaultSize * 3.2,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFE6059),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13), bottomLeft: Radius.circular(13)),
                                  ),
                                  child: const Text("안녕하세요! 저희도 대화해보고 싶어요! 😊", style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: SizeConfig.defaultSize,),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.defaultSize * 3.5,
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    child: const Text("상대 팀도 호감을 수락하면 채팅 시작!", style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),)
                  )
                ],
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 5),
          SizedBox(width: SizeConfig.screenWidth, child: const Text("추가 Tip 1.\n내정보 탭에서 학생증 인증을 하면 팀애 인증 배지가 붙어요!", style: TextStyle(color: Colors.grey), textAlign: TextAlign.left,)),
            SizedBox(height: SizeConfig.defaultSize,),
          const Text("추가 Tip 2.\n상대에게 보이는 내 사진과 닉네임을 내정보 탭 - 설정에서 바꿀 수 있어요!", style: TextStyle(color: Colors.grey),),
            SizedBox(height: SizeConfig.defaultSize * 3,),
        ],
      ),
    );
  }
}

class MakeTeamButton extends StatelessWidget {
  BuildContext ancestorContext;

  MakeTeamButton({
    super.key,
    required this.ancestorContext
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 12,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector(
          onTap: () async {
            AnalyticsUtil.logEvent('홈_팀만들기버튼_터치');

            await Navigator.push(ancestorContext,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<MeetCubit>(
                    create: (_) => MeetCubit(),
                    child: MeetCreateTeamInput(
                        onFinish: () { },
                        state: ancestorContext.read<MeetCubit>().state,
                        ancestorContext: ancestorContext,
                    ),
                  ),
                ))
                .then((value) async {
              if (value == null) return;
              ancestorContext.read<MeetCubit>().initMeetIntro();
              await ancestorContext.read<MeetCubit>().createNewTeam(value);
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.defaultSize * 6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffFE6059),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 2.0,
                        offset: const Offset(0,1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text("팀 만들기", style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.defaultSize * 2,
                      fontWeight: FontWeight.w600
                  ),)
              ),
              const Text("위 버튼을 눌러 팀 만들고 바로 과팅 시작하기", style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.grey
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

class SeeMyTeamButton extends StatelessWidget {
  final BuildContext ancestorContext;
  final int teamId;

  const SeeMyTeamButton({
    super.key,
    required this.ancestorContext,
    required this.teamId
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 7.8,
      color: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector( // 내 팀 보기 버튼 *******
          onTap: () {
            AnalyticsUtil.logEvent('홈_내팀보기버튼_터치');

            Navigator.push(
              ancestorContext,
              MaterialPageRoute(
                builder: (context) => BlocProvider<MeetCubit>(
                  create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
                  child: MeetMyTeamDetail(teamId: teamId,),
                ),
              ),
            ).then((value) async {
              if (value == null) return;
              ancestorContext.read<MeetCubit>().initMeetIntro();
            });
          },
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 6,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: const Color(0xffFE6059),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text("내 팀 보기", style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
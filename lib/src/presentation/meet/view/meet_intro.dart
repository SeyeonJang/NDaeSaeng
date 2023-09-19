import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../viewmodel/state/meet_state.dart';

class MeetIntro extends StatelessWidget {
  const MeetIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: BodySection(),
      ),

      bottomNavigationBar:
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context,state) {
            return state.myTeams.length < 1
                ? const MakeTeamButton()
                : SeeMyTeamButton(ancestorContext: context);
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
                  color: Color(0xffFE6059),
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
                  color: Color(0xffFE6059),
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
                  color: Color(0xffFE6059),
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
              color: Color(0xffFE6059), // 빨간색 배경
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
                        // TODO : 1번 사진
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
                      // TODO : 2번 사진
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
            SizedBox(height: SizeConfig.defaultSize * 3,),

        ],
      ),
    );
  }
}

class MakeTeamButton extends StatelessWidget {
  const MakeTeamButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 7.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector(
          onTap: () async {
            AnalyticsUtil.logEvent('과팅_대기_팀만들기버튼_터치');
            await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetCreateTeam(
              onFinish: () {
                // context.read<MeetCubit>().refreshMeetPage();
              },
              state: context.read<MeetCubit>().state,
            ), childCurrent: this)).then((value) async {
              if (value == null) return;
              await context.read<MeetCubit>().createNewTeam(value);
            });
            context.read<MeetCubit>().refreshMeetPage();
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
              child: Text("과팅에 참여할 팀 만들기", style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600
              ),)
          ),
        ),
      ),
    );
  }
}

class SeeMyTeamButton extends StatelessWidget {
  BuildContext ancestorContext;

  SeeMyTeamButton({
    super.key,
    required this.ancestorContext
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
          onTap: () {},
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

class _MiddleSection extends StatelessWidget {
  const _MiddleSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Column(
        children: [
          Container(alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
                child: Text("이전 시즌 후기", style: TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 1.5),),
              )
          ),
            SizedBox(height: SizeConfig.defaultSize * 2),
          Container( // 후기1
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
                  ),
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
                  child: Text("매칭 전에 간단하게 상대 팀 정보를 볼 수 있다는 게\n독특하고 신기했어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize),
          Container( // 후기2
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.zero),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.4),
                    child: Text("제가 프로필을 적은 양 만큼 관심도가 높아지는 것\n같아서 재밌었어요! 매칭도 성공했어요 :)", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4)),
                  )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize),
          Container( // 후기3
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
                    child: Text("팀 개수의 제한이나 매칭 횟수 제한이 없어서 좋아요!\n친구들이랑 과팅하면서 더 친해졌어요ㅎㅎ!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                  )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 4),

          Container(alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
                child: Text("매칭 잘 되는 Tip", style: TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 1.5),),
              )
          ),
            SizedBox(height: SizeConfig.defaultSize * 1.5),
          Container( // 매칭 잘 되는 팁
            alignment: Alignment.center,
            child: Container(alignment: Alignment.centerLeft,
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.defaultSize * 13,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5, vertical: SizeConfig.defaultSize * 1.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" ∙   ‘내정보' 탭에서 받은 투표 중 3개를 프로필에 넣어요!\n     이성에게 나를 더 어필할 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                      Text(" ∙   ‘내정보' 탭에서 프로필 사진을 추가해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                      Text(" ∙   과팅에 같이 참여하고 싶은 친구들을 초대해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                    ],
                  )
                )
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/timeago_util.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/vote_response_dto.dart';

class VoteListView extends StatefulWidget {
  const VoteListView({Key? key}) : super(key: key);

  @override
  State<VoteListView> createState() => _VoteListViewState();
}

class _VoteListViewState extends State<VoteListView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VoteListCubit>(context).initVotes();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // 애니메이션을 반복 실행하도록 설정
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
        child: BlocBuilder<VoteListCubit, VoteListState>(
          builder: (context, state) {
            if (state.votes.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          AnalyticsUtil.logEvent("투표목록_받은투표없음_아이콘터치");
                        },
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _animation.value,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/letter.png',
                                    // color: Colors.indigo,
                                    width: SizeConfig.defaultSize * 30,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("투표목록_받은투표없음_텍스트터치");
                      },
                      child: Text("아직 받은 투표가 없어요!", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600
                      ),),
                    ),
                    SizedBox(height: SizeConfig.defaultSize *2,),
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("투표목록_받은투표없음_텍스트터치");
                      },
                      child: Text("친구들이 나를 투표하면 알림을 줄게요!", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600
                      ),),
                    ),
                    // Container( // TODO HOTFIX : 투표 꿀팁 일단 보류 (넣으면 좋음)
                    //   child: Column(
                    //     children: [
                    //       Text("투표를 많이 받는 꿀팁"),
                    //       Text("Dart에서 이미지게임으로 친구들을 투표하면\n친구들에게 나의 존재를 알릴 수 있어요!\n투표를 하거나 친구들을 많이 초대해서 투표수를 늘려보세요!")
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              );
            }
            return makeList(state.votes);
          },
        ),
      ),
    );
  }

  ListView makeList(List<VoteResponseDto> snapshot) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var vote = snapshot[index];
        var timeago = TimeagoUtil().format(vote.pickedTime!);
        var visited = BlocProvider.of<VoteListCubit>(context).isVisited(vote.voteId!);
        return Column(
          children: [
            dart(
              voteId: vote.voteId!,
              admissionYear: vote.pickedUser!.user!.admissionYear.toString() ?? "",
              gender: vote.pickedUser!.user!.gender ?? "",
              question: vote.question!.content ?? "(알수없음)",
              datetime: timeago,
              isVisited: visited,
              questionId: vote.question!.questionId!
            ),
            SizedBox(height: SizeConfig.defaultSize * 1.4),
          ],
        );
      },
      itemCount: snapshot.length,
    );
  }
}

class dart extends StatelessWidget {
  final int voteId;
  final String admissionYear;
  final String gender;
  final String question;
  final String datetime;
  final bool isVisited;
  final int questionId;

  const dart({
    super.key,
    required this.voteId,
    required this.admissionYear,
    required this.gender,
    required this.question,
    required this.datetime,
    required this.isVisited,
    required this.questionId,
  });

  String getGender(String gender) {
    print(gender);
      if (gender == "FEMALE") return "여";
      if (gender == "MALE") return "남";
      return "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsUtil.logEvent("투표목록_받은투표_받은투표상자", properties: {
          "질문 인덱스": questionId,
          "질문 내용": question,
          "투표한 사람 성별": gender,
          "투표한 사람 학번": admissionYear.substring(2,4),
          "투표한 시간": datetime
        });
        // BlocProvider.of<VoteListCubit>(context).pressedVoteInList(voteId); // TODO : MVP 이후 복구하기 (힌트 & Point가 생겼을 때)
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
        decoration: BoxDecoration(
          border: Border.all(
            width: SizeConfig.defaultSize * 0.06,
            color: isVisited ? Colors.grey : Color(0xff7C83FD),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person_pin_rounded, size: SizeConfig.defaultSize * 4.5, color: Color(0xff7C83FD),),
                SizedBox(width: SizeConfig.defaultSize * 0.7),
                Container(
                  width: SizeConfig.screenWidth * 0.63,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5),
                            children: <TextSpan>[
                              TextSpan(text:'${admissionYear.substring(2,4)}',
                                  style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w600)),
                              TextSpan(text:'학번 ',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                              TextSpan(text:'${getGender(gender)}학생',
                                  style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w600)),
                              TextSpan(text:'이 보냈어요!',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ]
                        ),
                      ),
                      // Text("${admissionYear.substring(2,4)}학번 ${getGender(gender)}학생이 Dart를 보냈어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500,)),
                      SizedBox(height: SizeConfig.defaultSize * 0.5,),
                      Text("$question",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.3
                                * ((question.length <= 25 ? 1 : 1 - ((question.length - 25) * 0.01))),
                                // ((question.length <= 25 ? 1 : 1 - ((question.length - 15) * 0.035))), // 원래 식
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("$datetime", style: TextStyle(fontSize: SizeConfig.defaultSize * 1)),
                SizedBox(width: SizeConfig.defaultSize * 0.5,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dart_flutter/src/presentation/meet/view/meet_my_team_detail.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_other_team_detail.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/config/size_config.dart';
import '../../common/util/analytics_util.dart';
import '../meet/viewmodel/meet_cubit.dart';

class MeetOneTeamCardview extends StatelessWidget { // Component
  final MeetState meetState;
  final bool isMyTeam;

  const MeetOneTeamCardview({super.key, required this.meetState, required this.isMyTeam});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMyTeam) {
          AnalyticsUtil.logEvent("과팅_목록_내팀_터치");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<MeetCubit>(
                create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
                child: const MeetMyTeamDetail(),
              ),
            ),
          );
        } else {
          AnalyticsUtil.logEvent("과팅_목록_이성팀_터치");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<MeetCubit>(
                create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
                child: const MeetOtherTeamDetail(),
              ),
            ),
          );
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 9.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: isMyTeam ? Color(0xffFE6059) : Colors.white
          )
        ),
        child: Padding( // Container 내부 패딩
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            children: [
              Row( // 위층
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("팀 이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                      Text("  21.5세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),)
                    ],
                  ),
                  Text("서울 인천", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 1,),

              Row( // 아래층
                children: [
                  Container(
                    width: SizeConfig.defaultSize * 12,
                    child: Stack(
                      children: [
                        Container( // 버리는 사진
                          width: SizeConfig.defaultSize * 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/profile-mockup3.png',
                              width: SizeConfig.defaultSize * 4, // 이미지 크기
                              height: SizeConfig.defaultSize * 4,
                            ),
                          ),
                        ),
                        for (int i = 2; i >= 0 ; i--)
                          Positioned(
                            left: i * SizeConfig.defaultSize * 3,
                            child: Container(
                              width: SizeConfig.defaultSize * 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  i == 0
                                      ? 'assets/images/profile-mockup.png'
                                      : (i == 1 ? 'assets/images/profile-mockup2.png' : 'assets/images/profile-mockup3.png'), // 이미지 경로를 각 이미지에 맞게 설정
                                  width: SizeConfig.defaultSize * 4, // 이미지 크기
                                  height: SizeConfig.defaultSize * 4,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${meetState.userResponse.university?.name ?? '학교를 불러오지 못했어요'}",
                              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, fontWeight: FontWeight.w600),),
                            if (meetState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                          ],
                        ),
                        Text("${meetState.userResponse.university?.department ?? '학과를 불러오지 못했어요'}",
                          style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, overflow: TextOverflow.ellipsis),)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

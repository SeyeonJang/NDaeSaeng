import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_my_team_detail.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_other_team_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/config/size_config.dart';
import '../../common/util/analytics_util.dart';
import '../meet/viewmodel/meet_cubit.dart';

class MeetOneTeamCardview extends StatelessWidget {
  final BlindDateTeam team;
  final bool isMyTeam;

  const MeetOneTeamCardview({super.key, required this.team, required this.isMyTeam});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMyTeam) {
          AnalyticsUtil.logEvent("과팅_목록_내팀_터치");
          // TODO : My Team Detail View (BlindTeamDetail로 수정하고 주석 풀기)
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider<MeetCubit>(
          //       create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
          //       child: const MeetMyTeamDetail(),
          //     ),
          //   ),
          // );
        } else {
          AnalyticsUtil.logEvent("과팅_목록_이성팀_터치");
          // context.read<MeetCubit>().pressedOneTeam(team.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<MeetCubit>(
                create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
                child: MeetOtherTeamDetail(teamId: team.id),
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
            color: isMyTeam ? Color(0xffFE6059) : Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0,
              blurRadius: 2.0,
              offset: Offset(0,2), // changes position of shadow
            ),
          ],
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
                      Text(team.name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                      Text("  ${(2023-team.averageBirthYear+1).toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),)
                    ],
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.3,
                    // color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Text(team.regions.map((location) => location.name).join(' '),
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, overflow: TextOverflow.ellipsis, color: Colors.grey),
                      maxLines: 1,)
                  ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(team.universityName,
                              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, fontWeight: FontWeight.w600),),
                            Text(" "),
                            if (team.isCertifiedTeam)
                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                          ],
                        ),
                        Container(
                          width: SizeConfig.defaultSize * 24,
                          child: Text(team.teamUsers.map((user) => user.department).toSet().fold('', (previousValue, element) => previousValue.isEmpty ? element : '$previousValue & $element'),
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3, overflow: TextOverflow.ellipsis, color: Color(0xffFE6059), fontWeight: FontWeight.w600),),
                        )
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

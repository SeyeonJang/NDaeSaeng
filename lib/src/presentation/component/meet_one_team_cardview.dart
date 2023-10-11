import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
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
  final int myTeamCount;
  final int myTeamId;

  const MeetOneTeamCardview({Key? key, required this.team, required this.isMyTeam, required this.myTeamCount, required this.myTeamId});
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
                child: MeetMyTeamDetail(teamId: team.id,),
              ),
            ),
          );
        } else {
          AnalyticsUtil.logEvent("과팅_목록_이성팀_터치");
          // context.read<MeetCubit>().pressedOneTeam(team.id);
          if (myTeamCount == 0) {
            ToastUtil.showMeetToast("팀을 만들기 전에는 다른 팀을 볼 수 없어요!", 1);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<MeetCubit>(
                  create: (_) => MeetCubit(),
                  child: MeetOtherTeamDetail(teamId: team.id, myTeamId: myTeamId,),
                ),
              ),
            );
          }
        }
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.92,
        height: SizeConfig.defaultSize * 11.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: isMyTeam ? const Color(0xffFE6059) : Colors.white,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade300,
          //     spreadRadius: 0,
          //     blurRadius: 2.0,
          //     offset: Offset(0,2), // changes position of shadow
          //   ),
          // ],
        ),
        child: Padding( // Container 내부 패딩
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth,
                child: Row( // 위층
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(team.name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600),),
                        Text("  ${(team.averageBirthYear > 1000 ? 2023-team.averageBirthYear+1 : team.averageBirthYear).toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),)
                      ],
                    ),
                    SizedBox(width: SizeConfig.defaultSize * 2.4,),
                    Expanded(
                      child: Text(team.regions.map((location) => location.name).join(' '),
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, overflow: TextOverflow.ellipsis, color: Colors.grey),
                      maxLines: 1,
                      textAlign: TextAlign.end,),),
                    SizedBox(width: SizeConfig.defaultSize * 0.2,),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: SizeConfig.defaultSize * 1.4,),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 1,),

              Row( // 아래층
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.defaultSize * 12,
                    child: Stack(
                      children: [
                        Container( // 버리는 사진
                          width: SizeConfig.defaultSize * 4,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/profile-mockup3.png',
                              width: SizeConfig.defaultSize * 4.5, // 이미지 크기
                              height: SizeConfig.defaultSize * 4.5,
                            ),
                          ),
                        ),
                        for (int i = team.teamUsers.length-1; i >= 0 ; i--)
                          Positioned(
                            left: i * SizeConfig.defaultSize * 3,
                            child: Container(
                              width: SizeConfig.defaultSize * 4.5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Center(
                                  child: team.teamUsers[i].getProfileImageUrl() == "DEFAULT" || !team.teamUsers[i].getProfileImageUrl().startsWith("https://")
                                    ? Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 4.5, height: SizeConfig.defaultSize * 4.5, fit: BoxFit.cover,)
                                    : Image.network(team.teamUsers[i].getProfileImageUrl(), width: SizeConfig.defaultSize * 4.5, height: SizeConfig.defaultSize * 4.5, fit: BoxFit.cover,)
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                    SizedBox(width: SizeConfig.defaultSize,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(team.universityName,
                              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),),
                            const Text(" "),
                            if (team.isCertifiedTeam)
                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                          ],
                        ),
                          SizedBox(height: SizeConfig.defaultSize * 0.3,),
                        SizedBox(
                          width: SizeConfig.defaultSize * 24,
                          child: Text(team.teamUsers.map((user) => user.getDepartment()).toSet().fold('', (previousValue, element) => previousValue.isEmpty ? element : '$previousValue & $element'),
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3, overflow: TextOverflow.ellipsis, color: const Color(0xffFE6059), fontWeight: FontWeight.w600),),
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

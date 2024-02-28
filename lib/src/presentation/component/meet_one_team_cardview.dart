import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/presentation/component/cached_profile_image.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_other_team_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/config/size_config.dart';
import '../../common/util/analytics_util.dart';
import '../meet/viewmodel/meet_cubit.dart';

class MeetOneTeamCardview extends StatefulWidget {
  final BlindDateTeam team;
  final bool isMyTeam;
  final int myTeamCount;
  final int myTeamId;
  bool visible;  // 신고한 팀인 경우 보이지 않게합니다.

  MeetOneTeamCardview({Key? key, required this.team, required this.isMyTeam, required this.myTeamCount, required this.myTeamId, required this.visible});

  @override
  State<MeetOneTeamCardview> createState() => _MeetOneTeamCardviewState();
}

class _MeetOneTeamCardviewState extends State<MeetOneTeamCardview> {
  void setHide() {
    setState(() {
      widget.visible = false;
    });
  }

  void setShow() {
    setState(() {
      widget.visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isMyTeam) {
          AnalyticsUtil.logEvent("과팅_목록_내팀_터치");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<MeetCubit>(
                create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
                // child: MeetMyTeamDetail(teamId: team.id,), // TODO : 과팅 목록에 넣을 거면 인자로 userResponse 추가해야 함
              ),
            ),
          );
        } else {
          AnalyticsUtil.logEvent("과팅_목록_이성팀_터치");
          // context.read<MeetCubit>().pressedOneTeam(team.id);
          if (widget.myTeamCount == 0) {
            ToastUtil.showMeetToast("팀을 만들기 전에는 다른 팀을 볼 수 없어요!", 1);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<MeetCubit>(
                  create: (_) => MeetCubit()..initProposalCount(),
                  child: MeetOtherTeamDetail(teamId: widget.team.id, myTeamId: widget.myTeamId,),
                ),
              ),
            ).then((value) {
              if (value == null) return;
              if (value != '신고') return;
              setHide();  // 신고한 경우 목록에서 보이지 않음
            });
          }
        }
      },
      child: Visibility(
        visible: widget.visible,
        child: Container(
          width: SizeConfig.screenWidth * 0.92,
          height: SizeConfig.defaultSize * 11.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: widget.isMyTeam ? const Color(0xffFE6059) : Colors.white,
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
                          Text(widget.team.name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600),),
                          Text("  ${(widget.team.averageBirthYear > 1000 ? 2023-widget.team.averageBirthYear+1 : widget.team.averageBirthYear).toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),)
                        ],
                      ),
                      SizedBox(width: SizeConfig.defaultSize * 2.4,),
                      Expanded(
                        child: Text(widget.team.regions.map((location) => location.name).join(' '),
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
                          for (int i = widget.team.teamUsers.length-1; i >= 0 ; i--)
                            Positioned(
                              left: i * SizeConfig.defaultSize * 3,
                              child: Container(
                                width: SizeConfig.defaultSize * 4.5,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedProfileImage(
                                  profileUrl: widget.team.teamUsers[i].getProfileImageUrl(),
                                  width: SizeConfig.defaultSize * 4.5,
                                  height: SizeConfig.defaultSize * 4.5,
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
                              Text(widget.team.universityName,
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),),
                              const Text(" "),
                              if (widget.team.isCertifiedTeam)
                                Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                            ],
                          ),
                            SizedBox(height: SizeConfig.defaultSize * 0.3,),
                          SizedBox(
                            width: SizeConfig.defaultSize * 24,
                            child: Text(widget.team.teamUsers.map((user) => user.getDepartment()).toSet().fold('', (previousValue, element) => previousValue.isEmpty ? element : '$previousValue & $element'),
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
      ),
    );
  }
}

// class CachedProfileImage extends StatelessWidget {
//   const CachedProfileImage({
//     super.key,
//     required this.profileUrl,
//     this.width = 4.5,
//     this.height = 4.5
//   });
//
//   final String profileUrl;
//   final double width;
//   final double height;
//
//   Image defaultProfile() => Image.asset(
//     'assets/images/profile-mockup3.png',
//     width: width,
//     height: height,
//     fit: BoxFit.cover,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipOval(
//       child: Center(
//         child: profileUrl == "DEFAULT" || !profileUrl.startsWith("https://")
//           ? defaultProfile()
//           : CachedNetworkImage(
//               imageUrl: profileUrl,
//               placeholder: (context, url) => defaultProfile(),
//               width: width,
//               height: height,
//               fit: BoxFit.cover,
//               cacheManager: CustomCacheManager.instance,
//           )
//       ),
//     );
//   }
// }

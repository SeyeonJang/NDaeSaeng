import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/component/banner_image_slider.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team_input.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_my_team_detail.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/view/student_vertification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import '../viewmodel/state/meet_state.dart';
import 'package:flutter/foundation.dart' as foundation;

class MeetIntro extends StatelessWidget {
  const MeetIntro({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsUtil.logEvent('홈_접속');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            return BodySection(state: state,);
          }
        ),
      ),

      bottomNavigationBar:
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context,state) {
            return state.isLoading
                ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.defaultSize * 6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey.shade400,
                      child: Text("내 정보를 불러오고 있어요!",
                          style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600)),
                    ),
                  ),
                )
                : state.myTeams.isEmpty ? MakeTeamButton(ancestorContext: context) : SeeMyTeamButton(ancestorContext: context, teamId: state.myTeams[0].id, userResponse: state.userResponse,);
          }
        )
    );
  }
}

class BodySection extends StatelessWidget {
  MeetState state;

  BodySection({
    super.key,
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          SizedBox(height: SizeConfig.defaultSize * 2,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
          child: Row(
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
        ),
          SizedBox(height: SizeConfig.defaultSize * 0.9,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
          child: Row(
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
        ),
          SizedBox(height: SizeConfig.defaultSize * 0.9,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
          child: Row(
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
        ),
          SizedBox(height: SizeConfig.defaultSize * 2,),
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            final bannerList = BlocProvider.of<MeetCubit>(context).getBannerList();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13.0),
                child: BannerImageSlider(
                  bannerList: bannerList,
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: SizeConfig.defaultSize * 2,
        ),

        Container(
          color: const Color(0xffFE6059).withOpacity(0.1),
          height: SizeConfig.defaultSize * 30,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5, vertical: SizeConfig.defaultSize * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: SizeConfig.defaultSize * 2.8,
                        height: SizeConfig.defaultSize * 2.8,
                        color: const Color(0xffFE6059),
                        child: Center(
                          child: Text('1', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 1.6
                            ),
                          ),
                        ),
                      ),
                    ),
                      SizedBox(width: SizeConfig.defaultSize * 1.5,),
                    Text("팀명, 만나고 싶은 지역, 팀원 정보를 입력한다", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                  SizedBox(height: SizeConfig.defaultSize * 3,),
                Container(color: Colors.grey.shade100, child: Image.asset('assets/images/meet_intro.png',))
              ],
            ),
          ),
        ),
          // SizedBox(height: SizeConfig.defaultSize * 5,),

        SizedBox(
          height: SizeConfig.defaultSize * 30,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5, vertical: SizeConfig.defaultSize * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: SizeConfig.defaultSize * 2.8,
                        height: SizeConfig.defaultSize * 2.8,
                        color: const Color(0xffFE6059),
                        child: Center(
                          child: Text('2', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 1.6
                          ),
                          ),
                        ),
                      ),
                    ),
                      SizedBox(width: SizeConfig.defaultSize * 1.5,),
                    Text("마음에 드는 팀에게 호감을 보낸다", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                  SizedBox(height: SizeConfig.defaultSize * 3,),
                Image.asset('assets/images/likesend.png',)
              ],
            ),
          ),
        ),

        Container(
          color: const Color(0xffFE6059).withOpacity(0.1),
          height: SizeConfig.defaultSize * 30,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5, vertical: SizeConfig.defaultSize * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: SizeConfig.defaultSize * 2.8,
                        height: SizeConfig.defaultSize * 2.8,
                        color: const Color(0xffFE6059),
                        child: Center(
                          child: Text('3', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 1.7
                          ),
                          ),
                        ),
                      ),
                    ),
                      SizedBox(width: SizeConfig.defaultSize * 1.5,),
                    Text("상대 팀도 호감을 수락하면 채팅 시작!", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                  SizedBox(height: SizeConfig.defaultSize * 3,),
                Container(
                  height: SizeConfig.defaultSize * 17,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.defaultSize * 26,
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
                              width: SizeConfig.defaultSize * 28,
                              height: SizeConfig.defaultSize * 3.5,
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
              ],
            ),
          ),
        ),

          SizedBox(height: SizeConfig.defaultSize * 4),
        Container(
          width: SizeConfig.screenWidth,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("인기 많은 팀이 되고 싶은가요?", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.6,
                  fontWeight: FontWeight.w500),),
                  SizedBox(height: SizeConfig.defaultSize * 2,),

                Text("Tip 1.", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, color: Colors.grey),),
                  SizedBox(height: SizeConfig.defaultSize,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                          SizedBox(height: SizeConfig.defaultSize * 0.5,),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                                style: TextStyle(color: Colors.grey),
                                children: <TextSpan>[
                                  TextSpan(text: "내정보 탭에서 "),
                                  TextSpan(text: "학생증 인증", style: TextStyle(color: Colors.black)),
                                  TextSpan(text: "을 하면",),
                                  TextSpan(text: "\n내 팀에 인증 배지가 붙어요!",),
                                ]
                            )
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          AnalyticsUtil.logEvent("홈_학생증인증버튼_터치", properties: {
                            '인증 상태' : state.userResponse.personalInfo?.verification
                          });
                          if (!(state.userResponse.personalInfo?.verification.isVerificationSuccess ?? true)) {
                            await Navigator.push(context, MaterialPageRoute(builder: (_) => StudentVertification(
                              userResponse: state.userResponse,
                            )));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5, vertical: SizeConfig.defaultSize),
                            child: Text((state.userResponse.personalInfo?.verification.isVerificationSuccess ?? false) ? "인증 완료!" : "학생증 인증", style: const TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                  SizedBox(height: SizeConfig.defaultSize * 1.5,),

                Text("Tip 2.", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, color: Colors.grey),),
                  SizedBox(height: SizeConfig.defaultSize,),
                RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(text: "상대에게 보이는 "),
                          TextSpan(text: "내 사진과 닉네임", style: TextStyle(color: Colors.black)),
                          TextSpan(text: "을 ",),
                          TextSpan(text: "내정보 탭 - 설정", style: TextStyle(color: Colors.black)),
                          TextSpan(text: " 바꿀 수 있어요!",),
                        ]
                    )
                ),
                // const Text("상대에게 보이는 내 사진과 닉네임을 내정보 탭 - 설정에서 바꿀 수 있어요!", style: TextStyle(color: Colors.grey), textAlign: TextAlign.left,),
                  SizedBox(height: SizeConfig.defaultSize * 1.5,),

                Text("Tip 3.", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, color: Colors.grey),),
                SizedBox(height: SizeConfig.defaultSize,),
                RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(text: "팀을 만들 때 "),
                          TextSpan(text: "친구 사진", style: TextStyle(color: Colors.black)),
                          TextSpan(text: "을 추가하면 호감 받을 확률 UP!",),
                        ]
                    )
                ),
                // const Text("팀을 만들 때 친구 사진을 추가하면 호감 받을 확률 UP!", style: TextStyle(color: Colors.grey), textAlign: TextAlign.left,),
                SizedBox(height: SizeConfig.defaultSize * 1.5,),

                SizedBox(height: SizeConfig.defaultSize * 3,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MakeTeamButton extends StatelessWidget {
  BuildContext ancestorContext;

  MakeTeamButton({
    super.key,
    required this.ancestorContext
  });

  // Future<void> checkNotificationPermission() async {
  //   var status = await Permission.notification.status;
  //   // if (status.isDenied || status.isLimited) {
  //   //   var result = await Permission.notification.request(); // 권한이 아직 설정되지 않은 경우 권한 요청 다이얼로그를 표시
  //   //   AnalyticsUtil.logEvent('푸시알림_접속');
  //   //   if (result.isGranted) {
  //   //     ToastUtil.showMeetToast('이성이 호감을 보내면 알려드릴게요!', 1);
  //   //   } else {
  //   //     ToastUtil.showMeetToast('기기 설정에서도 알림을 동의할 수 있어요!', 1);
  //   //   }
  //   // }
  //   // else if (status.isPermanentlyDenied || status.isRestricted) {
  //   if (!status.isGranted) {
  //     ToastUtil.showMeetToast('알림 동의를 해야 받은 호감, 채팅 알림이 와요!\n설정으로 이동할게요!', 1);
  //     await Future.delayed(const Duration(milliseconds: 2100));
  //     AnalyticsUtil.logEvent('푸시알림미동의_기기설정_접속');
  //     openAppSettings();
  //   }
  // }

  bool get isiOS => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    Future<void> checkNotificationPermission(BuildContext ancestorContext) async {
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        AnalyticsUtil.logEvent('홈_팀만들기완료_푸시알림미동의_다이얼로그_접속');
        showDialog(
            barrierDismissible: true,
            context: ancestorContext,
            builder: (BuildContext dialogContext) => AlertDialog(
              surfaceTintColor: Colors.white,
              title: Center(
                  child: Text(
                    '알림 동의를 해야 받은 호감, 채팅 알림이 와요!',
                    style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.5,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )
              ),
              content: SizedBox(
                width: SizeConfig.screenWidth * 0.8,
                height: isiOS ? SizeConfig.screenHeight * 0.4 : SizeConfig.screenHeight * 0.45,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Image.asset(isiOS ? 'assets/images/iOS_push_1.png' :'assets/images/AOS_push_1.jpeg'),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                      Image.asset(isiOS ? 'assets/images/iOS_push_2.png' :'assets/images/AOS_push_2.jpeg'),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    AnalyticsUtil.logEvent("홈_팀만들기완료_푸시알림미동의_다이얼로그_기기설정_접속");
                    openAppSettings();
                    Navigator.of(ancestorContext).pop();
                  },
                  child: Text('설정가기', style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.7,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffFE6059)),),
                ),
              ],
            )
        );
      }
    }

    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 12,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector(
          onTap: () async {
            // await checkNotificationPermission();
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
              await checkNotificationPermission(ancestorContext);
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
  final User userResponse;

  const SeeMyTeamButton({
    super.key,
    required this.ancestorContext,
    required this.teamId,
    required this.userResponse
  });

  bool get isiOS => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    Future<void> checkNotificationPermission() async {
      var status = await Permission.notification.status;
      // if (status.isDenied || status.isLimited) {
      //   var result = await Permission.notification.request(); // 권한이 아직 설정되지 않은 경우 권한 요청 다이얼로그를 표시
      //   AnalyticsUtil.logEvent('푸시알림_접속');
      //   if (result.isGranted) {
      //     ToastUtil.showMeetToast('이성이 호감을 보내면 알려드릴게요!', 1);
      //   } else {
      //     ToastUtil.showMeetToast('기기 설정에서도 알림을 동의할 수 있어요!', 1);
      //   }
      // }
      // if (status.isPermanentlyDenied || status.isRestricted) {
      if (!status.isGranted) {
        AnalyticsUtil.logEvent('홈_내팀보기터치_푸시알림미동의_다이얼로그_접속');
        await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            surfaceTintColor: Colors.white,
            title: Center(
              child: Text('알림 동의를 해야 받은 호감, 채팅 알림이 와요!',
                style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.5,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )
            ),
            content: SizedBox(
              width: SizeConfig.screenWidth * 0.8,
              height: isiOS ? SizeConfig.screenHeight * 0.4 : SizeConfig.screenHeight * 0.45,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Image.asset(isiOS ? 'assets/images/iOS_push_1.png' :'assets/images/AOS_push_1.jpeg'),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                    Image.asset(isiOS ? 'assets/images/iOS_push_2.png' :'assets/images/AOS_push_2.jpeg'),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("홈_내팀보기터치_푸시알림미동의_다이얼로그_기기설정_접속");
                  openAppSettings();
                  Navigator.of(context).pop();
                },
                child: Text('설정가기', style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.7,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffFE6059)),),
              ),
            ],
          )
        );
      }
    }

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 7.8,
      color: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector( // 내 팀 보기 버튼 *******
          onTap: () async {
            await checkNotificationPermission();
            AnalyticsUtil.logEvent('홈_내팀보기버튼_터치');

            Navigator.push(
              ancestorContext,
              MaterialPageRoute(
                builder: (context) => BlocProvider<MeetCubit>(
                  create: (_) => MeetCubit(), // Replace with your MeetCubit instantiation.
                  child: MeetMyTeamDetail(teamId: teamId, userResponse: userResponse,),
                ),
              ),
            ).then((value) async {
              if (value == null) return;
              ancestorContext.read<MeetCubit>().initMeetIntro();
            });
          },
          child:
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 6,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white
              ),
              color: const Color(0xffFE6059),
              borderRadius: BorderRadius.circular(13),
            ),
            child:
            Text("내 팀 보기",
                style: TextStyle(
                  color: Colors.white,
                  fontSize : SizeConfig.defaultSize * 2,
                  fontWeight : FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

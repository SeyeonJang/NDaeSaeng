import 'dart:io';
import 'dart:math';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/common/util/university_finder.dart';
import 'package:dart_flutter/src/domain/entity/ghost_friend.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';
import 'package:dart_flutter/src/presentation/component/meet_create_cardview_novote.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entity/university.dart';
import '../../component/webview_fullscreen.dart';

class MeetCreateTeamInput extends StatefulWidget {
  final VoidCallback onFinish;
  final MeetState state;
  final BuildContext ancestorContext;

  const MeetCreateTeamInput({super.key, required this.onFinish, required this.state, required this.ancestorContext});

  @override
  State<MeetCreateTeamInput> createState() => _MeetCreateTeamInputState();
}

class _MeetCreateTeamInputState extends State<MeetCreateTeamInput> {
  String name = '';
  late MeetState state;
  late List<GhostFriend> teamMemberList;
  late int teamMemberCount;
  late List<Location> cities;
  late bool canMatchWithSameUniversity;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.logEvent("홈_팀만들기_접속");
    state = widget.state;
    teamMemberList = [];
    teamMemberCount = 0;
    cities = [
      Location(id: 1, name: "경기"),
      Location(id: 6, name: "서울")
    ];
    canMatchWithSameUniversity = false;
    scrollController = ScrollController();
  }

  void removeFriendFromMyTeam(int memberIndex) {
    state.minusTeamCount();
    setState(() {
      teamMemberCount = state.teamCount;
      teamMemberList.removeAt(memberIndex);
    });
  }

  void setCities(List<Location> cities) {
    setState(() {
      this.cities = cities;
    });
  }

  void setCanMatchWithSameUniversity(bool canMatchWithSameUniversity) {
    setState(() {
      this.canMatchWithSameUniversity = canMatchWithSameUniversity;
    });
  }

  void setTeamMemberName(int memberIndex, String name) {
    setState(() {
      teamMemberList[memberIndex].name = name;
    });
  }

  void setTeamMemberbirthYear(int memberIndex, String birthYear) {
    if (birthYear.isEmpty) {
      setState(() {
        teamMemberList[memberIndex].birthYear = 0;
      });
      return;
    }
    int birthYearInt = int.parse(birthYear);
    if (birthYearInt < 70) {  // 70을 기준으로 년도 반환
      birthYearInt += 2000;
    } else {
      birthYearInt += 1900;
    }
    setState(() {
      teamMemberList[memberIndex].birthYear = birthYearInt;
    });
  }

  void setTeamMemberUniversityId(int memberIndex, int universityId) {
    setState(() {
      teamMemberList[memberIndex].universityId = universityId;
    });
  }

  void setTeamMemberProfile(int memberIndex, String profile) {
    setState(() {
      teamMemberList[memberIndex].profileImageUrl = profile;
    });
  }

  MeetTeam createNewTeam() {
    return MeetTeam(
      id: 0,
      name: name,
      members: teamMemberList,
      locations: cities,
      canMatchWithSameUniversity: canMatchWithSameUniversity ? false : true,
      university: state.userResponse.university
    );
  }

  void handleTeamNameChanged(String newName) {
    setState(() {
      name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    Future<bool> onBackKey() async {
      return await showDialog(
        context: context,
        builder: (BuildContext sheetContext) {
          return GestureDetector(
            child: AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: Text("팀 만들기를 종료하시겠어요?", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: const Text('취소', style: TextStyle(color: Color(0xffFF5C58))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                    widget.onFinish();
                  },
                  child: const Text('끝내기', style: TextStyle(color: Color(0xffFF5C58))),
                )
              ],
            ),
          );
        }
        );
    }

    return WillPopScope(
      onWillPop: () async {
        AnalyticsUtil.logEvent("홈_팀만들기_뒤로가기_윌팝스코프");
        await onBackKey();
        // if (context.mounted) Navigator.pop(context, true);
        Navigator.pop(context, true);
        return true;
      },
      child: state.isLoading
          ? Scaffold(
              appBar: AppBar(),
              body: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Color(0xffFE6059)),
                      SizedBox(height: SizeConfig.defaultSize * 5,),
                    Text("팀을 만들어볼까요? ✋🏻", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),)
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.3),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.defaultSize),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    AnalyticsUtil.logEvent("홈_팀만들기_뒤로가기_터치");
                                    await onBackKey();
                                    // if (context.mounted) Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                      size: SizeConfig.defaultSize * 2)),
                              Text("과팅 팀 만들기",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: SizeConfig.defaultSize * 2,
                                  )),
                            ]),
                        SizedBox(height: SizeConfig.defaultSize * 1.5),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.3),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  _CreateTeamTopSection(userResponse: state.userResponse, handleTeamNameChanged: handleTeamNameChanged, state: state),
                                  // 나
                                    SizedBox(height: SizeConfig.defaultSize),
                                  MeetCreateCardviewNovote(
                                      userResponse: BlindDateUserDetail(id: state.userResponse.personalInfo?.id ?? 0, name: state.userResponse.personalInfo?.name ?? '(알수없음)', profileImageUrl: state.userResponse.personalInfo?.profileImageUrl ?? 'DEFAULT', department: state.userResponse.university?.department ?? '(알수없음)', isCertifiedUser: (state.userResponse.personalInfo?.verification.isVerificationSuccess ?? false) ? true : false, birthYear: state.userResponse.personalInfo?.birthYear ?? 0, profileQuestionResponses: state.userResponse.titleVotes),
                                      university: state.userResponse.university?.name ?? '(알수없음)'
                                  ),
                                    SizedBox(height: SizeConfig.defaultSize),
                                  // MemberCardView(userResponse: state.userResponse, state: state, isMyself: true, onRemoveFriend: removeFriendFromMyTeam),
                                  // 친구1
                                  teamMemberCount >= 1
                                      ? MemberCardViewNoVote(context: widget.ancestorContext, state: state, isMyself: false, onRemoveFriend: removeFriendFromMyTeam, memberIndex: 0, onSetTeamMemberName: setTeamMemberName, onSetTeamMemberBirthYear: setTeamMemberbirthYear, onSetTeamMemberUniversityId: setTeamMemberUniversityId, onSetTeamMemberProfile: setTeamMemberProfile,)
                                      : Container(),
                                  // 친구2
                                  teamMemberCount == 2
                                      ? MemberCardViewNoVote(context: widget.ancestorContext, state: state, isMyself: false, onRemoveFriend: removeFriendFromMyTeam, memberIndex: 1, onSetTeamMemberName: setTeamMemberName, onSetTeamMemberBirthYear: setTeamMemberbirthYear, onSetTeamMemberUniversityId: setTeamMemberUniversityId, onSetTeamMemberProfile: setTeamMemberProfile)
                                      : Container(),
                                  // 버튼
                                  teamMemberCount == 2
                                      ? Container()
                                      : InkWell( // 팀원 추가하기 버튼 *******
                                        onTap: () {
                                            AnalyticsUtil.logEvent("홈_팀만들기_팀원추가하기버튼_터치");
                                            state.addTeamCount();
                                            setState(() {
                                              teamMemberCount = teamMemberCount + 1;
                                              teamMemberList.add(GhostFriend());
                                            });
                                          // _ShowModalBottomSheet(context, friendsList);
                                        },
                                        child: Container(
                                            width: SizeConfig.screenWidth,
                                            height: SizeConfig.defaultSize * 6,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child:

                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(Icons.add, size: SizeConfig.defaultSize * 1.9, color: Colors.black),
                                                  ),
                                                  TextSpan(
                                                    text: "   내 친구 입력하기",
                                                    style: TextStyle(color: Colors.black, fontSize: SizeConfig.defaultSize * 1.6),
                                                  ),
                                                ],
                                              ),
                                            )
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize * 1),
                                  Text("같은 학교 친구 최소 1명~2명을 입력하면 돼요!", style: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.6)),
                                  SizedBox(
                                    height: isKeyboardVisible ? 100.0 : 0.0, // 키보드가 켜져 있을 때만 SizedBox를 올립니다.
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
            bottomNavigationBar:  _CreateTeamBottomSection(
                onFinish: widget.onFinish,
                serverLocations: state.serverLocations,
                locations: cities,
                state: state,
                name: name,
                ancestorContext: context,
                onSetCities: setCities,
                onSetMatch: setCanMatchWithSameUniversity,
                createNewTeam: createNewTeam),
            ),
      );
  }
}

class _CreateTeamTopSection extends StatefulWidget {
  User userResponse;
  MeetState state;
  final handleTeamNameChanged;

  _CreateTeamTopSection({
    super.key,
    required this.userResponse,
    required this.state,
    this.handleTeamNameChanged
  });
  @override
  State<_CreateTeamTopSection> createState() => _CreateTeamTopSectionState();
}

class _CreateTeamTopSectionState extends State<_CreateTeamTopSection> {
  // textfield
  late TextEditingController _controller;

  void onTeamNameChanged(String value) {
    (value);
    widget.state.teamName = value;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [

            // // 학교 Display
            // GestureDetector(
            //   onTap: () {
            //     // AnalyticsUtil.logEvent("홈_팀만들기_학교_터치");
            //   },
            //   child: Row(children: [
            //     Text("학교",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: SizeConfig.defaultSize * 1.6,
            //             color: Colors.grey
            //         )),
            //     SizedBox(width: SizeConfig.defaultSize,),
            //     Text(widget.userResponse.university?.name ?? '학교를 불러오지 못 했어요',
            //         style: TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: SizeConfig.defaultSize * 1.6,
            //             color: Colors.grey
            //         ))
            //   ]),
            // ),
            //   SizedBox(height: SizeConfig.defaultSize * 0.5),

            GestureDetector(
              onTap: () {
                // AnalyticsUtil.logEvent("홈_팀만들기_팀명_터치");
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("팀명", style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.defaultSize * 1.6,
                            color: Colors.black)
                        ),
                        const _MeetCreateTeamInformationButton(),



                  ]),

                  TextFormField(
                      controller: _controller,
                      maxLength: 7,
                        onChanged: (value) {
                          setState(() {
                            AnalyticsUtil.logEvent("홈_팀만들기_팀명_입력", properties: {
                              '팀명': value
                            });
                            widget.state.teamName = value;
                            widget.handleTeamNameChanged(value);
                          });
                        },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                      ],
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color(0xffFF5C58), // 테두리 색상
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFF5C58), // 테두리 색상
                              width: 2.0,
                            ),
                          ),
                          hintText: "팀명을 입력해주세요! (최대 7글자)",
                          counterText: '',
                      ),
                  ),
                ],
              ),
            ),
              SizedBox(height: SizeConfig.defaultSize),
          ],
        )
      ],
    );
  }
}

class MemberCardView extends StatelessWidget {
  late User userResponse;
  late MeetState state;
  late bool isMyself;

  final void Function(User friend) onRemoveFriend;

  MemberCardView({
    super.key,
    required this.userResponse,
    required this.state,
    required this.isMyself,
    required this.onRemoveFriend
  });

  String get profileImageUrl => userResponse.personalInfo?.profileImageUrl ?? 'DEFAULT';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.8),
      child: Container( // 카드뷰 시작 *****************
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 21.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffFF5C58).withOpacity(0.5),
            width: 1.5
          )
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
                          AnalyticsUtil.logEvent("홈_팀만들기_카드_프사_터치");
                        },
                        child: profileImageUrl == "DEFAULT"
                            ? ClipOval(
                              child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 6.2, fit: BoxFit.cover,),
                              )
                            : ClipOval(
                              child: Image.network(profileImageUrl,
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
                          SizedBox(
                            height: SizeConfig.defaultSize * 3.3,
                            child: Row( // 위층 (이름 ~ 년생)
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: SizeConfig.defaultSize * 26,
                                  height: SizeConfig.defaultSize * 3.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          AnalyticsUtil.logEvent("홈_팀만들기_카드_정보_터치", properties: {
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
                                                    ? '${userResponse.personalInfo?.name}'
                                                    : (userResponse.personalInfo?.nickname ?? '친구 닉네임'),
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
                                      if (!isMyself)
                                        GestureDetector(
                                          onTap: () {
                                            AnalyticsUtil.logEvent("과팅_팀만들기_카드_더보기_터치", properties: {
                                            'nickname': userResponse.personalInfo?.nickname ?? "닉네임없음",
                                            'birthYear': userResponse.personalInfo?.birthYear.toString().substring(2,4)??"??",
                                            'verification': userResponse.personalInfo?.verification.isVerificationSuccess.toString() ?? "false"
                                            });
                                          },
                                          child: PopupMenuButton<String>(
                                            icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                                            color: Colors.white,
                                            surfaceTintColor: Colors.white,
                                            padding: EdgeInsets.zero,
                                            onSelected: (value) {
                                              // 팝업 메뉴에서 선택된 값 처리
                                              if (value == 'remove') {
                                                onRemoveFriend(userResponse);
                                              }

                                              AnalyticsUtil.logEvent("과팅_팀만들기_카드_더보기_삭제_터치", properties: {
                                                'nickname': userResponse.personalInfo?.nickname ?? "닉네임없음",
                                                'birthYear': userResponse.personalInfo?.birthYear.toString().substring(2,4)??"??",
                                                'verification': userResponse.personalInfo?.verification.isVerificationSuccess.toString() ?? "false"
                                              });
                                            },
                                            itemBuilder: (BuildContext context) {
                                              return [
                                                PopupMenuItem<String>(
                                                  value: 'remove',
                                                  child: Text("삭제하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                                                ),
                                              ];
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row( // 2층
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                  SizedBox(
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
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // TODO : 받은 투표가 있다면 VoteView, 없으면 NoVoteView
              SizedBox(
                height: SizeConfig.defaultSize * 11.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      userResponse.titleVotes.length > i ?
                      VoteView(userResponse.titleVotes[i].question.content ?? "(알수없음)", userResponse.titleVotes[i].count) :
                      const NoVoteView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _MeetCreateTeamInformationButton extends StatelessWidget {
  const _MeetCreateTeamInformationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          AnalyticsUtil.logEvent("과팅_팀만들기_도움말_터치");
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewFullScreen(url: 'https://efficacious-ease-5ad.notion.site/76aca6b7945e4db485069f921deb961e?pvs=4', title: '팀 만들기 도움말')))
          .then((_) {
            AnalyticsUtil.logEvent("과팅_팀만들기_도움말_뒤로가기(팀만들기접속)");
          });
          // showDialog<String>(
          //     context: context,
          //     builder: (BuildContext dialogContext) => AlertDialog(
          //       surfaceTintColor: Colors.white,
          //       title: Center(
          //           child: Text(
          //             '과팅 팀을 등록해봐요!',
          //             style: TextStyle(
          //                 fontSize: SizeConfig.defaultSize * 1.5,
          //                 fontWeight: FontWeight.w500),
          //           )),
          //       content: SingleChildScrollView(
          //         child: ListBody(
          //           children: <Widget>[
          //             SizedBox(
          //               height: SizeConfig.defaultSize,
          //             ),
          //             const Center(child: Text('이성에게 보여질 팀명을 입력해주세요.',)),
          //             const Center(child: Text('팀원은 최소 2명! 내 친구 정보를 입력해주세요.')),
          //             const Center(child: Text('친구의 프사, 이름, 년생과 학과만 있으면 되요!')),
          //             SizedBox(
          //               height: SizeConfig.defaultSize * 2.2,
          //             ),
          //             Center(
          //                 child: Text(
          //                   '',
          //                   style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2),
          //                 )),
          //             Center(
          //                 child: Text(
          //                   'Tip. 학생증 인증을 하면 인증뱃지가 추가됩니다',
          //                   style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2),
          //                 )),
          //           ],
          //         ),
          //       ),
          //     ));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.white, surfaceTintColor: Colors.white),
        child:
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.info_outline, size: SizeConfig.defaultSize * 1.5, color: Color(0xff2F4858)),
              ),
              TextSpan(
                text: " 도움말",
                style: TextStyle(color: Color(0xff2F4858), fontSize: SizeConfig.defaultSize * 1.4),
              ),
            ],
          ),
        )
    );
  }
}


class MemberCardViewNoVote extends StatefulWidget {
  late BuildContext context;
  late MeetState state;
  late bool isMyself;
  final void Function(int memberIndex) onRemoveFriend;

  late int memberIndex;
  final void Function(int memberIndex, String name) onSetTeamMemberName;
  final void Function(int memberIndex, String birthYear) onSetTeamMemberBirthYear;
  final void Function(int memberIndex, int universityId) onSetTeamMemberUniversityId;
  final void Function(int memberIndex, String profile) onSetTeamMemberProfile;
  String name = '';
  String profileImageUrl = 'DEFAULT';

  MemberCardViewNoVote({
    super.key,
    required this.context,
    required this.state,
    required this.isMyself,
    required this.onRemoveFriend,
    required this.memberIndex,
    required this.onSetTeamMemberName,
    required this.onSetTeamMemberBirthYear,
    required this.onSetTeamMemberUniversityId,
    required this.onSetTeamMemberProfile
  });

  @override
  State<MemberCardViewNoVote> createState() => _MemberCardViewNoVoteState();
}

class _MemberCardViewNoVoteState extends State<MemberCardViewNoVote> {
  late UniversityFinder universityFinder;
  final TextEditingController _typeAheadController = TextEditingController();
  late bool isSelectedOnTypeAhead = false;
  late String universityName;
  String universityDepartment = "";
  late University university;

  // textField 생년
  late TextEditingController _controller;
  late TextEditingController _nameController;
  final String _userPostfix = "년생";
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(); // 이름
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Move the cursor before the postfix when the TextField gains focus.
        _controller.selection =
            TextSelection.collapsed(offset: max(0, _controller.text.length - _userPostfix.length));
      }
    });
    _controller = TextEditingController(); // 생년
    // 학과
    List<University> universities = widget.state.universities;
    universityFinder = UniversityFinder(universities: universities);
    universityName = widget.state.userResponse.university?.name ?? '(알수없음)';
    setState(() {
      isSelectedOnTypeAhead = false;
    });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _nameController.dispose();
    _focusNode.dispose();
  }

  // 프로필 사진
  File? _selectedImage;
  bool isSelectImage = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
    }
    String url = 'DEFAULT';
    url = await widget.context.read<MeetCubit>().uploadProfileImage(_selectedImage!, widget.state.userResponse.personalInfo?.id ?? 0, widget.memberIndex.toString());

    // AnalyticsUtil.logEvent("내정보_설정_프로필사진터치");
    if (pickedFile != null) {
      setState(() {
        // AnalyticsUtil.logEvent("내정보_설정_프로필사진변경");
        widget.profileImageUrl = url;
        widget.onSetTeamMemberProfile(widget.memberIndex, url);
        isSelectImage = true;
        widget.context.read<MeetCubit>().setProfileImage(_selectedImage!);
      });
      AnalyticsUtil.logEvent('홈_팀만들기_친구사진입력', properties: {
        '친구 인덱스': widget.memberIndex
      });
    }
  }

  // 학과 입력
  void _typeOnTypeAhead() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_typeAheadController.text.isNotEmpty) {
        setState(() {
          isSelectedOnTypeAhead = false;
        });
      }
    });
  }
  void _selectOnTypeAhead() {
    setState(() {
      isSelectedOnTypeAhead = true;
      AnalyticsUtil.logEvent("홈_팀만들기_친구학과선택");
    });
  }
  void _setUniversity(University university) {
    _setUniversityDepartment(university.department);
    this.university = university;
    widget.onSetTeamMemberUniversityId(widget.memberIndex, university.id);
  }
  void _setUniversityDepartment(String name) {
    universityDepartment = name;
    _typeAheadController.text = name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.8),
      child: Container( // 카드뷰 시작 *****************
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color(0xffFF5C58).withOpacity(0.5),
                width: 1.5
            )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AnalyticsUtil.logEvent('홈_팀만들기_친구사진입력터치', properties: {
                        '친구 인덱스': widget.memberIndex
                      });
                      _pickImage();
                    },
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                          child: isSelectImage
                              ? ClipOval(
                              child: Image.file( // 이미지 파일에서 고르는 코드
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: SizeConfig.defaultSize * 9,
                                height: SizeConfig.defaultSize * 9,
                              ))
                              : ClipOval(
                            child: Container(
                            color: Colors.grey.shade200,
                              width: SizeConfig.defaultSize * 9,
                              height: SizeConfig.defaultSize * 9,
                              alignment: Alignment.center,
                              child: const Icon(Icons.add_rounded),
                            ),
                          )
                      ),
                    ),
                  ),
                    SizedBox(width: SizeConfig.defaultSize * 1.2),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5),),
                          SizedBox(width: SizeConfig.defaultSize,),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.44,
                            height: SizeConfig.defaultSize * 5,
                            child: Column(
                              children: [
                                SizedBox(height: SizeConfig.defaultSize * 1.3,),
                                TextField(
                                  controller: _nameController,
                                  maxLength: 7,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.name = value;
                                      widget.onSetTeamMemberName(widget.memberIndex, value);
                                    });
                                    AnalyticsUtil.logEvent("홈_팀만들기_친구이름입력", properties: {
                                      '친구 인덱스': widget.memberIndex
                                    });
                                  },
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "친구 이름/닉네임",
                                      hintStyle: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Colors.grey.shade500),
                                      contentPadding: EdgeInsets.only(bottom: SizeConfig.defaultSize),
                                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 0.6)),
                                      counterText: ''
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // if (!widget.isMyself)
                          //   GestureDetector(
                          //     onTap: () {},
                          //     child: PopupMenuButton<String>(
                          //       icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                          //       color: Colors.white,
                          //       surfaceTintColor: Colors.white,
                          //       padding: EdgeInsets.zero,
                          //       onSelected: (value) {
                          //         // 팝업 메뉴에서 선택된 값 처리
                          //         if (value == 'remove') {
                          //           widget.onRemoveFriend(widget.memberIndex);
                          //         }
                          //         // AnalyticsUtil.logEvent("과팅_팀만들기_카드_더보기_삭제_터치", properties: {
                          //         //   'nickname': userResponse.personalInfo?.nickname ?? "닉네임없음",
                          //         //   'birthYear': userResponse.personalInfo?.birthYear.toString().substring(2,4)??"??",
                          //         //   'verification': userResponse.personalInfo?.verification.isVerificationSuccess.toString() ?? "false"
                          //         // });
                          //       },
                          //       itemBuilder: (BuildContext context) {
                          //         return [
                          //           PopupMenuItem<String>(
                          //             value: 'remove',
                          //             child: Text("삭제하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                          //           ),
                          //         ];
                          //       },
                          //     ),
                          //   ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("생년", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5),),
                          SizedBox(width: SizeConfig.defaultSize,),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.44,
                            height: SizeConfig.defaultSize * 5,
                            child: Column(
                              children: [
                                SizedBox(height: SizeConfig.defaultSize * 1.3),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  maxLength: 2 + _userPostfix.length, // Increase the max length to accommodate the postfix.
                                  onChanged: (value) {
                                    if (!value.endsWith(_userPostfix)) {
                                      // If the value does not end with '_userPostfix', add it.
                                      value = value + _userPostfix;
                                      _controller.text = value;
                                      // Move the cursor before the postfix.
                                      _controller.selection =
                                          TextSelection.collapsed(offset: max(0, value.length - _userPostfix.length));
                                    }

                                    setState(() {
                                      widget.onSetTeamMemberBirthYear(widget.memberIndex, value.replaceFirst(_userPostfix, '')); // Remove the postfix before storing and sending the birth year.
                                    });

                                    AnalyticsUtil.logEvent("홈_팀만들기_친구생년입력", properties: {
                                      '친구 인덱스': widget.memberIndex,
                                      '친구 생년': value.replaceFirst(_userPostfix, '')
                                    });
                                  },
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "ex. 04",
                                      hintStyle: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Colors.grey.shade500),
                                      contentPadding: EdgeInsets.only(bottom: SizeConfig.defaultSize),
                                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 0.6)),
                                      counterText:''
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              TypeAheadField(
                noItemsFoundBuilder: (context) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      "학과를 입력해주세요!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                },
                suggestionsBoxDecoration: const SuggestionsBoxDecoration( // 목록 배경색
                  color: Colors.white,
                  elevation: 2.0,
                ),
                // 학과 찾기
                textFieldConfiguration: TextFieldConfiguration(
                    scrollPadding: EdgeInsets.only(bottom: SizeConfig.defaultSize * 90),
                    controller: _typeAheadController,
                    autofocus: false, // 키보드 자동으로 올라오는 거
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontStyle: FontStyle.normal,
                        fontSize: getFlexibleSize(target: 15),
                        fontWeight: FontWeight.w400,
                        color: isSelectedOnTypeAhead ? const Color(0xff7C83FD) : Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200, // 테두리 색상
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff7C83FD), // 테두리 색상
                            width: 2.0,
                          ),
                        ),
                        prefixIcon: const Icon(Icons.school_rounded, color: Color(0xff7C83FD),),
                        hintText: "친구 학과를 입력하고 선택해주세요")),

                suggestionsCallback: (pattern) {
                  // 입력된 패턴에 기반하여 검색 결과를 반환
                  _typeOnTypeAhead();
                  if (pattern.isEmpty || isSelectedOnTypeAhead) {
                    return [];
                  }
                  return universityFinder.getDepartmentSuggestions(universityName, pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: const Icon(Icons.school),
                    title: Text(suggestion['department']),
                    subtitle: Text('${suggestion['name']}'),
                  );
                },
                // 추천 text를 눌렀을 때 일어나는 액션 (밑의 코드는 ProductPage로 넘어감)
                onSuggestionSelected: (suggestion) {
                  if (isSelectedOnTypeAhead == false) {
                    _selectOnTypeAhead();
                  }
                  _setUniversity(University.fromJson(suggestion));
                },
              ),
            ]
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
    this.questionName, this.count, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsUtil.logEvent("과팅_팀만들기_카드_투표_터치", properties: {
          'questionName': questionName,
          'count': count
        });
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 3.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffFF5C58)
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
          color: const Color(0xffFF5C58),
          fontSize: SizeConfig.defaultSize * 1.3
        ),)
      ),
    );
  }
}

class _CreateTeamBottomSection extends StatefulWidget {
  final VoidCallback onFinish;
  List<Location> serverLocations;
  List<Location> locations;
  MeetState state;
  String name;
  BuildContext ancestorContext;

  final void Function(List<Location> locations) onSetCities;
  final void Function(bool match) onSetMatch;
  final MeetTeam Function() createNewTeam;

  _CreateTeamBottomSection({
    super.key,
    required this.onFinish,
    required this.serverLocations,
    required this.locations,
    required this.state,
    required this.name,
    required this.ancestorContext,
    required this.onSetCities,
    required this.onSetMatch,
    required this.createNewTeam,
  });

  @override
  State<_CreateTeamBottomSection> createState() => _CreateTeamBottomSectionState();
}

class _CreateTeamBottomSectionState extends State<_CreateTeamBottomSection> {
  bool light = false;
  late MeetTeam meetTeam;
  bool isButtonOn = false;

  @override
  void initState() {
    super.initState();
    meetTeam = widget.createNewTeam();
  }

  @override
  void didUpdateWidget(covariant _CreateTeamBottomSection oldWidget) {  // 부모위젯에서 상태변화 신호가 내려오면 실행됨
    super.didUpdateWidget(oldWidget);
    meetTeam = widget.createNewTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.defaultSize * 22,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: const Color(0xffeeeeee),
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 1.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 0.2),
                child: Row( // 만나고싶은지역 Row ********
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("만나고 싶은 지역", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6),),
                    TextButton(
                        onPressed: () {
                          AnalyticsUtil.logEvent("홈_팀만들기_만나고싶은지역버튼_터치");
                          List<Map<String, dynamic>> citiesData = [];
                          for (int i = 0; i < widget.serverLocations.length; i++) {
                            citiesData.add({"id": widget.serverLocations[i].id, "name": widget.serverLocations[i].name, "isChecked": false});
                          }
                          List<Map<String, dynamic>> newCitiesData = [];

                          showDialog<String>
                            (context: context,
                              builder: (BuildContext dialogContext) {
                                return StatefulBuilder(
                                  builder: (statefulContext, setState) =>
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        title: Text('',
                                          style: TextStyle(
                                              fontSize: SizeConfig.defaultSize *
                                                  2),
                                          textAlign: TextAlign.center,),
                                        content: SizedBox(
                                          width: SizeConfig.screenWidth * 0.9,
                                          height: SizeConfig.screenHeight * 0.4,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('이성과 만나고 싶은 지역을 선택해주세요!',
                                                style: TextStyle(
                                                    fontSize: SizeConfig.defaultSize * 1.4),
                                                textAlign: TextAlign.start,),
                                              Flexible(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: citiesData.map((favorite) {
                                                      return CheckboxListTile(
                                                          activeColor: const Color(0xffFE6059),
                                                          title: Text(favorite['name']),
                                                          value: favorite['isChecked'],
                                                          onChanged: (val) {
                                                            setState(() {
                                                              favorite['isChecked'] = val;
                                                            });
                                                            if (favorite['isChecked']) {
                                                              AnalyticsUtil.logEvent("홈_팀만들기_만나고싶은지역_지역선택", properties: {
                                                                'id': favorite['id'] ?? '알수없음',
                                                                'regieon': favorite['name'] ?? '알수없음'
                                                              });
                                                              newCitiesData.add({'id': favorite['id'], 'name': favorite['name']});
                                                            } else {
                                                              newCitiesData.removeWhere((item) => item['id'] == favorite['id']);
                                                            }
                                                          }
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  dialogContext, '취소');
                                            },
                                            child: const Text('취소',
                                              style: TextStyle(
                                                  color: Colors.grey),),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                List<Location> newCities = newCitiesData.map((cityData) => Location(id: cityData["id"], name: cityData["name"])).toList();
                                                widget.onSetCities(newCities);
                                                Navigator.pop(dialogContext);
                                              },
                                              child: const Text('완료',
                                                  style: TextStyle(
                                                      color: Color(0xffFE6059)))
                                          ),
                                        ],
                                      ),
                                );
                              }
                          );
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero
                        ),
                        child: SizedBox(
                          width: SizeConfig.screenWidth * 0.53,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.locations.isEmpty
                                  ? "선택해주세요"
                                  : widget.locations.map((city) => city.name).join(', '),
                                style: TextStyle(
                                  fontSize: SizeConfig.defaultSize * 1.6,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const Text(" "),
                              Icon(Icons.edit_rounded, color: const Color(0xffFE6059), size: SizeConfig.defaultSize * 1.8)
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.2),
                child: Row( // 학교 사람들에게 보이지 않기 Row ********
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("우리 학교 사람들에게 보이지 않기", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6),),
                    Switch(
                      value: light,
                      activeColor: const Color(0xffFE6059),
                      activeTrackColor: const Color(0xffFE6059).withOpacity(0.2),
                      inactiveTrackColor: Colors.grey.shade200,
                      onChanged: (bool value) {
                        setState(() {
                          AnalyticsUtil.logEvent("홈_팀만들기_우리학교사람들에게보이지않기_토글", properties: {
                            "toggle": value.toString()
                          });
                          light = value;
                          widget.state.setIsChecked(value);
                          widget.onSetMatch(light);
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 0.3,),
              GestureDetector(
                onTap: () async {
                  if (meetTeam.members.length == 1) {
                    if (meetTeam.members[0].getName().isNotEmpty && meetTeam.members[0].getBirthYear() != 0 && meetTeam.members[0].getUniversityId() != 0 && meetTeam.name != '' && meetTeam.locations.isNotEmpty) {
                      AnalyticsUtil.logEvent("홈_팀만들기_팀만들기버튼_터치(생성)", properties: {
                        "teamId": meetTeam.id,
                        "teamName": meetTeam.name,
                        "teamLocationsCount": meetTeam.locations.length,
                        "teamMembersCount": meetTeam.members.length + 1,
                        "toggle": meetTeam.canMatchWithSameUniversity,
                        "university": meetTeam.university?.name ?? "알수없음",
                      });
                      widget.onFinish();
                      Navigator.pop(widget.ancestorContext, meetTeam);
                    } else {
                      AnalyticsUtil.logEvent("홈_팀만들기_팀만들기버튼_터치(미생성)");
                      ToastUtil.showMeetToast('모든 정보를 기입해주세요!', 1);
                    }
                  } else if (meetTeam.members.length == 2) {
                    if (meetTeam.members[0].getName().isNotEmpty && meetTeam.members[0].getBirthYear() != 0 && meetTeam.members[0].getUniversityId() != 0
                        && meetTeam.members[1].getName().isNotEmpty && meetTeam.members[1].getBirthYear() != 0 && meetTeam.members[1].getUniversityId() != 0
                        &&  meetTeam.name != '' && meetTeam.locations.isNotEmpty) {
                      AnalyticsUtil.logEvent("홈_팀만들기_팀만들기버튼_터치(생성)", properties: {
                        "teamId": meetTeam.id,
                        "teamName": meetTeam.name,
                        "teamLocationsCount": meetTeam.locations.length,
                        "teamMembersCount": meetTeam.members.length + 1,
                        "toggle": meetTeam.canMatchWithSameUniversity,
                        "university": meetTeam.university?.name ?? "알수없음",
                      });
                      widget.onFinish();
                      Navigator.pop(widget.ancestorContext, meetTeam);
                    } else {
                      AnalyticsUtil.logEvent("홈_팀만들기_팀만들기버튼_터치(미생성)");
                      ToastUtil.showMeetToast('모든 정보를 기입해주세요!', 1);
                    }
                  } else {
                    AnalyticsUtil.logEvent("홈_팀만들기_팀만들기버튼_터치(미생성)");
                    ToastUtil.showMeetToast('팀원을 추가해주세요!', 1);
                  }
                },
                child: Container(
                  height: SizeConfig.defaultSize * 6,
                  width: SizeConfig.screenHeight,
                  decoration: BoxDecoration(
                    color: (meetTeam.members.length==1 && meetTeam.members[0].canCreateTeam() && meetTeam.name != '' && meetTeam.locations.isNotEmpty
                        || meetTeam.members.length==2 && meetTeam.members[0].canCreateTeam() && meetTeam.members[1].canCreateTeam()) ? const Color(0xffFF5c58) : const Color(0xffdddddd),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text((meetTeam.members.length==1 && meetTeam.members[0].canCreateTeam() && meetTeam.name != '' && meetTeam.locations.isNotEmpty
                      || meetTeam.members.length==2 && meetTeam.members[0].canCreateTeam() && meetTeam.members[1].canCreateTeam()) ? "팀 만들기" : "팀명, 팀원을 입력해주세요",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.defaultSize * 2,
                      fontWeight: FontWeight.w600
                  )),
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 1.7,)
            ],
          ),
        )
    );
  }
}
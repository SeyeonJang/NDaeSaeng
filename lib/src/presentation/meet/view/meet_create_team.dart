import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/use_case/meet_use_case.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class MeetCreateTeam extends StatefulWidget {
  final VoidCallback onFinish;
  final MeetState state;

  MeetCreateTeam({super.key, required this.onFinish, required this.state});

  @override
  State<MeetCreateTeam> createState() => _MeetCreateTeamState();
}

class _MeetCreateTeamState extends State<MeetCreateTeam> {
  // 수정일 때 late int id;
  String name = '';
  late MeetState state;

  late List<User> friendsList;
  late Set<User> teamMemberList;
  late int teamMemberCount;
  late List<Location> cities;
  late bool canMatchWithSameUniversity;

  @override
  void initState() {
    super.initState();
    state = widget.state;

    friendsList = state.friends.toList();
    // teamMemberList = state.teamMembers;
    teamMemberList = {};

    teamMemberCount = teamMemberList.length;
    cities = [];
    canMatchWithSameUniversity = false;
  }

  void addFriendToMyTeam(User friend) {
    setState(() {
      print("add======================================");
      print(friend);

      setState(() {
        teamMemberList.add(friend);
        friendsList.remove(friend);
        teamMemberCount = teamMemberList.length;
      });

      print(teamMemberCount);
      print("내팀: ${teamMemberList.toString()}");
      print("후보: ${friendsList.toString()}");
    });
  }

  void removeFriendFromMyTeam(User friend) {
    setState(() {
      print("remove======================================");
      print(friend);

      setState(() {
        friendsList.add(friend);
        teamMemberList.remove(friend);
        teamMemberCount = teamMemberList.length;
      });

      print(teamMemberCount);
      print("내팀: ${teamMemberList.toString()}");
      print("후보: ${friendsList.toString()}");
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

  MeetTeam createNewTeam() {
    return MeetTeam(
      id: 0,
      name: name,
      members: teamMemberList.toList(),
      locations: cities,
      canMatchWithSameUniversity: canMatchWithSameUniversity,
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
    Future<bool> _onBackKey() async {
      return await showDialog(
          context: context,
          builder: (BuildContext sheetContext) {
            return AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: Text("팀 만들기를 종료하시겠어요?", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: Text('취소', style: TextStyle(color: Color(0xffFF5C58))),
                ),
                TextButton(
                  onPressed: () {
                    widget.onFinish();
                    Navigator.pop(context, true);
                  },
                  child: Text('끝내기', style: TextStyle(color: Color(0xffFF5C58))),
                )
              ],
            );
          }
          );
    };

    return WillPopScope(
      onWillPop: () {
        return _onBackKey();
      },
      child: Scaffold(
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
                                        await _onBackKey();
                                        Navigator.pop(context);
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
                                  child: Column(
                                    children: [
                                      _CreateTeamTopSection(userResponse: state.userResponse, handleTeamNameChanged: handleTeamNameChanged, state: state),
                                      // 나
                                      MemberCardView(userResponse: state.userResponse, state: state, isMyself: true, onRemoveFriend: removeFriendFromMyTeam),
                                      // 친구1
                                      teamMemberCount >= 1
                                          ? MemberCardView(userResponse: teamMemberList.first, state: state, isMyself: false, onRemoveFriend: removeFriendFromMyTeam)
                                          : Container(),
                                      // 친구2
                                      teamMemberCount == 2
                                          ? MemberCardView(userResponse: teamMemberList.last, state: state, isMyself: false, onRemoveFriend: removeFriendFromMyTeam)
                                          : Container(),
                                      // 버튼
                                      teamMemberCount == 2
                                          ? Container()
                                          : InkWell( // 팀원 추가하기 버튼 *******
                                        onTap: () {
                                          _ShowModalBottomSheet(context, friendsList);
                                          // context.read<MeetCubit>().pressedMemberAddButton();
                                        },
                                        child: Container(
                                            width: SizeConfig.screenWidth,
                                            height: SizeConfig.defaultSize * 6,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text("+   팀원 추가하기", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.6
                                            ),)
                                        ),
                                      )
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
            bottomNavigationBar:  _CreateTeamBottomSection(serverLocations: state.serverLocations, locations: cities, state: state, name: name, ancestorContext: context, onSetCities: setCities, onSetMatch: setCanMatchWithSameUniversity, createNewTeam: createNewTeam),
            ),
      );
  }

  Future<dynamic> _ShowModalBottomSheet(BuildContext context, List<User> friends) {
    List<User> filteredFriends = friends.where((friend) =>
      friend.university?.name == state.userResponse.university?.name &&
      friend.personalInfo?.gender == state.userResponse.personalInfo?.gender
    ).toList();
    print("UI에서 필터링한 친구목록 ${filteredFriends}");
    // context.read<MeetCubit>().setMyFilteredFriends(filteredFriends.toList());
    // print("필터링 된 내 친구목록 ${state.filteredFriends}");

    return showModalBottomSheet( // 친구 목록 ********
        context: context,
        builder: (BuildContext _) {
          return Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.05,
                      alignment: Alignment.center,
                      child: Container(
                        width: SizeConfig.screenWidth * 0.15,
                        height: SizeConfig.defaultSize * 0.3,
                        color: Colors.grey,
                      )
                  ),
                  Flexible(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("우리 학교 친구 ${filteredFriends.length}명", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.6,
                                fontWeight: FontWeight.w600
                            ),),
                              SizedBox(height: SizeConfig.defaultSize * 0.5,),
                            Text("같은 학교 친구 \'최대 2명\'과 과팅에 참여할 수 있어요!", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.3
                            ),),
                              SizedBox(height: SizeConfig.defaultSize,),
                            Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int i=0; i<filteredFriends.length; i++)
                                        _OneFriendComponent(friend: filteredFriends[i], state: state, count: filteredFriends.length, nowNum: i, sheetContext: context, filteredFriends: filteredFriends, onAddFriend: addFriendToMyTeam),
                                    ],
                                  )
                              ),
                            ),
                          ]
                      )
                  )
                ],
              )
          );
        }
    );
  }
}

class _OneFriendComponent extends StatefulWidget {
  BuildContext sheetContext;
  MeetState state;
  late User friend;
  late int count;
  late int nowNum;
  List<User> filteredFriends;

  final void Function(User friend) onAddFriend;

  _OneFriendComponent({
    super.key,
    required this.friend,
    required this.state,
    required this.count,
    required this.nowNum,
    required this.sheetContext,
    required this.filteredFriends,
    required this.onAddFriend,
  });

  @override
  State<_OneFriendComponent> createState() => _OneFriendComponentState();
}

class _OneFriendComponentState extends State<_OneFriendComponent> {
  String get profileImageUrl => widget.friend.personalInfo?.profileImageUrl ?? 'DEFAULT';
  // RadioButton 설정
  late int selectedRadio;
  late int selectedRadioTile;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) { // 친구 한 명 View *******
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.9, right: SizeConfig.defaultSize * 1),
      child: Column(
        children: [
            SizedBox(height: SizeConfig.defaultSize * 0.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.75,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    profileImageUrl == "DEFAULT"
                        ? ClipOval(
                          child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 4.3, fit: BoxFit.cover,),
                          )
                        : ClipOval(
                        child: Image.network(profileImageUrl,
                          width: SizeConfig.defaultSize * 4.3,
                          height: SizeConfig.defaultSize * 4.3,
                          fit: BoxFit.cover,)
                    ),
                      SizedBox(width: SizeConfig.defaultSize,),
                    Text(widget.friend.personalInfo?.name ?? "XXX", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 2,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )),
                      SizedBox(width: SizeConfig.defaultSize * 0.5,),
                    Flexible(
                      child: Container(
                        child: Text("${widget.friend.university?.department}", style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.4,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text("추가", style: TextStyle(color: Color(0xffFF5C58)),),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(0)
                ),
                onPressed: () {
                  widget.onAddFriend(widget.friend);
                  widget.filteredFriends.remove(widget.friend);

                  // widget.state.teamMembers.add(widget.friend);
                  Navigator.pop(widget.sheetContext);
                  print(widget.nowNum+1);
                },
              ),
            ],
          ),
            SizedBox(height: SizeConfig.defaultSize * 0.6,),
        ],
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
    (value); // Callback to parent widget
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
            Row(children: [
              Text("학교",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.6,
                      color: Colors.grey
                  )),
              SizedBox(width: SizeConfig.defaultSize,),
              Text("${widget.userResponse.university?.name ?? '학교를 불러오지 못 했어요'}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.6,
                      color: Colors.grey
                  ))
            ]),
              SizedBox(height: SizeConfig.defaultSize * 0.5),
            Row(children: [
              Text("팀명",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.6,
                      color: Colors.black
                  )),
              SizedBox(width: SizeConfig.defaultSize,),
              Flexible(
                  child: TextField(
                    controller: _controller,
                    maxLength: 10,
                    onChanged: (value) {
                      setState(() {
                        widget.state.teamName = value;
                        widget.handleTeamNameChanged(value);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "이성에게 보여질 팀명을 입력해주세요!",
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.6)),
                    ),

                  )
              )
            ]),
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
            color: Color(0xffFF5C58).withOpacity(0.5),
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
                          // AnalyticsUtil.logEvent("내정보_마이_내사진터치");
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
                          Container(
                            height: SizeConfig.defaultSize * 3.3,
                            child: Row( // 위층 (이름 ~ 년생)
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.defaultSize * 26,
                                  height: SizeConfig.defaultSize * 3.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          children: [
                                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                            Text(
                                              userResponse.personalInfo?.nickname == 'DEFAULT'
                                                  ? ('${userResponse.personalInfo?.name}' ?? '친구 이름')
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
                                      if (!isMyself)
                                        PopupMenuButton<String>(
                                          icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                                          color: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          onSelected: (value) {
                                            // 팝업 메뉴에서 선택된 값 처리
                                            if (value == 'remove') {
                                              onRemoveFriend(userResponse);
                                            }
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row( // 2층
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                    Container(
                                width: SizeConfig.screenWidth * 0.56,
                                child: Text(
                                  userResponse.university?.department ?? "??학부", // TODO : 학과 길면 ... 처리
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.defaultSize * 1.6,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,

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

              // TODO : 받은 투표가 있다면 VoteView, 없으면 NoVoteView
              Container(
                height: SizeConfig.defaultSize * 11.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      userResponse.titleVotes.length > i ?
                      VoteView(userResponse.titleVotes[i].question.content ?? "(알수없음)", userResponse.titleVotes[i].count) :
                      NoVoteView(),
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

class VoteView extends StatelessWidget { // 받은 투표 있을 때
  final String questionName;
  final int count;

  const VoteView(
    this.questionName, this.count
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text("$count",  style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize * 1.3
              ),)
            ],
          ),
        )
    );
  }
}

class NoVoteView extends StatelessWidget { // 받은 투표 없을 때
  const NoVoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 3.5,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text("내정보 탭에서 받은 투표를 프로필로 넣어보세요!", style: TextStyle(
        color: Color(0xffFF5C58),
        fontSize: SizeConfig.defaultSize * 1.3
      ),)
    );
  }
}

class _CreateTeamBottomSection extends StatefulWidget {
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
        height: SizeConfig.defaultSize * 21,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: Color(0xffeeeeee),
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
                                        content: Container(
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
                                                          activeColor: Color(0xffFE6059),
                                                          title: Text(favorite['name']),
                                                          value: favorite['isChecked'],
                                                          onChanged: (val) {
                                                            setState(() {
                                                              favorite['isChecked'] = val;
                                                            });
                                                            if (favorite['isChecked']) {
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
                                                // context.read<MeetCubit>().pressedCitiesAddButton(newCities);
                                                widget.onSetCities(newCities);
                                                Navigator.pop(dialogContext);
                                              },
                                              child: Text('완료',
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
                        child: Container(
                          width: SizeConfig.screenWidth * 0.53,
                          child: Text(
                            widget.locations.isEmpty
                              ? "선택해주세요"
                              : widget.locations.map((city) => city.name).join(', '),
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.6,
                              color: Colors.grey.shade400,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.right,
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
                      activeColor: Color(0xffFE6059),
                      activeTrackColor: Color(0xffFE6059).withOpacity(0.2),
                      inactiveTrackColor: Colors.grey.shade200,
                      onChanged: (bool value) {
                        setState(() {
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
                  if ((meetTeam.members.length == 1 || meetTeam.members.length == 2) && meetTeam.name != '' && meetTeam.locations.isNotEmpty) {
                    Navigator.pop(widget.ancestorContext, meetTeam);
                  }
                },
                child: Container(
                  height: SizeConfig.defaultSize * 6,
                  width: SizeConfig.screenHeight,
                  decoration: BoxDecoration(
                    color:((meetTeam.members.length == 1 || meetTeam.members.length == 2) && meetTeam.name != '' && meetTeam.locations.isNotEmpty)
                        ? Color(0xffFF5C58) : Color(0xffddddddd),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text("팀 만들기", style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.defaultSize * 2,
                      fontWeight: FontWeight.w600
                  )),
                ),
              )
            ],
          ),
        )
    );
  }
}
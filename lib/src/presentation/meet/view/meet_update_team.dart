import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetUpdateTeam extends StatefulWidget {
  final VoidCallback onFinish;
  // final MeetTeam myTeam;
  // final User user;
  final MeetState meetState;

  // MeetUpdateTeam({super.key, required this.onFinish, required this.myTeam, required this.user});
  MeetUpdateTeam({super.key, required this.onFinish, required this.meetState});

  @override
  State<MeetUpdateTeam> createState() => _MeetUpdateTeamState();
}

class _MeetUpdateTeamState extends State<MeetUpdateTeam> {
  // 수정일 때 late int id;
  String name = '';
  late MeetState state;
  late var friendsList;
  late var teamMemberList;

  @override
  void initState() {
    super.initState();
    state = widget.meetState;
    print(state.toString());

    var friendsList = state.friends.toList();
    var teamMemberList = state.teamMembers.toList();
  }

  void addFriendToMyTeam(User friend) {
    setState(() {
    friendsList.remove(friend);
    teamMemberList.add(friend);
    });
  }

  void removeFriendFromMyTeam(User friend) {
    setState(() {
    friendsList.add(friend);
    teamMemberList.remove(friend);
    });
  }

  void handleTeamNameChanged(String newName) {
    name = newName;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackKey() async {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: Text("팀 만들기를 종료하시겠어요?", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
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
          });
    };

    return WillPopScope(
      onWillPop: () {
        return _onBackKey();
      },
      child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                    // context.read<MeetCubit>().initState();
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.3),
                        child: Column(
                          children: [
                              SizedBox(height: SizeConfig.defaultSize),
                            Row(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await _onBackKey();
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.arrow_back_ios_new_rounded,
                                              size: SizeConfig.defaultSize * 2)),
                                      Text("우리 팀 수정하기",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: SizeConfig.defaultSize * 2,
                                          )),
                                    ]),
                                TextButton(
                                    onPressed: () {
                                      MeetTeam myNewTeam = MeetTeam(id: 0, name: state.teamName, university: state.userResponse!.university, locations: state.getCities(), canMatchWithSameUniversity: state.isChecked, members: state.teamMembers.toList());
                                      if ((state.isMemberOneAdded || state.isMemberTwoAdded) && state.teamName!='' && state.getCities().isNotEmpty) {
                                        context.read<MeetCubit>().updateMyTeam(myNewTeam);
                                        print("${state.teamName} 이름 전달합니다");
                                        print("${state.userResponse!.university}");
                                        print("${myNewTeam.toString()}");
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text("완료", style: TextStyle(
                                        color: Color(0xffFF5C58),
                                        fontSize: SizeConfig.defaultSize * 1.9,
                                        fontWeight: FontWeight.w500
                                    ))
                                )
                              ],
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 1.5),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.3),
                                  child: Column(
                                    children: [
                                      _CreateTeamTopSection(userResponse: state.userResponse, handleTeamNameChanged: handleTeamNameChanged, state: state),
                                      // 나
                                      MemberCardView(userResponse: state.userResponse, state: state, isMyself: true),
                                      // 친구1
                                      // context.read<MeetCubit>().getTeam(widget.myTeam.id.toString())
                                      state.isMemberOneAdded
                                          ? MemberCardView(userResponse: teamMemberList[0], state: state, isMyself: false)
                                          : Container(),
                                      // 친구2
                                      state.isMemberTwoAdded
                                          ? MemberCardView(userResponse: teamMemberList[1], state: state, isMyself: false)
                                          : Container(),
                                      // 버튼
                                      state.isMemberTwoAdded
                                          ? Container()
                                          : InkWell( // 팀원 추가하기 버튼 *******
                                        onTap: () {
                                          _ShowModalBottomSheet(context, state, friendsList);
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
                    ),
            ),
            bottomNavigationBar: BlocBuilder<MeetCubit, MeetState>(
                builder: (buildContext, state) {
                  return _CreateTeamBottomSection(state: state, name: name);
                }
            )
        ),
    );
  }

  Future<dynamic> _ShowModalBottomSheet(BuildContext context, MeetState state, List<User> friendsList) {
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
                            Text("우리 학교 친구 ${state.friends.length}명", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.6,
                                fontWeight: FontWeight.w600
                            ),),
                              SizedBox(height: SizeConfig.defaultSize * 0.5,),
                            Text("같은 학교 친구 \'최대 2명\'과 과팅에 참여할 수 있어요!", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.3
                            ),),
                              SizedBox(height: SizeConfig.defaultSize,),
                            Flexible(
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int i=0; i<state.friends.length; i++)
                                        _OneFriendComponent(friend: friendsList[i], count: state.friends.length, nowNum: i, sheetContext: context,),
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
  late User friend;
  late int count;
  late int nowNum;

  _OneFriendComponent({
    super.key,
    required this.friend,
    required this.count,
    required this.nowNum,
    required this.sheetContext,
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
                  widget.sheetContext.read<MeetCubit>().pressedMemberAddButton(widget.friend);



                  ///////////////////// gpt에게. 여기서 addFriendToMyTeam()을 호출하고 싶습니다.




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
                    onChanged: (value) {
                      setState(() {
                        widget.state.teamName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "${widget.state.teamName} (다른 팀명을 입력하지 않으면 바뀌지 않아요!)",
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

class _CreateTeamBottomSection extends StatefulWidget {
  MeetState state;
  String name;

  _CreateTeamBottomSection({
    super.key,
    required this.state,
    required this.name,
  });

  @override
  State<_CreateTeamBottomSection> createState() => _CreateTeamBottomSectionState();
}

class _CreateTeamBottomSectionState extends State<_CreateTeamBottomSection> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.defaultSize * 14,
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
                          List<Map<String, dynamic>> citiesData = [
                            {"id": 1, "name": "서울", "isChecked": false},
                            {"id": 2, "name": "대구", "isChecked": false},
                            {"id": 3, "name": "부산", "isChecked": false},
                            // {"id": 3, "name": "대구", "isChecked": false},
                            // {"id": 4, "name": "제주도", "isChecked": false},
                          ];
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
                                                context.read<MeetCubit>().pressedCitiesAddButton(newCities);
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
                        child: Text(
                          widget.state.getCities().isEmpty
                            ? "선택해주세요"
                            : widget.state.getCities().map((city) => city.name).join(', '),
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.6,
                            color: Colors.grey.shade400),))
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
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 0.3,),
            ],
          ),
        )
    );
  }
}
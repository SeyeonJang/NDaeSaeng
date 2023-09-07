import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/component/meet_one_team_cardview.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import '../../../domain/entity/meet_team.dart';

class MeetBoard extends StatefulWidget {
  const MeetBoard({super.key});

  @override
  State<MeetBoard> createState() => _MeetBoardState();
}

class _MeetBoardState extends State<MeetBoard> {
  @override
  void initState() {
    super.initState();
    context.read<MeetCubit>().pagingController.addPageRequestListener((pageKey) => context.read<MeetCubit>().fetchPage(pageKey));
    SchedulerBinding.instance.addPostFrameCallback((_) => context.read<MeetCubit>().initMeet());
  }

  @override
  void dispose() {
    context.read<MeetCubit>().pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetCubit, MeetState>(
      builder: (context, state) {
        List<User> filteredFriends = state.friends.where((friend) =>
        friend.university?.name == state.userResponse.university?.name &&
            friend.personalInfo?.gender == state.userResponse.personalInfo?.gender
        ).toList();
        print("친구 수 : ${state.friends.length}, 과팅 같이 나갈 수 있는 친구 수 : ${filteredFriends.length}, 팀 개수 : ${state.myTeams.length}");
        PagingController<int, BlindDateTeam> pagingController = context.read<MeetCubit>().pagingController;

        return (state.isLoading)
          ? Scaffold(
              appBar: AppBar(),
              body: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xffFE6059)),
                    SizedBox(height: SizeConfig.defaultSize * 5,),
                    Text("이성 팀을 불러오고 있어요 . . . 🥰", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),)
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.grey.shade50,

              appBar: AppBar(
                toolbarHeight: SizeConfig.defaultSize * 8.5,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: state.friends.isEmpty || filteredFriends.isEmpty
                    ? _TopSectionInviteFriend(meetState: state,)
                    : (state.myTeams.length == 0 ? _TopSectionMakeTeam(meetState: state,) : _TopSection(ancestorState: state, context: context,)),
              ),

              body: _BodySection(meetState: state, context: context, pagingController: pagingController,),

              floatingActionButton: filteredFriends.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () async {
                        AnalyticsUtil.logEvent("과팅_목록_팀만들기버튼_터치");
                        if (state.isLoading) {
                          ToastUtil.showMeetToast("다시 터치해주세요!", 2);
                          return;
                        }
                        final meetCubit = context.read<MeetCubit>(); // MeetCubit 인스턴스 가져오기
                        await Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<MeetCubit>(
                                create: (_) => MeetCubit(),
                                child: MeetCreateTeam(
                                  onFinish: () { meetCubit.refreshMeetPage(); },
                                  state: meetCubit.state
                                ),
                              ),
                            ))
                            .then((value) async {
                                if (value == null) return;
                                await meetCubit.createNewTeam(value);
                            });
                        meetCubit.initMeet();
                        Navigator.pop(context);
                      },
                      shape: CircleBorder(),
                      child: Icon(Icons.add_rounded),
                      backgroundColor: const Color(0xffFE6059),
                    )
                    : null,
          );
      }
    );
  }
}

class _TopSectionMakeTeam extends StatelessWidget { // 팀 X 과팅 나갈 친구 O
  final MeetState meetState;

  _TopSectionMakeTeam({
    super.key,
    required this.meetState
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("팀 생성 무제한 무료! 지금 바로 팀을 만들 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
            SizedBox(height: SizeConfig.defaultSize * 0.5,),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.defaultSize * 5,
              decoration: BoxDecoration(
                color: Color(0xffFE6059),
                borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("우리 학교 친구와 과팅 팀 만들기", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TopSectionInviteFriend extends StatelessWidget { // 친구 O/X, 과팅 나갈 친구 X
 final MeetState meetState;

  _TopSectionInviteFriend({
    super.key,
    required this.meetState
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("친구 1명만 초대해도 바로 팀을 만들 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
          SizedBox(height: SizeConfig.defaultSize * 0.5,),
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 5,
            decoration: BoxDecoration(
                color: Color(0xffFE6059),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("한 명 초대하고 10초만에 과팅 등록하기", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),),
            ),
          )
        ],
      ),
    );
  }
}

class _BodySection extends StatefulWidget {
  final MeetState meetState;
  final BuildContext context;
  PagingController<int, BlindDateTeam> pagingController;

  _BodySection({
    super.key,
    required this.meetState,
    required this.context,
    required this.pagingController
  });

  @override
  State<_BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<_BodySection> {
  late MeetCubit meetCubit;
  final ScrollController _scrollController = ScrollController();
  late MeetTeam nowTeam = widget.meetState.myTeams[0];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // 아래로 스크롤할 때 실행되는 콜백 함수
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // 스크롤이 가장 아래에 도달하면 아래 방향 새로 고침 실행
        widget.pagingController.refresh();
      }
    });
  }

  BlindDateTeam makeTeam() {
    BlindDateTeam blindDateTeam = BlindDateTeam(
        id: nowTeam.getId(),
        name: nowTeam.getName(),
        averageBirthYear: nowTeam.getAverageBirthYear(),
        regions: nowTeam.getRegions(),
        universityName: nowTeam.getUniversityName(),
        isCertifiedTeam: nowTeam.getIsCertifiedTeam(),
        teamUsers: nowTeam.getTeamUsers()
    );
    return blindDateTeam;
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MeetCubit>().initMeet();
      },
      child: Column(
        children: [
          if (widget.meetState.myTeams.length > 0) // MyTeam
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1),
              child: MeetOneTeamCardview(
                team: makeTeam(),
                isMyTeam: true,
                myTeamCount: widget.meetState.myTeams.length,),
            ),
          Flexible(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1, vertical: SizeConfig.defaultSize),
                  child: Column(
                    children: [
                      // widget.pagingController.itemList?.length == 0 // OtherTeam

                      // widget.meetState.blindDateTeams.length == 0 // OtherTeam
                      //   ? Text("이성 팀이 아직 없어요!")
                      //   :
                      RefreshIndicator(
                          onRefresh: () async => widget.pagingController.refresh(),
                          child: Container(
                            height: SizeConfig.screenHeight * 0.6,
                            child: PagedListView<int, BlindDateTeam>(
                              pagingController: widget.pagingController,
                              builderDelegate: PagedChildBuilderDelegate<BlindDateTeam>(
                                  itemBuilder: (context, blindDateTeam, index) {
                                    return widget.pagingController.itemList?.length == 0
                                        ? Text("이성 팀이 아직 없어요!")
                                        : Column(
                                      children: [
                                        SizedBox(height: SizeConfig.defaultSize * 0.6,),
                                        MeetOneTeamCardview(team: blindDateTeam, isMyTeam: false, myTeamCount: widget.meetState.myTeams.length,)
                                      ],
                                    );
                                  },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 30)
                    ],
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopSection extends StatefulWidget {
  final MeetState ancestorState;
  final BuildContext context;

  _TopSection({
    super.key,
    required this.ancestorState,
    required this.context
  });

  @override
  State<_TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<_TopSection> {
  late MeetTeam selectedTeam; // Add this line
  late List<MeetTeam> myTeams;

  @override
  void initState() {
    super.initState();
    selectedTeam = widget.ancestorState.myTeams[0]; // TODO : myTeams[0] 말고 state.getTeam() 가져와야하는데 못 가져옴
    myTeams = widget.ancestorState.myTeams;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("과팅", style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.7,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: SizeConfig.defaultSize * 0.4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  DropdownButton<MeetTeam>(
                    value: selectedTeam,
                    padding: EdgeInsets.all(0),
                    onChanged: (newValue) {
                      setState(() {
                        selectedTeam = newValue!;
                        widget.context.read<MeetCubit>().setPickedTeam(selectedTeam);
                        widget.context.read<MeetCubit>().initMeet();
                      });
                    },
                    items: myTeams.map((myTeam) {
                      return DropdownMenuItem<MeetTeam>(
                        value: myTeam,
                        child: Text(
                          myTeam.name,
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text("팀으로 보고 있어요!", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.5,
                    fontWeight: FontWeight.w400
                  ),),
                ],
              ),
              Text("필터링", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.6,
                fontWeight: FontWeight.w400
              ),)
            ],
          ),
          SizedBox(height: SizeConfig.defaultSize,)
        ],
      ),
    );
  }
}

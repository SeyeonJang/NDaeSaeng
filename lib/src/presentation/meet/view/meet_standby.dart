import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_update_team.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class MeetStandby extends StatelessWidget {
  const MeetStandby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _TopSection(teams: 20, notifications: 93), // TODO : 서버 연결
              SizedBox(height: SizeConfig.defaultSize * 2,),
            Container(height: SizeConfig.defaultSize * 2, width: SizeConfig.screenWidth, color: Colors.grey.shade50,),
              SizedBox(height: SizeConfig.defaultSize * 2,),
            _MiddleSection(),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<MeetCubit, MeetState>(
        builder: (context, state) {
          MeetState.init();
          return _BottomSection(state: state, ancestorContext: context);
        }
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  MeetState state;
  BuildContext ancestorContext;

  _BottomSection({
    super.key,
    required this.state,
    required this.ancestorContext
  });

  @override
  Widget build(BuildContext context) {
    MeetCubit cubit = BlocProvider.of<MeetCubit>(ancestorContext);

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 8.5,
      color: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector( // 내 팀 보기 버튼 *******
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext _) {
                    return Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.05,
                                alignment: Alignment.center,
                                child: Container(
                                  width: SizeConfig.screenWidth * 0.17,
                                  height: SizeConfig.defaultSize * 0.3,
                                  color: Colors.grey,
                                )
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("내 과팅 팀", style: TextStyle(
                                  fontSize: SizeConfig.defaultSize * 2,
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 2,),
                            Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                      children: [
                                      state.myTeams.isEmpty
                                            ? Text("아직 생성한 팀이 없어요!", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.8,
                                                fontWeight: FontWeight.w400
                                              ))
                                            : Row(
                                                children: [
                                                  for (int i=0; i<state.myTeams.length; i++)
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("${state.myTeams[i].name}"), // TODO : 서버 연결 후 재확인
                                                        Row(
                                                          children: [
                                                            Text("${state.myTeams[i].members}"),
                                                            PopupMenuButton<String>(
                                                              icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                                                              color: Colors.white,
                                                              surfaceTintColor: Colors.white,
                                                              onSelected: (value) {
                                                                if (value == 'edit') {
                                                                  // Navigator.push(state.myTeams[i]);
                                                                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetUpdateTeam(), childCurrent: this));
                                                                }
                                                                else if (value == 'delete') {
                                                                  showDialog<String>(
                                                                    context: context,
                                                                    builder: (BuildContext dialogContext) => AlertDialog(
                                                                      title: Text('\'${state.myTeams[i].name}\' 팀을 삭제하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 2),),
                                                                      // content: const Text('사용자를 신고하면 Dart에서 빠르게 신고 처리를 해드려요!'),
                                                                      backgroundColor: Colors.white,
                                                                      surfaceTintColor: Colors.white,
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(dialogContext, '취소');
                                                                          },
                                                                          child: const Text('취소', style: TextStyle(color: Color(0xffFF5C58)),),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            context.read<MeetCubit>().removeTeam(state.myTeams[i].id.toString());
                                                                            Navigator.pop(dialogContext); // 팝업 창을 닫는 로직 추가
                                                                          },
                                                                          child: const Text('삭제', style: TextStyle(color: Color(0xffFF5C58)),),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              itemBuilder: (BuildContext context) {
                                                                return [
                                                                  PopupMenuItem<String>(
                                                                    value: 'delete',
                                                                    child: Text("삭제하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                                                                  ),
                                                                  PopupMenuItem<String>(
                                                                    value: 'edit',
                                                                    child: Text("수정하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                                                                  ),
                                                                ];
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                              ]),
                                      ],
                                  )
                              ),
                            ),
                            Text("팀 개수는 제한이 없어요!", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400
                            ),),
                            Text("다양한 친구들과 팀을 만들어보세요!", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400
                            ),),
                              SizedBox(height: SizeConfig.defaultSize,),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetCreateTeam(
                                  onFinish: () {
                                    cubit.refreshMeetPage();
                                  }
                                ), childCurrent: this));
                                print("돌아옴");
                                cubit.refreshMeetPage();
                                print("리프레시 실행 완료");
                              },
                              child: Container(
                                height: SizeConfig.defaultSize * 6,
                                width: SizeConfig.screenHeight,
                                decoration: BoxDecoration(
                                  color: Color(0xffFF5C58),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text("팀 만들기", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize * 2,
                                    fontWeight: FontWeight.w600
                                )),
                              ),
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 2,)
                          ],
                        ),
                      )
                    );
                });
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.43,
                height: SizeConfig.defaultSize * 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("내 팀 보기", style: TextStyle(color: Color(0xffFE6059), fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600)),
              ),
            ),
            GestureDetector( // 팀 만들기 버튼 ********
              onTap: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetCreateTeam(
                    onFinish: () {
                      cubit.refreshMeetPage();
                    }
                ), childCurrent: this));
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.43,
                height: SizeConfig.defaultSize * 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("팀 만들기", style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TopSection extends StatefulWidget {
  late int teams;
  late int notifications;
  _TopSection({
    super.key,
    required this.teams,
    required this.notifications,
  });
  @override
  State<_TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<_TopSection> with SingleTickerProviderStateMixin {
  bool light = true; // 스위치에 쓰임 TODO : 서버 연결
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    return Center(
      child: Column(
        children: [
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Text("개강시즌 과팅 오픈 예정", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 2.7)),
            SizedBox(height: SizeConfig.defaultSize * 0.5),
          Text("오픈 전, 미리 팀을 만들어보며 준비할 수 있어요!", style: TextStyle(color: Colors.grey.shade400, fontSize: SizeConfig.defaultSize * 1.4)),
            SizedBox(height: SizeConfig.defaultSize * 2),

          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Center(
                    child: Image.asset('assets/images/heart.png', width: SizeConfig.screenWidth * 0.65, height: SizeConfig.screenWidth * 0.65),
                  )
                );
              }),

          Text("${widget.teams}", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.3, fontWeight: FontWeight.w600, color: Color(0xffFF5C58)),),
            SizedBox(height: SizeConfig.defaultSize * 0.5),
          Text("지금까지 신청한 팀", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
            SizedBox(height: SizeConfig.defaultSize * 2),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("과팅 오픈 알림받기 (${widget.notifications}명 대기중)", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),),
                Switch(
                  value: light,
                  activeColor: Color(0xffFE6059),
                  activeTrackColor: Color(0xffFE6059).withOpacity(0.2),
                  inactiveTrackColor: Colors.grey.shade200,
                  onChanged: (bool value) {
                    setState(() { light = value; });
                  },
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

class _MiddleSection extends StatelessWidget {
  const _MiddleSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Column(
        children: [
          Container(alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
                child: Text("이전 시즌 후기", style: TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 1.5),),
              )
          ),
            SizedBox(height: SizeConfig.defaultSize * 2),
          Container( // 후기1
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
                  ),
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
                  child: Text("매칭 전에 간단하게 상대 팀 정보를 볼 수 있다는 게\n독특하고 신기했어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize),
          Container( // 후기2
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.zero),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.4),
                    child: Text("제가 프로필을 적은 양 만큼 관심도가 높아지는 것\n같아서 재밌었어요! 매칭도 성공했어요 :)", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4)),
                  )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize),
          Container( // 후기3
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
                    child: Text("팀 개수의 제한이나 매칭 횟수 제한이 없어서 좋아요!\n친구들이랑 과팅하면서 더 친해졌어요ㅎㅎ!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                  )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 4),

          Container(alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
                child: Text("매칭 잘 되는 Tip", style: TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 1.5),),
              )
          ),
            SizedBox(height: SizeConfig.defaultSize * 1.5),
          Container( // 매칭 잘 되는 팁
            alignment: Alignment.center,
            child: Container(alignment: Alignment.centerLeft,
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.defaultSize * 13,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5, vertical: SizeConfig.defaultSize * 1.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" ∙   ‘내정보' 탭에서 받은 투표 중 3개를 프로필에 넣어요!\n     이성에게 나를 더 어필할 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                      Text(" ∙   ‘내정보' 탭에서 프로필 사진을 추가해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                      Text(" ∙   과팅에 같이 참여하고 싶은 친구들을 초대해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                    ],
                  )
                )
            ),
          ),
        ],
      ),
    );
  }
}

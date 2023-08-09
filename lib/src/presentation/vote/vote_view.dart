import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteView extends StatefulWidget {
  const VoteView({Key? key}) : super(key: key);

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> with SingleTickerProviderStateMixin {
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: Offset(0,0.15),
      end: Offset(0,0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isUp = !_isUp;
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isUp = !_isUp;
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String splitSentence(String sentence) { // 긴 질문 2줄 변환
    if (sentence.length <= 18) { // 18글자 이하면 그대로 반환
      return sentence;
    } else { // 18글자 이상이면 공백을 기준으로 단어를 나눔
      List<String> words = sentence.split(' ');
      String firstLine = '';
      String secondLine = '';

      for (String word in words) {
        if (firstLine.length + word.length + 1 <= 18) { // 첫 줄에 단어를 추가할 수 있는 경우
          firstLine += (firstLine.isEmpty ? '' : ' ') + word;
        } else { // 두 번째 줄에 단어를 추가
          secondLine += (secondLine.isEmpty ? '' : ' ') + word;
        }
      }

      return '$firstLine\n$secondLine';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 5, vertical: SizeConfig.defaultSize * 2),
        body: Center(
          child: BlocBuilder<VoteCubit, VoteState>(
            builder: (context, state) {
              Question question = state.questions[state.voteIterator];
              List<Friend> shuffledFriends = state.getShuffleFriends();
              Friend friend1 = shuffledFriends[0];
              Friend friend2 = shuffledFriends[1];
              Friend friend3 = shuffledFriends[2];
              Friend friend4 = shuffledFriends[3];

              // print(state.votes.toString());

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.defaultSize * 0.5,),
                  VoteStoryBar(voteIterator: state.voteIterator, maxVoteIterator: VoteState.MAX_VOTE_ITERATOR,),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  // Icon(Icons.emoji_emotions, size: SizeConfig.defaultSize * 22),
                  GestureDetector(
                    onTap: () {
                      AnalyticsUtil.logEvent("투표_세부_아이콘터치");
                    },
                    // child: FutureBuilder( // TODO : delay 주면서 포인트 나타날 때 return Text() 부분이랑 딜레이 몇초인지 바꾸면 됨. Stack() 으로 해도 될듯?
                    //     future: Future.delayed(Duration(milliseconds: 1000), () => true),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState == ConnectionState.waiting) {
                    //         return Text("쌓인 포인트 : 100"); // You can adjust the height as needed
                    //       }
                    //     return SlideTransition(
                    //       position: _animation,
                    //       child: Image.asset(
                    //         'assets/images/contacts.png',
                    //         width: SizeConfig.defaultSize * 22,
                    //       ),
                    //     );
                    //   }
                    // ),
                    child: SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/contacts.png',
                        width: SizeConfig.defaultSize * 22,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04,),
                  Container(
                    height: SizeConfig.screenHeight * 0.1,
                    alignment: Alignment.center,
                    child: Text(
                        splitSentence(question.content!), // 길면 2줄 변환
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: SizeConfig.defaultSize * 2.5,
                            height: 1.5
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04,),
                  Container(
                    width: SizeConfig.screenWidth * 0.83,
                    height: SizeConfig.defaultSize * 18,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceFriendButton(
                                userId: friend1.userId!, name: friend1.name ?? "XXX", enterYear: friend1.admissionYear.toString().substring(2,4) ?? "00", department: friend1.university?.department ?? "XXXX학과",
                                questionId: question.questionId!,
                                firstUserId: friend1.userId!,
                                secondUserId: friend2.userId!,
                                thirdUserId: friend3.userId!,
                                fourthUserId: friend4.userId!,
                                voteIndex: state.voteIterator,
                                question: question.content!,
                                gender: friend1.gender!,
                                school: friend1.university!.name,
                                disabledFunction: state.isLoading,
                                profileImageUrl: friend1.profileImageUrl ?? "DEFAULT",
                            ),
                            ChoiceFriendButton(userId: friend2.userId!, name: friend2.name ?? "XXX", enterYear: friend2.admissionYear.toString().substring(2,4) ?? "00", department: friend2.university?.department ?? "XXXX학과",
                                questionId: question.questionId!,
                                firstUserId: friend1.userId!,
                                secondUserId: friend2.userId!,
                                thirdUserId: friend3.userId!,
                                fourthUserId: friend4.userId!,
                                voteIndex: state.voteIterator,
                                question: question.content!,
                                gender: friend2.gender!,
                                school: friend2.university!.name,
                                disabledFunction: state.isLoading,
                                profileImageUrl: friend2.profileImageUrl ?? "DEFAULT",
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.defaultSize,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceFriendButton(userId: friend3.userId!, name: friend3.name ?? "XXX", enterYear: friend3.admissionYear.toString().substring(2,4) ?? "00", department: friend3.university?.department ?? "XXXX학과",
                                questionId: question.questionId!,
                                firstUserId: friend1.userId!,
                                secondUserId: friend2.userId!,
                                thirdUserId: friend3.userId!,
                                fourthUserId: friend4.userId!,
                                voteIndex: state.voteIterator,
                                question: question.content!,
                                gender: friend3.gender!,
                                school: friend3.university!.name,
                                disabledFunction: state.isLoading,
                                profileImageUrl: friend3.profileImageUrl ?? "DEFAULT",
                            ),
                            ChoiceFriendButton(userId: friend4.userId!, name: friend4.name ?? "XXX", enterYear: friend4.admissionYear.toString().substring(2,4) ?? "00", department: friend4.university?.department ?? "XXXX학과",
                                questionId: question.questionId!,
                                firstUserId: friend1.userId!,
                                secondUserId: friend2.userId!,
                                thirdUserId: friend3.userId!,
                                fourthUserId: friend4.userId!,
                                voteIndex: state.voteIterator,
                                question: question.content!,
                                gender: friend4.gender!,
                                school: friend4.university!.name,
                                disabledFunction: state.isLoading,
                                profileImageUrl: friend4.profileImageUrl ?? "DEFAULT",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 2,
                  ),
                  InkWell(
                    onTap: () {
                      AnalyticsUtil.logEvent("투표_세부_셔플", properties: {
                        "질문 인덱스": question.questionId, "질문 내용": question.content
                      });
                      BlocProvider.of<VoteCubit>(context).refresh();
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.2,
                      height: SizeConfig.defaultSize * 5,
                      alignment: Alignment.center,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween, // TODO : 스킵 있을 때는 이거도 있었음
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.shuffle, size: SizeConfig.defaultSize * 2, color: Color(0xff7C83FD),),
                          Text("  셔플", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600, color: Color(0xff7C83FD))),
                          // IconButton(
                          //     onPressed: () {
                          //       // TODO 스킵 기능 기획 후 작성 필요
                          //       // Navigator.push(context, MaterialPageRoute(builder: (context) => VoteResultView()));
                          //       BlocProvider.of<VoteCubit>(context).nextVote(state.voteIterator, 0);  // 투표안함
                          //     },
                          //     icon: const Icon(Icons.skip_next)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      //),
    );
  }
}

class VoteStoryBar extends StatefulWidget {
  final int voteIterator;
  final int maxVoteIterator;

  const VoteStoryBar({
    super.key, required this.voteIterator, required this.maxVoteIterator,
  });

  @override
  State<VoteStoryBar> createState() => _VoteStoryBarState();
}

class _VoteStoryBarState extends State<VoteStoryBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.95,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: BlocBuilder<VoteCubit, VoteState>(
              builder: (context, state) {
                return Row(
                  children: [
                    for (var i = 0; i <= widget.voteIterator; i++) ...[
                      Expanded(child: Container(height: SizeConfig.defaultSize * 0.4, color: Color(0xff7C83FD),)),
                      const SizedBox(width: 2,),
                    ],
                    for (var i = widget.voteIterator; i < widget.maxVoteIterator - 1; i++) ...[
                      Expanded(child: Container(height: SizeConfig.defaultSize * 0.4, color: Colors.grey.shade200,)),
                      const SizedBox(width: 2,),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceFriendButton extends StatefulWidget {
  final bool disabledFunction;

  final int userId;
  final String name;
  final String enterYear;
  final String department;

  final int questionId;
  final int firstUserId;
  final int secondUserId;
  final int thirdUserId;
  final int fourthUserId;

  final int voteIndex;
  final String question;
  final String gender;
  final String school;
  final String profileImageUrl;

  const ChoiceFriendButton({
    super.key,
    this.disabledFunction = false,

    required this.userId,
    required this.name,
    required this.enterYear,
    required this.department,

    required this.questionId,
    required this.firstUserId,
    required this.secondUserId,
    required this.thirdUserId,
    required this.fourthUserId,

    required this.voteIndex,
    required this.question,
    required this.gender,
    required this.school,
    required this.profileImageUrl
  });

  @override
  State<ChoiceFriendButton> createState() => _ChoiceFriendButtonState();
}

class _ChoiceFriendButtonState extends State<ChoiceFriendButton> {
  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Colors.white;
    Color textColor = Color(0xff7C83FD);
    void _onVoteButtonPressed() {
      // 버튼이 눌린 상태일 때 색상 변경
      setState(() {
        backgroundColor = backgroundColor;
        textColor = textColor;
      });

      // 버튼이 떼어진 상태일 때 색상 변경
      setState(() {
        backgroundColor = textColor;
        textColor = backgroundColor;
      });
      // 투표 요청 로직
      VoteRequest voteRequest = VoteRequest(
        questionId: widget.questionId,
        pickedUserId: widget.userId,
        firstUserId: widget.firstUserId,
        secondUserId: widget.secondUserId,
        thirdUserId: widget.thirdUserId,
        fourthUserId: widget.fourthUserId,
      );

      if (!widget.disabledFunction) {
        BlocProvider.of<VoteCubit>(context).nextVote(voteRequest);
      }
    }

    return Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.defaultSize * 8.2,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          if (widget.disabledFunction) {
            return;
          }

          AnalyticsUtil.logEvent("투표_세부_선택", properties: {
            "투표 인덱스": widget.voteIndex,
            "질문 인덱스": widget.questionId,
            "질문 내용": widget.question,
            "투표 당한 사람 성별": widget.gender=="FEMALE" ? '여자' : '남자',
            "투표 당한 사람 학번": widget.enterYear,
            "투표 당한 사람 학교": widget.school,
            "투표 당한 사람 학과": widget.department
          });
          _onVoteButtonPressed();
        },
        style: ElevatedButton.styleFrom( // TODO : 터치한 버튼은 색 변하게 하려고 했는데 구현 못함
          primary: Colors.white,
          onPrimary: Color(0xff7C83FD),
          backgroundColor: Colors.white,   // background color
          foregroundColor: Color(0xff7C83FD), // text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
          ),
            surfaceTintColor: Color(0xff7C83FD).withOpacity(0.1),
            // surfaceTintColor: Color(0xff7C83FD).withOpacity(0.1),
          padding: EdgeInsets.all(SizeConfig.defaultSize * 1)
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      child: widget.profileImageUrl == "DEFAULT"
                          ? ClipOval(
                          child: Image.asset('assets/images/profile-mockup2.png', width: SizeConfig.defaultSize * 2.5, fit: BoxFit.cover,)
                      )
                          : ClipOval(
                          child: Image.network(widget.profileImageUrl,
                            width: SizeConfig.defaultSize * 12,
                            height: SizeConfig.defaultSize * 12,)
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.defaultSize * 1,),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 2.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: SizeConfig.defaultSize * 1,),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 1,),
              Text(
                "${widget.enterYear}학번 ${widget.department}",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4,
                    fontWeight: FontWeight.w500,
                  color: Colors.black
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      // ),
    );
  }
}

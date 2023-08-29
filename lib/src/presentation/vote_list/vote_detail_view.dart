import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import '../../../res/config/size_config.dart';

class VoteDetailView extends StatelessWidget {
  const VoteDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7C83FD),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize * 2),
          child: BlocBuilder<VoteListCubit,VoteListState> (
            builder: (context, state) {
              return FutureBuilder<VoteDetail>(
                future: context.read<VoteListCubit>().getVote(state.nowVoteId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.white)); // 로딩 중에 표시할 위젯
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    VoteResponse vote = state.getVoteById(state.nowVoteId);
                    VoteDetail myVote = snapshot.data!; // 비동기로 받아온 데이터를 사용
                    print('ddddddddd ${myVote.toString()}');
                    return OneVote(
                      voteId: vote.voteId!,
                      vote: myVote,
                    );
                  } else {
                    return Text('데이터 정보가 없습니다.');
                  }
                },
              );
            }
          ),
        ),
      ),
    );
  }
}

class OneVote extends StatefulWidget {
  final int voteId;
  final VoteDetail vote;

  const OneVote({
    super.key, required this.voteId, required this.vote
  });

  @override
  State<OneVote> createState() => _OneVoteState();
}

class _OneVoteState extends State<OneVote> with SingleTickerProviderStateMixin {
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
      begin: Offset(0,0.05),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String gender = widget.vote.pickingUser?.user?.getGender() ?? '?';

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.defaultSize),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<VoteListCubit>(context).backToVoteList();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        size: SizeConfig.defaultSize * 2.3,
                    color: Colors.white,)),
                Text("${(widget.vote.pickingUser?.user?.admissionYear.toString().substring(2,4) ?? '??')}학번 ${gender}학생이 보냈어요!",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.defaultSize * 2.5,
                    color: Colors.white)),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<VoteListCubit>(context).backToVoteList();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                      size: SizeConfig.defaultSize * 2.3,
                      color: Color(0xff7C83FD))),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: SizeConfig.defaultSize * 3),
                Column(
                  children: [
                    SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/magnifier.png',
                        width: SizeConfig.defaultSize * 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.defaultSize * 2),
                Text(
                  splitSentence(widget.vote.question?.content ?? '질문을 받아오지 못 했어요🥲'),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: SizeConfig.defaultSize * 2.5,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize * 4),
                Container(
                  width: SizeConfig.screenWidth * 0.83,
                  height: SizeConfig.defaultSize * 18,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FriendChoiceButton(userResponse: widget.vote.candidates[0]),
                          FriendChoiceButton(userResponse: widget.vote.candidates[1]),
                        ],
                      ),
                      SizedBox(height: SizeConfig.defaultSize,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FriendChoiceButton(userResponse: widget.vote.candidates[2]),
                          FriendChoiceButton(userResponse: widget.vote.candidates[3]),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize * 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("누가 보냈는지 궁금하다면?", style: TextStyle(color: Colors.grey.shade50)),
                    Text("추후 나올 기능을 기대해주세요!", style: TextStyle(color: Colors.grey.shade50)),
                    // HintButton(buttonName: '학번 보기', point: 100),
                    // HintButton(buttonName: '학과 보기', point: 150),
                    // HintButton(buttonName: '초성 보기 한 글자 보기', point: 500),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FriendChoiceButton extends StatelessWidget {
  static bool disabled = false;
  final User userResponse;

  const FriendChoiceButton({
    super.key,
    required this.userResponse
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.defaultSize * 8.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      child: ElevatedButton(
        onPressed: () {},
          style: ElevatedButton.styleFrom( // TODO : 터치한 버튼은 색 변하게 하려고 했는데 구현 못함
              primary: Colors.white,
              onPrimary: Color(0xff7C83FD),
              backgroundColor: Colors.white,   // background color
              foregroundColor: Color(0xff7C83FD), // text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
              ),
              surfaceTintColor: Color(0xff7C83FD).withOpacity(0.1),
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
                    child: userResponse.personalInfo?.profileImageUrl == 'DEFAULT'
                        ? ClipOval(
                        child: Image.asset('assets/images/profile-mockup2.png', width: SizeConfig.defaultSize * 2.5, fit: BoxFit.cover,)
                    )
                        : ClipOval(
                        child: Image.network(
                          userResponse.personalInfo!.profileImageUrl,
                            width: SizeConfig.defaultSize * 2.5,
                            height: SizeConfig.defaultSize * 2.5,
                            fit: BoxFit.cover)
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.defaultSize * 1,),
                Text(
                  userResponse.personalInfo?.name ?? '이름',
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 2.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: SizeConfig.defaultSize * 1,),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize * 0.5,),
            Text(
              "${userResponse.personalInfo?.admissionYear.toString().substring(2,4) ?? 'xx'}학번 ${userResponse.university?.department ?? 'xx학과'}",
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
      )
    );
  }
}

class HintButton extends StatelessWidget {
  final String buttonName;
  final int point;

  const HintButton({
    super.key,
    required this.buttonName,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize * 40,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "$buttonName (${point}P)",
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 2,
          ),
        ),
      ),
    );
  }
}

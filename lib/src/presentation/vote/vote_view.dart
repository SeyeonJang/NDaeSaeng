import 'package:contacts_service/contacts_service.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/contact_friend.dart';
import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class VoteView extends StatefulWidget {
  const VoteView({Key? key}) : super(key: key);

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> with SingleTickerProviderStateMixin {
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late PermissionStatus _status = PermissionStatus.denied;
  late List<Contact> contacts = [];
  late List<ContactFriend> contactFriends = [];

  // 연락처 제공 동의
  Future<void> getPermission() async {
    _status = await Permission.contacts.status;

    if (_status.isGranted) { //연락처 권한 줬는지 여부
      contacts = await ContactsService.getContacts();
      for (int i=0; i<contacts.length; i++) {
        contactFriends.add(ContactFriend(name: contacts[i].givenName ?? '(알수없음)', phoneNumber: contacts[i].phones?[0].value ?? '010-xxxx-xxxx'));
      }
      context.read<VoteCubit>().state.setContacts(contactFriends);
    } else if (_status.isDenied) {
        await Permission.contacts.request();
        PermissionStatus status2 = await Permission.contacts.status;
        if (status2.isGranted) {
            contacts = await ContactsService.getContacts();
            for (int i=0; i<contacts.length; i++) {
              contactFriends.add(ContactFriend(name: contacts[i].givenName ?? '(알수없음)', phoneNumber: contacts[i].phones?[0].value ?? '010-xxxx-xxxx'));
            }
            if (contactFriends.isNotEmpty) {
              context.read<VoteCubit>().state.setContacts(contactFriends);
              context.read<VoteCubit>().refresh();
            } else {
              ToastUtil.showToast("연락처를 받아오는 데 실패했어요!");
            }
            context.read<VoteCubit>().refresh();
        } else if (status2.isDenied) {
          ToastUtil.showToast("연락처 제공을 동의해야\n더 많은 친구들과 앱을 즐겨요!");
        }
    }
    // 아이폰의 경우 OS가 금지하는 경우도 있고 (status.isRestricted) 안드로이드의 경우 아예 앱 설정에서 꺼놓은 경우 (status.isPermanentlyDenied) 도 있음
    if (_status.isPermanentlyDenied || _status.isRestricted) {
      openAppSettings();
    }
  }

  // // 연락처 모달 오픈
  // Future<void> showModal() async {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: ListView.builder(
  //           itemCount: _contacts?.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             Contact c = _contacts!.elementAt(index);
  //             var userName = c.displayName;
  //             var phoneNumber = c.phones?.first.value;
  //             return TextButton(
  //               onPressed: () {
  //                 _phoneNumberController.text = phoneNumber.toString();
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(userName ?? ""),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {

    Future.delayed(Duration.zero, () async => {
        await getPermission()
    });    // getPermission().then((_) => {})

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0,0.15),
      end: const Offset(0,0),
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
    super.initState();
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
        body: Center(
          child: BlocBuilder<VoteCubit, VoteState>(
            builder: (context, state) {
              Question question = state.questions[state.voteIterator];
              List<User> shuffledFriends = state.getShuffleFriends();
              List<ContactFriend> shuffledContacts = state.getShuffleContacts();

              late User friend1;
              late User friend2;
              late User friend3;

              if (shuffledFriends.length >= 1) {
                friend1 = shuffledFriends[0];
              }
              if (shuffledFriends.length >= 2) {
                friend2 = shuffledFriends[1];
              }
              if (shuffledFriends.length >= 3) {
                friend3 = shuffledFriends[2];
              }

              // User friend1 = shuffledFriends[0];
              // User friend2 = shuffledFriends[1];
              // User friend3 = shuffledFriends[2];
              // User friend4 = shuffledFriends[3];

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
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.83,
                    height: SizeConfig.defaultSize * 18,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            shuffledFriends.length >= 1
                              ? ChoiceFriendButton(
                                  userId: friend1.personalInfo!.id, name: friend1.personalInfo!.name, enterYear: friend1.personalInfo!.admissionYear.toString().substring(2,4), department: friend1.university?.department ?? "XXXX학과",
                                  questionId: question.questionId!,
                                  firstUserId: friend1.personalInfo!.id,
                                  secondUserId: shuffledFriends.length >= 2 ? friend2.personalInfo!.id : 0,
                                  thirdUserId: shuffledFriends.length >= 3 ? friend3.personalInfo!.id : 0,
                                  fourthUserId: 0,
                                  voteIndex: state.voteIterator,
                                  question: question.content!,
                                  gender: friend1.personalInfo!.gender,
                                  school: friend1.university!.name,
                                  disabledFunction: state.isLoading,
                                  profileImageUrl: friend1.personalInfo!.profileImageUrl,
                                )
                              : (_status.isGranted ? ContactsButton(state: state, contactPerson: shuffledContacts.length == 0 ? ContactFriend(name: '(알수없음)', phoneNumber: '010-xxxx-xxxx') : shuffledContacts[0], question: question.content!,) : NoContactsButton()),
                            shuffledFriends.length >= 2
                              ? ChoiceFriendButton(
                                userId: friend2.personalInfo!.id, name: friend2.personalInfo!.name, enterYear: friend2.personalInfo!.admissionYear.toString().substring(2,4), department: friend2.university?.department ?? "XXXX학과",
                                questionId: question.questionId!,
                                firstUserId: friend1.personalInfo!.id,
                                secondUserId: friend2.personalInfo!.id,
                                thirdUserId: shuffledFriends.length >= 3 ? friend3.personalInfo!.id : 0,
                                fourthUserId: 0,
                                voteIndex: state.voteIterator,
                                question: question.content!,
                                gender: friend1.personalInfo!.gender,
                                school: friend1.university!.name,
                                disabledFunction: state.isLoading,
                                profileImageUrl: friend1.personalInfo!.profileImageUrl,
                                )
                              : (_status.isGranted ? ContactsButton(state: state, contactPerson: shuffledContacts.length < 1 ? ContactFriend(name: '(알수없음)', phoneNumber: '010-xxxx-xxxx') : shuffledContacts[1], question: question.content!) : NoContactsButton()),
                          ],
                        ),
                        SizedBox(height: SizeConfig.defaultSize,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            shuffledFriends.length >= 3
                              ? ChoiceFriendButton(
                                  userId: friend3.personalInfo!.id, name: friend3.personalInfo!.name, enterYear: friend3.personalInfo!.admissionYear.toString().substring(2,4), department: friend3.university?.department ?? "XXXX학과",
                                  questionId: question.questionId!,
                                  firstUserId: friend1.personalInfo!.id,
                                  secondUserId: friend2.personalInfo!.id,
                                  thirdUserId: friend3.personalInfo!.id,
                                  fourthUserId: 0,
                                  voteIndex: state.voteIterator,
                                  question: question.content!,
                                  gender: friend1.personalInfo!.gender,
                                  school: friend1.university!.name,
                                  disabledFunction: state.isLoading,
                                  profileImageUrl: friend1.personalInfo!.profileImageUrl,
                               )
                              : (_status.isGranted ? ContactsButton(state: state, contactPerson: shuffledContacts.length < 2 ? ContactFriend(name: '(알수없음)', phoneNumber: '010-xxxx-xxxx'): shuffledContacts[2], question: question.content!) : NoContactsButton()),
                            _status.isGranted ? ContactsButton(state: state, contactPerson: shuffledContacts.length < 3 ? ContactFriend(name: '(알수없음)', phoneNumber: '010-xxxx-xxxx') : shuffledContacts[3], question: question.content!) : NoContactsButton()
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
                          Icon(CupertinoIcons.shuffle, size: SizeConfig.defaultSize * 2, color: const Color(0xff7C83FD),),
                          Text("  셔플", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600, color: const Color(0xff7C83FD))),
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
                      Expanded(child: Container(height: SizeConfig.defaultSize * 0.4, color: const Color(0xff7C83FD),)),
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

class NoContactsButton extends StatefulWidget {

  NoContactsButton({super.key});

  @override
  State<NoContactsButton> createState() => _NoContactsButtonState();
}

class _NoContactsButtonState extends State<NoContactsButton> {
  late PermissionStatus _status = PermissionStatus.denied;
  late List<Contact> contacts = [];
  late List<ContactFriend> contactFriends = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.defaultSize * 8.2,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () async {
          _status = await Permission.contacts.request();
          if (_status.isGranted) {
              contacts = await ContactsService.getContacts(withThumbnails: false);
              for (int i=0; i<contacts.length; i++) {
                contactFriends.add(ContactFriend(name: contacts[i].givenName ?? '(알수없음)', phoneNumber: contacts[i].phones?[0].value ?? '010-xxxx-xxxx'));
              }
              if (contactFriends.isNotEmpty) {
                context.read<VoteCubit>().state.setContacts(contactFriends);
                context.read<VoteCubit>().refresh();
              } else {
                ToastUtil.showToast("연락처를 받아오는 데 실패했어요!");
              }
          } else if (_status.isDenied) {
            ToastUtil.showToast("연락처 제공을 동의해야\n더 많은 친구들과 앱을 즐겨요!");
          }

          if (_status.isPermanentlyDenied || _status.isRestricted) {
            openAppSettings();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,   // background color
            foregroundColor: const Color(0xff7C83FD), // text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
            ),
            surfaceTintColor: const Color(0xff7C83FD).withOpacity(0.1),
            // surfaceTintColor: Color(0xff7C83FD).withOpacity(0.1),
            padding: EdgeInsets.all(SizeConfig.defaultSize * 1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset('assets/images/profile-mockup2.png', width: SizeConfig.defaultSize * 2.8, fit: BoxFit.cover,)),
              SizedBox(height: SizeConfig.defaultSize),
            Text('연락처에서 선택하기', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),)
          ],
        )
      ),
    );
  }
}

class ContactsButton extends StatelessWidget {
  ContactFriend? contactPerson;
  VoteState state;
  String question;

  ContactsButton({super.key, required this.contactPerson, required this.state, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.defaultSize * 8.2,
      color: Colors.white,
      child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext sheetContext) {
                  return GestureDetector(
                    child: AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("엔대생이 익명으로 보내드려요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                      content: const Text("'전송'을 누르면 엔대생이 직접\n내 친구에게 초대메시지를 보내요! 💌\n\n질문까지 담아서 익명으로 보내드린답니다-!\n적극적으로 메시지를 보내보세요! 😊", textAlign: TextAlign.center,),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (state.isLoading) return;
                            context.read<VoteCubit>().nextVoteWithContact();
                            Navigator.pop(sheetContext);
                          },
                          child: const Text('넘어가기', style: TextStyle(color: Colors.grey)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            context.read<VoteCubit>().inviteGuest(contactPerson?.name ?? '(알수없음)', contactPerson?.phoneNumber ?? '010-xxxx-xxxx', question);
                            ToastUtil.showToast("익명으로 메시지가 전송되었어요!");
                          },
                          child: const Text('전송', style: TextStyle(color: const Color(0xff7C83FD))),
                        )
                      ],
                    ),
                  );
                }
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,   // background color
              foregroundColor: const Color(0xff7C83FD), // text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
              ),
              surfaceTintColor: const Color(0xff7C83FD).withOpacity(0.1),
              padding: EdgeInsets.all(SizeConfig.defaultSize * 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                  child: Image.asset('assets/images/profile-mockup2.png', width: SizeConfig.defaultSize * 3, fit: BoxFit.cover,)),
                SizedBox(height: SizeConfig.defaultSize * 0.5),
              Text(contactPerson?.name ?? '(알수없음)', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, overflow: TextOverflow.ellipsis),)
            ],
          )
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
    Color textColor = const Color(0xff7C83FD);
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
          backgroundColor: Colors.white,   // background color
          foregroundColor: const Color(0xff7C83FD), // text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
          ),
            surfaceTintColor: const Color(0xff7C83FD).withOpacity(0.1),
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
                            width: SizeConfig.defaultSize * 2.5,
                            height: SizeConfig.defaultSize * 2.5,
                            fit: BoxFit.cover)
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
              SizedBox(height: SizeConfig.defaultSize * 0.5,),
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

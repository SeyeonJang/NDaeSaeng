import 'dart:io';
import 'package:dart_flutter/src/common/auth/dart_auth_cubit.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/mypage/view/my_ask.dart';
import 'package:dart_flutter/src/presentation/mypage/view/my_opinion.dart';
import 'package:dart_flutter/src/presentation/mypage/view/my_tos1.dart';
import 'package:dart_flutter/src/presentation/mypage/view/my_tos2.dart';
import 'package:dart_flutter/src/presentation/landing/land_pages.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../res/config/size_config.dart';

class MySettings extends StatelessWidget {
  final User userResponse;

  MySettings({super.key, required this.userResponse});

  @override
  Widget build(BuildContext context) {
    AnalyticsUtil.logEvent("내정보_설정_접속");
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          AnalyticsUtil.logEvent('내정보_설정_당겨서새로고침');
          context.read<MyPagesCubit>().refreshMyInfo();
        },
        child: BlocBuilder<MyPagesCubit, MyPagesState>(
          builder: (context, state) {
            return SafeArea(
              child: MyPageView(userResponse: userResponse, state: state),
            );
          },
        ),
      ),
    );
  }
}


class MyPageView extends StatefulWidget {
  final User userResponse;
  final MyPagesState state;

  MyPageView({super.key, required this.userResponse, required this.state});

  static final _defaultPadding = EdgeInsets.all(getFlexibleSize(target: 20));

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int get length => widget.state.myAllVotes.length; // TODO : titleVotes.length가 아니라 전체 질문들 받아와야됨
  String get name => widget.userResponse.personalInfo?.name ?? "XXX";
  String get universityName => widget.userResponse.university?.name ?? "XX대학교";
  String get department => widget.userResponse.university?.department ?? "XXX학과";
  String get admissionNumber =>
      "${widget.userResponse.personalInfo?.admissionYear ?? 'XX'}학번";
  String get newAdmissionNumber => getId(admissionNumber);
  String get gender => widget.userResponse.personalInfo?.gender ?? 'XX';
  String get newGender => getGender(gender);
  String get inviteCode => widget.userResponse.personalInfo?.recommendationCode ?? 'XXXXXXXX';
  String get userId => widget.userResponse.personalInfo?.id.toString() ?? '0';
  String get profileImageUrl => widget.userResponse.personalInfo?.profileImageUrl ?? 'DEFAULT';

  void onLogoutButtonPressed(BuildContext context) async {
    // 로그아웃 버튼 연결
    await BlocProvider.of<DartAuthCubit>(context).kakaoLogout();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LandPages()));
  }

  void halt() {
    print("앱을 강제 종료합니다.");
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  void restart() {
    print("앱을 재시작합니다.");
    Restart.restartApp();
  }

  String getId(String admissionYear) {
    return admissionYear.substring(2,6);
  }

  String getGender(String gender) {
    if (gender == "FEMALE") return "여자";
    if (gender == "MALE") return "남자";
    return "";
  }

  String nickname = "";
  @override
  void initState() {
    super.initState();
    nickname = widget.userResponse.personalInfo?.nickname ?? '닉네임';
  }

  void setNickname(String nickname) {
    setState(() {
      this.nickname = nickname;
      PersonalInfo updatedInfo = widget.userResponse.personalInfo!.copyWith(nickname: nickname);
      widget.userResponse.personalInfo = updatedInfo;
    });
  }

  final mbti1 = ['-','E','I'];
  final mbti2 = ['-','N','S'];
  final mbti3 = ['-','F','T'];
  final mbti4 = ['-','P','J'];
  int mbtiIndex1 = 0;
  int mbtiIndex2 = 0;
  int mbtiIndex3 = 0;
  int mbtiIndex4 = 0;

  File? _selectedImage;
  bool isSelectImage = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    AnalyticsUtil.logEvent("내정보_설정_프로필사진터치");
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        BlocProvider.of<MyPagesCubit>(context).uploadProfileImage(_selectedImage!, widget.userResponse);
        AnalyticsUtil.logEvent("내정보_설정_프로필사진변경");
        isSelectImage = true;
        BlocProvider.of<MyPagesCubit>(context).setProfileImage(_selectedImage!);
      });
    }
  }

  Widget _topBarSection(BuildContext context) => Row(children: [
        IconButton(
            onPressed: () {
              AnalyticsUtil.logEvent("내정보_설정_뒤로가기버튼");
              Navigator.pop(context, _selectedImage);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                size: SizeConfig.defaultSize * 2)),
        Text("설정",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: SizeConfig.defaultSize * 2,
            )),
      ]);

  Widget _infoSection(BuildContext context) => Padding(
    padding: MyPageView._defaultPadding,
    child: Column(
      children: [
        _topBarSection(context),
        const DtFlexSpacer(30),
        Center(
          child: GestureDetector(
            onTap: () {
              print('지금 상태는 $isSelectImage');
              _pickImage();
            },
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Container(
                  // decoration: BoxDecoration( // 이미지 겉에 테두리 효과주는 코드
                  //   gradient: LinearGradient(
                  //       colors: [Color(0xff7C83FD), Color(0xff7C83FD)]),
                  //   borderRadius: BorderRadius.circular(32),
                  // ),

                child: isSelectImage
                    ? ClipOval(
                      child: Image.file( // 이미지 파일에서 고르는 코드
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: SizeConfig.defaultSize * 12,
                        height: SizeConfig.defaultSize * 12,
                      ))
                    : ClipOval(
                      child: BlocBuilder<MyPagesCubit, MyPagesState>(
                      builder: (context, state) {
                        if (profileImageUrl == "DEFAULT" || !profileImageUrl.startsWith("https://"))
                          return Image.asset('assets/images/profile-mockup2.png', width: SizeConfig.defaultSize * 12, fit: BoxFit.cover,);
                        else {
                          return state.profileImageFile.path==''
                              ? Image.network(profileImageUrl,
                              width: SizeConfig.defaultSize * 12,
                              height: SizeConfig.defaultSize * 12,
                              fit: BoxFit.cover)
                              : Image.file(state.profileImageFile,
                              width: SizeConfig.defaultSize * 12,
                              height: SizeConfig.defaultSize * 12,
                              fit: BoxFit.cover);
                          // print('================================================================');
                          // print(state.userResponse.personalInfo!.profileImageUrl);
                          // return Image.network(state.userResponse.personalInfo!.profileImageUrl,
                          //         width: SizeConfig.defaultSize * 5.7,
                          //         height: SizeConfig.defaultSize * 5.7,
                          //         fit: BoxFit.cover);
                        }
                      }
                  ),
                )
              ),
            ),
          ),
        ),
        // const DtFlexSpacer(15),

        SizedBox(
          width: SizeConfig.defaultSize * 3,
          height: SizeConfig.defaultSize * 3,
          child: widget.state.isLoading ? const CircularProgressIndicator(color: Color(0xff7C83FD)) : null,
        ),

        Padding( // 받은 투표 프로필 (TitleVotes)
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.3),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 15.5,
            decoration: BoxDecoration(
              color: Color(0xff7C83FD),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize * 0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i=0; i<widget.state.titleVotes.length; i++) // TitleVote 있을 때
                    GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext dialogContext) => AlertDialog(
                            title: const Text('내 투표를 삭제하시겠어요?'),
                            content: Text('삭제할 투표 : ${widget.state.titleVotes[i].question.content}'),
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext, '취소');
                                },
                                child: const Text('취소', style: TextStyle(color: Color(0xff7C83FD)),),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (context.read<MyPagesCubit>().state.isLoading == true) {
                                    return;
                                  }                                  context.read<MyPagesCubit>().removeTitleVote(widget.state.titleVotes[i].question.questionId!, widget.userResponse); // TitleVote 삭제
                                  context.read<MyPagesCubit>().refreshMyInfo();
                                  Navigator.pop(dialogContext, '삭제');
                                },
                                child: const Text('삭제', style: TextStyle(color: Color(0xff7C83FD)),),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.defaultSize * 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: SizeConfig.screenWidth * 0.53,
                                    child: Text(
                                      "${widget.state.titleVotes[i].question.content}", style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.6,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis
                                    ),)
                                ),
                                widget.state.titleVotes[i].count < 5
                                    ? Text(" ", style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.6,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis
                                ),)
                                    : Text("${(widget.state.titleVotes[i].count~/5)*5}+", style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.6,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis
                                ),)
                              ],
                            ),
                          )
                      ),
                    ),
                  for (int i=0; i<3-widget.state.titleVotes.length; i++) // TitleVote 없을 때
                    GestureDetector(
                      onTap: () async {
                        if (context.read<MyPagesCubit>().state.isLoading) {
                          return;
                        }

                        await context.read<MyPagesCubit>().getAllVotes();
                        print("UI get - ${widget.state.myAllVotes}");

                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext modalContext) {
                              return Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Container(
                                        width: SizeConfig.screenWidth,
                                        height: SizeConfig.defaultSize * 5,
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: SizeConfig.screenWidth * 0.2,
                                          height: SizeConfig.defaultSize * 0.4,
                                          color: Colors.black,
                                        )
                                    ),
                                      SizedBox(height: SizeConfig.defaultSize,),
                                    Text("투표를 눌러서 내 프로필에 넣어보세요!", style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 1.6
                                    ),),
                                      SizedBox(height: SizeConfig.defaultSize * 2,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.8, horizontal: SizeConfig.defaultSize * 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: SizeConfig.screenWidth * 0.6,
                                              child: Text(
                                                "투표명", style: TextStyle(
                                                  fontSize: SizeConfig.defaultSize * 1.8,
                                                  color: Colors.black,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w600
                                              ),)
                                          ),
                                          Text("받은 개수", style: TextStyle(
                                              fontSize: SizeConfig.defaultSize * 1.8,
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600
                                          ),)
                                        ],
                                      ),
                                    ),
                                      SizedBox(height: SizeConfig.defaultSize),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        height: SizeConfig.defaultSize * 0.2,
                                        color: Colors.grey.shade300,
                                      ),

                                      Flexible(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              for (int j=0; j<widget.state.myAllVotes.length; j++) // (MyAllVotes의 개수만큼 반복)
                                                GestureDetector(
                                                onTap: () {
                                                  context.read<MyPagesCubit>().addTitleVote(widget.state.myAllVotes[j], widget.userResponse); // add
                                                  context.read<MyPagesCubit>().refreshMyInfo();
                                                  Navigator.pop(modalContext);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 3),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: SizeConfig.screenWidth * 0.66,
                                                        child: Text(
                                                          "${widget.state.myAllVotes[j].question.content}", style: TextStyle(
                                                          fontSize: SizeConfig.defaultSize * 1.8,
                                                          color: Colors.black,
                                                          overflow: TextOverflow.ellipsis
                                                        ),)
                                                      ),
                                                      widget.state.myAllVotes[j].count < 5
                                                          ? Text("${widget.state.myAllVotes[j].count}", style: TextStyle(
                                                          fontSize: SizeConfig.defaultSize * 1.8,
                                                          color: Colors.black,
                                                          overflow: TextOverflow.ellipsis
                                                          ),)
                                                          : Text("${(widget.state.myAllVotes[j].count~/5)*5}+", style: TextStyle(
                                                          fontSize: SizeConfig.defaultSize * 1.8,
                                                          color: Colors.black,
                                                          overflow: TextOverflow.ellipsis
                                                          ),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ],
                                )
                              );
                            }
                        );
                        print("내 대표 투표의 개수 ${widget.state.titleVotes.length+1}");
                      },
                      child: Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.defaultSize * 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text("눌러서 프로필 채우기", style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w500, fontSize: SizeConfig.defaultSize * 1.4),)
                      ),
                    )
                ],
              ),
            ),
          ),
        ),

        const DtFlexSpacer(15),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getFlexibleSize(),
              horizontal: getFlexibleSize(target: 20)), // Comma was missing here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoSectionItem(title: "이름", value: name),
              _infoSectionItem(title: "닉네임", value: nickname=='DEFAULT'||nickname==''? '닉네임' : nickname),
              _infoSectionItem(title: "학교", value: universityName),
              _infoSectionItem(title: "학과", value: department),
              _infoSectionItem(title: "학번", value: newAdmissionNumber),
              _infoSectionItem(title: "성별", value: newGender),
              _infoSectionItem(title: "초대코드", value: inviteCode),
              // Container( // MBTI 구현은 완료해둠
              //   height: SizeConfig.defaultSize * 5,
              //   child: Flexible(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("MBTI", style: TextStyle(
              //           fontSize: SizeConfig.defaultSize * 1.6,
              //           fontWeight: FontWeight.w400,
              //         ),),
              //         CupertinoButton.filled(
              //           padding: EdgeInsets.fromLTRB(10,0,10,0),
              //           onPressed: () {
              //             showCupertinoModalPopup(
              //             context: context,
              //             builder: (context) => CupertinoActionSheet(
              //               actions: [buildPicker()],
              //               cancelButton: CupertinoActionSheetAction(
              //                 child: Text("취소"),
              //                 onPressed: () => Navigator.pop(context),
              //               ),
              //               ),
              //           );},
              //           child: Text(mbti1[mbtiIndex1]+mbti2[mbtiIndex2]+mbti3[mbtiIndex3]+mbti4[mbtiIndex4]),
              //           // TODO : state, cubit 만들어서 선택한 MBTI 저장해야함 + 서버 넘겨야함 (MEET)
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ),
  );

  Container buildPicker() { // MBTI 고르는 화면
    return Container(
      height: SizeConfig.screenHeight * 0.3,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti1.length, (index) {
                final isSelected = mbtiIndex1 == index;
                final item = mbti1[index];
                final color =
                    isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex1 = index);
                print('Selected item: ${mbti1}');
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti2.length, (index) {
                final isSelected = mbtiIndex2 == index;
                final item = mbti2[index];
                final color =
                isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex2 = index);
                print('Selected item: ${mbti2}');
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti3.length, (index) {
                final isSelected = mbtiIndex3 == index;
                final item = mbti3[index];
                final color =
                isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex3 = index);
                print('Selected item: ${mbti3}');
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti4.length, (index) {
                final isSelected = mbtiIndex4 == index;
                final item = mbti4[index];
                final color =
                isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex4 = index);
                print('Selected item: ${mbti4}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSectionItem({required String title, required String value}) {
    if (title == "닉네임") {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: getFlexibleSize(target: 12)),
        child: GestureDetector(
          onTap: () {
            AnalyticsUtil.logEvent("내정보_설정_내정보", properties: {
              "회원 정보 타입": title, "회원 정보 내용": value
            });
            TextEditingController _textController = TextEditingController();
            showDialog<String>(
                context: context,
                builder: (BuildContext dialogContext) {
                  return StatefulBuilder(
                    builder: (statefulContext, setState) =>
                        AlertDialog(
                          title: Text('닉네임을 변경하시겠어요?',
                            style: TextStyle(fontSize: SizeConfig.defaultSize *
                                2), textAlign: TextAlign.center,),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('바꾸고 싶은 닉네임을 입력해주세요!', style: TextStyle(
                                  fontSize: SizeConfig.defaultSize * 1.4),
                                textAlign: TextAlign.start,),
                              const Text('닉네임은 최대 7글자예요!'),
                              TextField(
                                controller: _textController,
                                maxLength: 7,
                                onChanged: (text) {
                                  setState(() {}); // Rebuild the AlertDialog when text changes
                                },
                                decoration: InputDecoration(
                                  hintText: "바꿀 닉네임을 작성해주세요!",
                                  hintStyle: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),
                                  contentPadding: EdgeInsets.zero,
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.6)),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                AnalyticsUtil.logEvent("내정보_설정_닉네임변경_취소");
                                Navigator.pop(dialogContext, '취소');
                              },
                              child: const Text('취소',
                                style: TextStyle(color: Color(0xff7C83FD)),),
                            ),
                            TextButton(
                              onPressed: () {
                                var nick = _textController.text;
                                setNickname(nick);

                                BlocProvider.of<MyPagesCubit>(context).patchMyInfo(widget.userResponse);
                                Navigator.pop(dialogContext);
                                AnalyticsUtil.logEvent("내정보_설정_닉네임변경_완료");
                              },
                                child: Text('완료', style: TextStyle(color: Color(0xff7C83FD)))
                            ),
                          ],
                        ),
                  );
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getFlexibleSize(target: 16),
                ),
              ),
              Text(
                value,
                // newNickname=='' || newNickname==value ? value : newNickname,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getFlexibleSize(target: 16),
                  color: Color(0xff7C83FD)
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: getFlexibleSize(target: 12)),
        child: GestureDetector(
          onTap: () {
            if (title != '이름') {
              AnalyticsUtil.logEvent("내정보_설정_내정보", properties: {
                "회원 정보 타입": title, "회원 정보 내용": value
              });
            } else {
              AnalyticsUtil.logEvent("내정보_설정_내정보", properties: {
                "회원 정보 타입": title, "회원 정보 내용": "이름"
              });
            }
            if (title == "초대코드") {
              String myCodeCopy = value;
              Clipboard.setData(ClipboardData(text: value));
              ToastUtil.showToast("내 코드가 복사되었어요!");
              AnalyticsUtil.logEvent("내정보_설정_내코드터치");
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getFlexibleSize(target: 16),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getFlexibleSize(target: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void shareContent(BuildContext context, String myCode) {
    Share.share('[엔대생] 엔대생에서 내가 널 칭찬 대상으로 투표하고 싶어! 앱에 들어와줘!\n내 코드는 $myCode 야. 나를 친구 추가하고 같이하자!\nhttps://dart.page.link/TG78\n\n내 코드 : $myCode');
    print("셰어");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _infoSection(context),
          const DtFlexSpacer(20),

          const DtDivider(),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.defaultSize * 1.5,),
                    TextButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("내정보_설정_스토어리뷰작성");
                        launchUrl(
                          Uri(
                            scheme: 'https',
                            host: 'dart.page.link',
                            path:
                            'TG78',
                          ),
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                      child: Text("스토어에서 엔대생 리뷰 작성하기",
                          style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
                    ),
                    TextButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("내정보_설정_앱공유");
                        shareContent(context, inviteCode);
                      },
                      child: Text("엔대생 링크 공유하기",
                          style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 1.5,),
                  ])),

          const DtDivider(),
          Padding(
            // padding: MyPageView._defaultPadding,
            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
            child: Column(
              children: [
                const DtFlexSpacer(10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () async {
                            AnalyticsUtil.logEvent("내정보_설정_회원탈퇴버튼");
                            TextEditingController textController = TextEditingController();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return StatefulBuilder(
                                    builder: (statefulContext, setState) => AlertDialog(
                                      title: Text('앱을 회원탈퇴 하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 2), textAlign: TextAlign.center,),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('엔대생을 떠나지 말아요 ... 🥺', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4), textAlign: TextAlign.start,),
                                          const Text('회원탈퇴를 원하시면 \'회원탈퇴를 원해요\'라고 적어주세요.'),
                                          TextField(
                                            controller: textController,
                                            onChanged: (text) {
                                              setState(() {}); // Rebuild the AlertDialog when text changes
                                            },
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            AnalyticsUtil.logEvent("내정보_설정_회원탈퇴_취소");
                                            Navigator.pop(dialogContext, '아니요');
                                          },
                                          child: const Text('아니요', style: TextStyle(color: Color(0xff7C83FD)),),
                                        ),
                                        TextButton(
                                            onPressed: textController.text == '회원탈퇴를 원해요' ? () async {
                                              AnalyticsUtil.logEvent("내정보_설정_회원탈퇴_탈퇴확정");
                                              Navigator.pop(dialogContext);
                                              await BlocProvider.of<DartAuthCubit>(context).kakaoWithdrawal();
                                              ToastUtil.showToast("회원탈퇴가 완료되었습니다.\n잠시후 앱이 종료됩니다.");
                                              await Future.delayed(const Duration(seconds: 2));
                                              restart();
                                            } : null,
                                            child: textController.text == '회원탈퇴를 원해요'
                                                ? Text('탈퇴', style: TextStyle(color: Color(0xff7C83FD)))
                                                : Text('탈퇴', style: TextStyle(color: Colors.grey,))
                                        ),
                                      ],
                                    ),
                                );
                              }
                            );
                          },
                          child: Text(
                            "회원탈퇴",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getFlexibleSize(target: 14),
                              color: Colors.grey
                            ),
                          )),
                      const DtFlexSpacer(2),
                      TextButton(
                          onPressed: () {
                            AnalyticsUtil.logEvent("내정보_설정_로그아웃버튼");
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext dialogContext) => AlertDialog(
                                title: Text('로그아웃을 하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 2),),
                                // content: const Text('사용자를 신고하면 Dart에서 빠르게 신고 처리를 해드려요!'),
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      AnalyticsUtil.logEvent("내정보_설정_로그아웃_취소");
                                      Navigator.pop(dialogContext, '아니요');
                                    },
                                    child: const Text('아니요', style: TextStyle(color: Color(0xff7C83FD)),),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      AnalyticsUtil.logEvent("내정보_설정_로그아웃_로그아웃확정");
                                      Navigator.pop(dialogContext);
                                      ToastUtil.showToast("로그아웃이 완료되었습니다.\n잠시후 앱이 종료됩니다.");
                                      BlocProvider.of<DartAuthCubit>(context).kakaoLogout();
                                      await Future.delayed(const Duration(seconds: 2));
                                      restart();
                                    },
                                    child: const Text('네', style: TextStyle(color: Color(0xff7C83FD)),),
                                  ),
                                ],
                              ),
                            );
                          },
                        child: Text("로그아웃",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getFlexibleSize(target: 14),
                                color: Colors.grey

                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                const DtFlexSpacer(10),
              ],
            ),
          ),
          const DtDivider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.defaultSize * 1.5,),
              TextButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("내정보_설정_이용약관");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTos1()));
                },
                child: Text("이용약관",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
              TextButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("내정보_설정_개인정보처리방침");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTos2()));
                },
                child: Text("개인정보 처리방침",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
              TextButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("내정보_설정_건의하기");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOpinion()));
                  // launchUrl(
                  //   Uri(
                  //     scheme: 'https',
                  //     host: 'tally.so',
                  //     path:
                  //     'r/mYR270',
                  //   ),
                  //   mode: LaunchMode.inAppWebView,
                  // );
                },
                child: Text("건의하기",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
              TextButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("내정보_설정_1대1");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAsk()));
                //   launchUrl(
                //     Uri(
                //       scheme: 'https',
                //       host: 'tally.so',
                //       path:
                //       'r/wzNV5E',
                //     ),
                //     mode: LaunchMode.inAppWebView,
                //   );
                },
                child: Text("1:1 문의",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),

                  const DtDivider(),
                  const DtFlexSpacer(20),
                 Container(
                   alignment: Alignment.center,
                  child: Text("엔대생 v${context.read<MyPagesCubit>().state.appVersion}",
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, color: Colors.grey)),
                 ),
                  const DtFlexSpacer(20),

                  ],
            ),
          ),
        ],
      ),
    );
  }
}

class DtDivider extends StatelessWidget {
  final double? height;

  const DtDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? getFlexibleSize(target: 15),
      color: Colors.grey.shade100,
    );
  }
}

class DtFlexSpacer extends StatelessWidget {
  final double size;
  final bool flexible;

  const DtFlexSpacer(this.size, {super.key, this.flexible = true});

  @override
  Widget build(BuildContext context) {
    final double resultSize = flexible ? getFlexibleSize(target: size) : size;
    return SizedBox(width: resultSize, height: resultSize);
  }
}

import 'dart:io';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/component/meet_progress_indicator.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class StudentVertification extends StatelessWidget {
  // 인증전
  final User userResponse;

  const StudentVertification({super.key, required this.userResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<MyPagesCubit>(
          create: (context) => MyPagesCubit(), child: SafeArea(child: VertificationView(userResponse: userResponse))),
    );
  }
}

class VertificationView extends StatefulWidget {
  final User userResponse;

  const VertificationView({
    super.key,
    required this.userResponse,
  });

  @override
  State<VertificationView> createState() => _VertificationViewState();
}

class _VertificationViewState extends State<VertificationView> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: const Offset(0, 0),
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

  // 이미지 파일
  File? _image;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  bool isUploaded = false;

  // String get vertification => widget.userResponse.user?.verification ?? 'DEFAULT';

  // 이름 텍스트 입력
  final TextEditingController _nameController = TextEditingController();
  bool isNameValid = false;
  String errorMessage = '';

  void _checkNameValidity() {
    setState(() {
      String name = _nameController.text.trim();
      isNameValid = name.isNotEmpty && name.length <= 4;
      errorMessage = !isNameValid ? '이름은 실명 & 4글자 이하로 입력해주세요.' : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MyPagesCubit, MyPagesState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // 애니메이션 위까지 위층
                    children: [
                      Row(children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              AnalyticsUtil.logEvent("학생증인증_뒤로가기");
                            },
                            icon: Icon(Icons.arrow_back_ios_new_rounded, size: SizeConfig.defaultSize * 2)),
                      ]),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      _VerificationPageHeader(isUploaded: isUploaded, verification: widget.userResponse.personalInfo?.verification ?? IdCardVerificationStatus.NOT_VERIFIED_YET)
                    ],
                  ),
                  widget.userResponse.personalInfo!.verification.isNotVerifiedYet || widget.userResponse.personalInfo!.verification.isVerificationFailed
                      ? isUploaded == false // 사진업로드를 했는가
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  // 학생증 사진 예시
                                  children: [
                                    SizedBox(height: SizeConfig.defaultSize * 4),
                                    Image.asset(
                                      'assets/images/idcard.png',
                                      // color: Colors.indigo,
                                      height: SizeConfig.defaultSize * 30,
                                    ),
                                    const Text("이름, 학교, 학번이 모두 나오게 업로드해주세요!", style: TextStyle(color: Color(0xffFF5C58))),
                                    SizedBox(height: SizeConfig.defaultSize * 4),
                                  ],
                                ),
                                Column(
                                  // 학생증 사진 업로드하기 (카메라 or 갤러리)
                                  children: [
                                    const _VerificationPageInformationButton(),
                                    _VerificationCameraButton(),
                                    SizedBox(height: SizeConfig.defaultSize * 0.5,),
                                    _VerificationGalleryButton(),
                                    SizedBox(height: SizeConfig.screenHeight * 0.03,),
                                  ],
                                ),
                              ],
                          )
                          : Column(
                              // 학생증 사진 업로드 이후, 이름 입력 후 제출하기 버튼이 있는 곳
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  _VerificationNameInputField(),  // 이름 입력
                                  SizedBox(height: SizeConfig.defaultSize * 2,),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: SizedBox(
                                          width: SizeConfig.screenWidth * 0.9,
                                          height: SizeConfig.screenWidth * 0.9,
                                          // child: Image.asset('/assets/images/profile-mockup3.png', fit: BoxFit.fill,)
                                          child: Image.file(
                                            // 이미지 파일에서 고르는 코드
                                            _image!,
                                            fit: BoxFit.contain,
                                          ))),
                                  SizedBox(height: SizeConfig.defaultSize * 6,),
                                  GestureDetector(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: SizeConfig.screenWidth,
                                      height: SizeConfig.defaultSize * 6,
                                      child: isNameValid
                                          ? ElevatedButton(
                                              onPressed: () async {
                                                if (_isLoading) return;
                                                AnalyticsUtil.logEvent("학생증인증_제출");

                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                PersonalInfo updatedInfo = widget.userResponse.personalInfo!.copyWith(verification: IdCardVerificationStatus.VERIFICATION_IN_PROGRESS);
                                                await BlocProvider.of<MyPagesCubit>(context).uploadIdCardImage(_image!, widget.userResponse, _nameController.text);
                                                widget.userResponse.personalInfo = updatedInfo; // 상위 위젯 상태 업데이트
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xffFF5C58),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                                ),
                                              ),
                                              child: Text(
                                                "제출하기",
                                                style: TextStyle(
                                                    fontSize: SizeConfig.defaultSize * 2,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              )
                                      )
                                          : ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[20]),
                                              child: Text(
                                                "이름을 입력해주세요",
                                                style: TextStyle(
                                                    fontSize: SizeConfig.defaultSize * 2,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black38),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.03,
                                  ),
                              ],
                          )
                      : _VerificationPageInProgress(animation: _animation),  // 학생증 인증 중일경우 보이는 화면
                ],
              ),
            ),
            ),
          );
        }),

        // 로딩 인디게이터
        _isLoading
            ? const MeetProgressIndicatorFullScreen(
                text: "학생증을 제출하고 있어요!",
                color: Colors.white,
                opacity: 0.5,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  TextFormField _VerificationNameInputField() {
    return TextFormField(
                                    controller: _nameController,
                                    onChanged: (_) => _checkNameValidity(),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade200, // 테두리 색상
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffFF5C58), // 테두리 색상
                                            width: 2.0,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.person_rounded,
                                          color: Color(0xffFF5C58),
                                        ),
                                        hintText: "본인확인을 위한 실명을 입력해주세요!"));
  }

  GestureDetector _VerificationGalleryButton() {
    return GestureDetector(
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                      isUploaded = true;
                                      AnalyticsUtil.logEvent("학생증인증_갤러리업로드");
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth,
                                      height: SizeConfig.defaultSize * 6,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1.5, color: const Color(0xffFF5C58))),
                                      child: Center(
                                          child: Text("갤러리에서 사진 업로드",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: SizeConfig.defaultSize * 2,
                                                  color: Colors.black))),
                                    ),
                                  );
  }

  GestureDetector _VerificationCameraButton() {
    return GestureDetector(
                                    onTap: () {
                                      getImage(ImageSource.camera);
                                      isUploaded = true;
                                      AnalyticsUtil.logEvent("학생증인증_카메라업로드");
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth,
                                      height: SizeConfig.defaultSize * 6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFF5C58),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "사진 촬영하기",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: SizeConfig.defaultSize * 2,
                                            color: Colors.white),
                                      )),
                                    ),
                                  );
  }
}

class _VerificationPageInProgress extends StatelessWidget {
  const _VerificationPageInProgress({
    super.key,
    required Animation<Offset> animation,
  }) : _animation = animation;

  final Animation<Offset> _animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // 애니메이션 가운데층
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _animation,
            child: GestureDetector(
              onTap: () {
                AnalyticsUtil.logEvent("학생증인증_세번째화면_아이콘터치");
              },
              child: Image.asset(
                'assets/images/magnifier.png',
                width: SizeConfig.defaultSize * 33,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Column(children: [
            Text("학생증을 확인중이에요!",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.2,
                )),
            SizedBox(
              height: SizeConfig.defaultSize * 1,
            ),
            Text("인증이 되면 알려드릴게요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2))
          ]),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
        ],
      ),
    );
  }
}

class _VerificationPageInformationButton extends StatelessWidget {
  const _VerificationPageInformationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          AnalyticsUtil.logEvent("학생증인증_첫번째화면_설명터치");
          showDialog<String>(
              context: context,
              builder: (BuildContext dialogContext) => AlertDialog(
                    surfaceTintColor: Colors.white,
                    title: Center(
                        child: Text(
                      '엔대생은 학생증 인증을 하고 있어요!',
                      style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.5,
                          fontWeight: FontWeight.w500),
                    )),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.defaultSize,
                          ),
                          const Center(
                              child: Text(
                            '엔대생 앱 안에서의 원활한 활동을 위해',
                          )),
                          const Center(child: Text('학생증 인증으로 본인인증을 하고 있어요!')),
                          const Center(child: Text('지금 바로 학생증으로 본인인증 해보세요!')),
                          SizedBox(
                            height: SizeConfig.defaultSize * 2.2,
                          ),
                          Center(
                              child: Text(
                            '학생증 인증은 최대 2~3일 소요될 수 있으며',
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2),
                          )),
                          Center(
                              child: Text(
                            '인증 과정 중에도 앱을 이용할 수 있어요!',
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2),
                          )),
                        ],
                      ),
                    ),
                  ));
        },
        style: TextButton.styleFrom(
            backgroundColor: Colors.white, surfaceTintColor: Colors.white),
        child:

        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.info_outline, size: SizeConfig.defaultSize * 1.5, color: Colors.grey),
              ),
              TextSpan(
                text: " 학생증 인증은 왜 필요한가요?",
                style: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.4),
              ),
            ],
          ),
        )
        // Text(
        //   "학생증 인증은 왜 필요한가요?",
        //   style: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.4),
        // ),
    );
  }
}

class _VerificationPageHeader extends StatelessWidget {
  const _VerificationPageHeader({
    super.key,
    required this.isUploaded,
    required this.verification,
  });

  final bool isUploaded;
  final IdCardVerificationStatus verification;

  @override
  Widget build(BuildContext context) {
    return verification.isNotVerifiedYet || verification.isVerificationFailed
        ? Column(children: [
            Text("지금 학생증 인증하면",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.2,
                )),
            SizedBox(
              height: SizeConfig.defaultSize * 0.3,
            ),
            Text("내 프로필에 인증배지가!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2)),
            SizedBox(
              height: SizeConfig.defaultSize * 0.5,
            ),
            if (!isUploaded)
              if (verification.isVerificationFailed)
                Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    ),
                    Text("학생증 사진이 또렷하지 않아 실패했어요!",
                        style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, color: Colors.red)),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    Text("이름, 학교, 학번이 모두 나오도록 다시 촬영해보세요!",
                        style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Colors.red)),
                  ],
                )
          ])
        : const SizedBox.shrink();
  }
}

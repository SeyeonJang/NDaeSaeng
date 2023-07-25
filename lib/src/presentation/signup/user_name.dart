import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_phone.dart';

// #1-5 이름 입력
class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  TextEditingController _nameController = TextEditingController();
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.15,
            ),
            Text("이름을 입력해주세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.7, fontWeight: FontWeight.w700)),
            SizedBox(
              height: SizeConfig.defaultSize * 1.5,
            ),
            Text("이후 변경할 수 없어요! 신중히 입력해주세요!",
                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, color: Colors.grey)),
            SizedBox(
              height: SizeConfig.defaultSize * 10,
            ),

            SizedBox( // 입력 공간 Textfield
                width: SizeConfig.screenWidth * 0.9,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                        onChanged: (_) => _checkNameValidity(),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade200, // 테두리 색상
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff7C83FD), // 테두리 색상
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person_rounded, color: Color(0xff7C83FD),),
                            hintText: "이름(본명)을 입력해주세요!")),
                    SizedBox(height: SizeConfig.defaultSize * 0.8), // 에러 메시지와 입력 필드 사이의 간격 조정
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.6),
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: SizeConfig.defaultSize * 1.3),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                ),
            SizedBox(
              height: SizeConfig.defaultSize * 10,
            ),
            Container(
              width: SizeConfig.screenWidth * 0.9,
              height: SizeConfig.defaultSize * 5,
              child: isNameValid
                  ? ElevatedButton(
                  onPressed: () {
                    AnalyticsUtil.logEvent("회원가입_이름_다음");
                    BlocProvider.of<SignupCubit>(context).stepName(_nameController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7C83FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                    ),
                  ),
                  child: Text("다음으로", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.white),)
              )
                  : ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  child: Text("이름을 입력해주세요", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.black38),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

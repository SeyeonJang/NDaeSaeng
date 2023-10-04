import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';

class UserPhone extends StatefulWidget {

  const UserPhone({super.key});

  @override
  State<UserPhone> createState() => _UserPhoneState();
}

class _UserPhoneState extends State<UserPhone> {
  final TextEditingController _phoneController = TextEditingController();
  bool isPhoneValid = false;
  String? phoneErrorMessage;

  void _checkPhoneValidity() {
    final phonePattern = RegExp(r'^01[016789]\d{3,4}\d{4}$');
    final phoneNumber = _phoneController.text.trim();

    setState(() {
      isPhoneValid = phonePattern.hasMatch(phoneNumber);
      phoneErrorMessage = isPhoneValid ? null : '전화번호를 확인해주세요!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
              SizedBox(height: SizeConfig.screenHeight * 0.15,),
            Text("전화번호를 입력해주세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.7, fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.defaultSize * 1.5,),
            Text("이후 변경할 수 없어요! 신중히 입력해주세요!",
                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, color: Colors.grey)),
              SizedBox(height: SizeConfig.defaultSize * 10,),

            SizedBox(
              width: SizeConfig.screenWidth * 0.9,
              child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff7C83FD),
                          width: 2.0,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.person_rounded, color: Color(0xff7C83FD),),
                      hintText: "010xxxxoooo 형식으로 입력해주세요!",
                      errorText: phoneErrorMessage,),
                onSaved: (String? value) {},
                onChanged: (_) => _checkPhoneValidity(),
                controller: _phoneController,
              ),
            ),
              SizedBox(height: SizeConfig.defaultSize * 10,),

            SizedBox(
              width: SizeConfig.screenWidth * 0.9,
              height: SizeConfig.defaultSize * 5,
              child: isPhoneValid
                  ? ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SignupCubit>(context).stepPhone(_phoneController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7C83FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text("다음으로", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.white),)
              )
                  : ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  child: Text("전화번호를 입력해주세요", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.black38),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

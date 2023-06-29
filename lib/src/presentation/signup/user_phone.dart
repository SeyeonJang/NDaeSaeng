import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/state/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cert_num.dart';

// btn 컬러 정의 (설정중)
Color getColor(Set<MaterialState> states) { //
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed, // 클릭했을 때
    MaterialState.hovered, // 마우스 커서를 상호작용 가능한 버튼 위에 올려두었을 때
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blueAccent; // text color값 설정 -> Colors
  }
  return Colors.grey;
}
// text 컬러 정의 (설정중)
Color getColorText(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed, // 클릭했을 때
    MaterialState.hovered, // 마우스 커서를 상호작용 가능한 버튼 위에 올려두었을 때
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.white; // text color값 설정 -> Colors
  }
  return Colors.black;
}


class UserPhone extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  UserPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: const Text('User Phone'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 85,
            ),
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return Text('환영해요! ${state.inputState.name!}님', style: TextStyle(fontSize: 15));
              },
            ),
            Text("전화번호 입력", style: TextStyle(fontSize: 25)),
            const SizedBox(height: 140),
            SizedBox(
              width: 400,
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "010-0000-0000 형태로 입력해주세요!"
                ),
                onSaved: (String? value) {},
                // 유효성 검사 필요 ********************* (수정 안 됨)
                // validator: (String? value) {
                //   return (value == null || !value.contains('-')) ? "전화번호는 010-0000-0000 형식이어야 해요!" : null;
                // },
                controller: _phoneController,
              ),
            ),
            const SizedBox(height: 160),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<SignupCubit>(context).stepPhone(_phoneController.text);
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
                backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
              ),
              child: const Text('인증번호 받기'),
            ),
          ],
        ),
      ),
    );
  }
}

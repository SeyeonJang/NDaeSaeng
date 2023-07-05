import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class MeetThreePeoplePage extends StatefulWidget {
  const MeetThreePeoplePage({super.key});

  @override
  State<MeetThreePeoplePage> createState() => _MeetThreePeoplePageState();
}

class _MeetThreePeoplePageState extends State<MeetThreePeoplePage> {
  void showAlert() {
    QuickAlert.show(
        type: QuickAlertType.confirm,
        context: context,
        title: "3대3 과팅을 신청하시겠어요?",
        text: "제출하면 프로필을 수정할 수 없어요!\n신중히 제출해주세요!",
        confirmBtnText: '신청',
        cancelBtnText: '취소',
        onConfirmBtnTap: () {
          BlocProvider.of<MeetCubit>(context).stepThreePeopleDone();
          Navigator.of(context).pop(); // 다이얼로그 닫기
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 임시 View **********************
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<MeetCubit>(context).stepMeetLanding();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  showAlert();
                  // BlocProvider.of<MeetCubit>(context).stepTwoPeopleDone();
                },
                child: Text("신청하기", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4,
                  fontWeight: FontWeight.w500,
                )),
              ),
            ],
          )
      ),
    );
  }
}

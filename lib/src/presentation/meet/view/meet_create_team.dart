import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class MeetCreateTeam extends StatelessWidget {
  const MeetCreateTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize * 1.3),
                child: Column(
                  children: [
                    _CreateTeamTopSection(userResponse: state.userResponse),
                    // 나
                    _MemberCardView()
                    // 친구1
                    // 친구2
                    // 버튼
                  ],
                ),
              ),
            );
          }
        ),
      ),
      bottomNavigationBar: Container(

      ),
    );
  }
}

class _CreateTeamTopSection extends StatelessWidget {
  User userResponse;

  _CreateTeamTopSection({
    super.key,
    required this.userResponse
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          SizedBox(height: SizeConfig.defaultSize),
        Row(children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  size: SizeConfig.defaultSize * 2)),
          Text("과팅 팀 만들기",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: SizeConfig.defaultSize * 2,
              )),
        ]),
          SizedBox(height: SizeConfig.defaultSize * 4),

      ],
    );
  }
}

class _MemberCardView extends StatelessWidget {
  const _MemberCardView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 10,
    );
  }
}
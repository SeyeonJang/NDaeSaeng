import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/meet_one_member_cardview.dart';
import '../viewmodel/meet_cubit.dart';
import '../viewmodel/state/meet_state.dart';

class MeetMyTeamDetail extends StatelessWidget {
  // final MeetTeam myTeam;

  const MeetMyTeamDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        toolbarHeight: SizeConfig.defaultSize * 7,
        automaticallyImplyLeading: false,
        title: BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            return const _TopBarSection();
          },
        ),
      ),

      body: BlocBuilder<MeetCubit, MeetState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
              child: Column(
                children: [
                  MeetOneMemberCardview(userResponse: state.userResponse),
                    SizedBox(height: SizeConfig.defaultSize),
                  MeetOneMemberCardview(userResponse: state.userResponse),
                    SizedBox(height: SizeConfig.defaultSize),
                  MeetOneMemberCardview(userResponse: state.userResponse),
                ],
              ),
            )
          );
        }
      ),
    );
  }
}

class _TopBarSection extends StatelessWidget {
  const _TopBarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded, size: SizeConfig.defaultSize * 2,),
                    padding: EdgeInsets.zero,
                  ),
                  Text("팀 이름", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7,
                      fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("21.5세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded), padding: EdgeInsets.zero,)
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("가톨릭대학교", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.7,),
                ),
                Text("서울 인천", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize * 1.5,)
        ],
      ),
    );
  }
}

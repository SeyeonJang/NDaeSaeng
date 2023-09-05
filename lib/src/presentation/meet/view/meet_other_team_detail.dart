import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';
import '../../component/meet_one_member_cardview.dart';
import '../viewmodel/meet_cubit.dart';
import '../viewmodel/state/meet_state.dart';

class MeetOtherTeamDetail extends StatelessWidget {
  const MeetOtherTeamDetail({super.key});

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

      bottomNavigationBar: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 17,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.defaultSize * 5.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("우리 팀 이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),  // TODO : 팀 이름
                      Row(
                        children: [
                          Text("팀 바꾸기"),
                          Icon(Icons.expand_more_rounded, color: Colors.grey,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
                SizedBox(height: SizeConfig.defaultSize,),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.defaultSize * 5.5,
                decoration: BoxDecoration(
                    color: Color(0xffFE6059),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("2000", style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: SizeConfig.defaultSize * 1.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),),
                        Text(" 500 포인트로 대화 시작하기", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),),
                      ],
                    )),
              ),
                SizedBox(height: SizeConfig.defaultSize * 2)
            ],
          ),
        ),
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

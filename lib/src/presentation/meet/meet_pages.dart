import 'dart:ui';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_board.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetPages extends StatelessWidget {
  const MeetPages({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MeetCubit, MeetState>(
        builder: (buildContext, state) {
          return Stack(
            children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 2, top: SizeConfig.defaultSize * 2.5, bottom: SizeConfig.defaultSize * 1.5),
                  child: SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Text("과팅", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600),),
                  ),
                ),

                Expanded(
                    child: ClipRRect(
                      child: Stack(
                          children: [
                            // 과팅 팀리스트
                            MeetBoard(ancestorContext: buildContext),

                            (!state.isLoading && state.myTeams.isEmpty)
                                ? BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: const SizedBox.shrink())
                                : const SizedBox.shrink()
                            // 팀생성 이전, 목록을 블러 처리
                            // BlocBuilder<MeetCubit, MeetState>(
                            //   builder: (context, state) {
                            //     print('Meet Pages 1 ${state.hashCode}');
                            //
                            //     if (!state.isLoading && state.myTeams.isEmpty) {
                            //       return BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: const SizedBox.shrink());
                            //     }
                            //     return const SizedBox.shrink();
                            //   }
                          // ),
                          ]
                      ),
                    ),
                ),
              ],
            ),

          (state.isLoading || state.myTeams.isNotEmpty)
          ? const SizedBox.shrink() : Center(
          child: Container(
          color: Colors.black.withOpacity(0.6),
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("팀을 만들어야 이성을 볼 수 있어요! 👀", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.0, color: Colors.white, fontWeight: FontWeight.w700),),
          SizedBox(height: SizeConfig.defaultSize * 1.5,),
          Text("왼쪽 홈에서 간단하게 팀을 만들어보아요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, color: Colors.white),),
          SizedBox(height: SizeConfig.defaultSize,),
          ],
          ),
          ),
          )

            // 팀을 만들어야 이성을 볼 수 있어요 문구
            // BlocBuilder<MeetCubit, MeetState>(
            //   builder: (context, state) {
            //     print('Meet Pages 2 ${state.hashCode}');
            //
            //     if (state.isLoading || state.myTeams.isNotEmpty) {
            //         return const SizedBox.shrink();
            //       }
            //       return Center(
            //       child: Container(
            //         color: Colors.black.withOpacity(0.6),
            //         height: SizeConfig.screenHeight,
            //         width: SizeConfig.screenWidth,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Text("팀을 만들어야 이성을 볼 수 있어요! 👀", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.0, color: Colors.white, fontWeight: FontWeight.w700),),
            //             SizedBox(height: SizeConfig.defaultSize * 1.5,),
            //             Text("왼쪽 홈에서 간단하게 팀을 만들어보아요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, color: Colors.white),),
            //             SizedBox(height: SizeConfig.defaultSize,),
            //           ],
            //         ),
            //       ),
            //     );
            //   }
            // ),
          ],
          );
        }
      ),
    );
  }
}

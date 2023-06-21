import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_result_view.dart';
import 'package:dart_flutter/src/presentation/vote/vote_start_view.dart';
import 'package:dart_flutter/src/presentation/vote/vote_timer.dart';
import 'package:dart_flutter/src/presentation/vote/vote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotePages extends StatelessWidget {
  const VotePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<VoteCubit, VoteState>(
          builder: (context, state) {
            if (state.step.isStart) {
              return const VoteStartView();
            }
            if (state.step.isProcess) {
              return const VoteView();
            }
            if (state.step.isDone) {
              return const VoteResultView();
            }
            if (state.step.isWait) {
              return const VoteTimer();
            }
            return SafeArea(child: Container(alignment: Alignment.bottomCenter,child: Text(state.toString())));
          },
        ),

        // BlocBuilder<VoteCubit,VoteState> (
        //   builder: (context, state) {
        //     return SafeArea(child: Container(alignment: Alignment.bottomCenter,child: Text(state.toString(), style: TextStyle(color: Colors.red))));
        //   },
        // ),
      ],
    );
  }
}

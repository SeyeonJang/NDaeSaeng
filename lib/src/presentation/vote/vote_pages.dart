import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_result_view.dart';
import 'package:dart_flutter/src/presentation/vote/vote_start_view.dart';
import 'package:dart_flutter/src/presentation/vote/vote_timer.dart';
import 'package:dart_flutter/src/presentation/vote/vote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void _navigateToRoute(BuildContext context, Widget route) {
  WidgetsBinding.instance.scheduleFrameCallback(
        (_) {
      // When you AuthenticationState changed, and you have
      // pushed a lot widgets, this pop all.
      // You can change the name '/' for the name
      // of your route that manage the AuthenticationState.
      Navigator.popUntil(context, ModalRoute.withName('/'));

      // Also you can change MaterialPageRoute
      // for your custom implemetation
      MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) {
          // WillPopScope for prevent to go to the previous
          // route using the back button.
          return WillPopScope(
            onWillPop: () async {
              // In Android remove this activity from the stack
              // and return to the previous activity.
              SystemNavigator.pop();
              return false;
            },
            child: route,
          );
        },
      );
      Navigator.of(context).push(newRoute);
    },
  );
}


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
              return VoteResultView();
            }
            if (state.step.isWait) {
              return const VoteTimer();
            }
            return SafeArea(child: Container(alignment: Alignment.bottomCenter,child: Text(state.toString())));
          },
        ),

        BlocBuilder<VoteCubit, VoteState>(
          builder: (context, state) {
            if (state.step.isDone) {
              return Container(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                      offset: const Offset(0, -100),
                      child: const _FixedConfettiWidget()
                  )
              );
            }
            return const SizedBox();
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

class _FixedConfettiWidget extends StatefulWidget {
  const _FixedConfettiWidget({
    super.key,
  });

  @override
  State<_FixedConfettiWidget> createState() => _FixedConfettiWidgetState();
}

class _FixedConfettiWidgetState extends State<_FixedConfettiWidget> {
  final ConfettiController confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    confettiController.play();
  }

  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      shouldLoop: true,
      blastDirectionality: BlastDirectionality.explosive,
      // blastDirection: -pi / 2,
      minBlastForce: 5,
      maxBlastForce: 10,
    );
  }
}

import 'package:dart_flutter/src/presentation/meet/deprecated/meet_landing_page.dart';
import 'package:dart_flutter/src/presentation/meet/deprecated/meet_three_done.dart';
import 'package:dart_flutter/src/presentation/meet/deprecated/meet_three_people_page.dart';
import 'package:dart_flutter/src/presentation/meet/deprecated/meet_two_done.dart';
import 'package:dart_flutter/src/presentation/meet/deprecated/meet_two_people_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';

@Deprecated("옛날 미트 페이지")
class MeetPages extends StatelessWidget {
  const MeetPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            if (state.meetPageState.isMeetLanding) {
              return const MeetLandingPage();
            }
            if (state.meetPageState.isTwoPeople) {
              return const MeetTwoPeoplePage();
            }
            if (state.meetPageState.isThreePeople) {
              return const MeetThreePeoplePage();
            }
            if (state.meetPageState.isTwoPeopleDone) {
              return const MeetTwoDone();
            }
            if (state.meetPageState.isThreePeopleDone) {
              return const MeetThreeDone();
            }
            return SafeArea(child: Center(child: Text(state.toString())));
          },
        ),
      ],
    );
  }
}

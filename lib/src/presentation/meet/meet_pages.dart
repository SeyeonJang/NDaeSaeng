import 'package:dart_flutter/src/presentation/meet/view/meet_standby.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetPage2 extends StatelessWidget {
  const MeetPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            return const MeetStandby();
          }
        ),
        BlocBuilder<MeetCubit, MeetState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox.shrink();
            }
        ),
      ],
    );
  }
}

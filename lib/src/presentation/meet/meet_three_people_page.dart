import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetThreePeoplePage extends StatefulWidget {
  const MeetThreePeoplePage({super.key});

  @override
  State<MeetThreePeoplePage> createState() => _MeetThreePeoplePageState();
}

class _MeetThreePeoplePageState extends State<MeetThreePeoplePage> {
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

            ],
          )
      ),
    );
  }
}

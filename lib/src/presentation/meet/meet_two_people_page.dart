import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/size_config.dart';


class MeetTwoPeoplePage extends StatefulWidget {
  const MeetTwoPeoplePage({super.key});

  @override
  State<MeetTwoPeoplePage> createState() => _MeetTwoPeoplePageState();
}

class _MeetTwoPeoplePageState extends State<MeetTwoPeoplePage> {
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

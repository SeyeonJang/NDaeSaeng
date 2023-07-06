import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MeetLandingPage extends StatelessWidget {
  const MeetLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<MeetCubit>(context).stepTwoPeople();
                },
                child: Text("2대2 과팅", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4,
                  fontWeight: FontWeight.w500,
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<MeetCubit>(context).stepThreePeople();
                },
                child: Text("3대3 과팅", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4,
                  fontWeight: FontWeight.w500,
                )),
              ),
            ]
          ),
        ],
      ),
    );
  }
}

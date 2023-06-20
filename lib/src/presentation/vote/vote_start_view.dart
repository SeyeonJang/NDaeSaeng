import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteStartView extends StatelessWidget {
  const VoteStartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "이번 Dart는?",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: SizeConfig.defaultSize * 5,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                    child: Icon(Icons.emoji_emotions, size: SizeConfig.defaultSize * 20)
                ),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<VoteCubit>(context).stepStart();
                  },
                  child: Text(
                    "시작하기",
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 4,
                    ),
                  ),
                ),
              ),
              const Flexible(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

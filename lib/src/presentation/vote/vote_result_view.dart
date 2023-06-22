import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteResultView extends StatelessWidget {
  const VoteResultView({Key? key}) : super(key: key);

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
                    "축하해요!",
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
                    child: Icon(Icons.emoji_emotions, size: SizeConfig.defaultSize * 22)
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Dart를 통해 얻은 Point, 30!",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 2.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 0.1,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<VoteCubit>(context).stepDone();
                      },
                      child: Text(
                        "포인트 받기",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 3.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

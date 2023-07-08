import 'package:confetti/confetti.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteResultView extends StatefulWidget {
  VoteResultView({Key? key}) : super(key: key);

  @override
  State<VoteResultView> createState() => _VoteResultViewState();
}

class _VoteResultViewState extends State<VoteResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: const SizedBox(),
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
                        "다음 투표도 기대해보세요!",
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
                        "다음으로",
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


import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_board.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_intro.dart';
import 'package:flutter/material.dart';

class MeetIntroPages extends StatelessWidget {
  const MeetIntroPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
          child: Container(
            width: SizeConfig.screenWidth * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: SizeConfig.defaultSize,),
                      Text("홈", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize * 1,),
              ],
            ),
          ),
        ),

        const Expanded(child: MeetIntro()),

      ],
    );
  }
}

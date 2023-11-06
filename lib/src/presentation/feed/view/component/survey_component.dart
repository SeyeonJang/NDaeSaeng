import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:intl/intl.dart';

class SurveyComponent extends StatelessWidget {
  late Survey survey;
  Color mainColor = const Color(0xffFE6059);
  double marginHorizontal = SizeConfig.defaultSize * 2.3;

  SurveyComponent({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedSurveyDate = DateFormat('MM월 dd일').format(survey.createdAt);
    String formattedNowDate = DateFormat('MM월 dd일').format(now);

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 30,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1.6
          )
      ),
      child: Column(
        children: [
            SizedBox(height: SizeConfig.defaultSize * 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize,
                        vertical: SizeConfig.defaultSize * 0.4),
                    child: Text(formattedSurveyDate, style: TextStyle(
                        color: mainColor,
                        fontSize: SizeConfig.defaultSize * 1.4)),
                  )
                ),
                if (formattedNowDate == formattedSurveyDate) Text("오늘의 질문", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Colors.grey),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.5, horizontal: marginHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(' ${survey.question}', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

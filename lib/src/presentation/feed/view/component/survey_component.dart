import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/option_component.dart';
import 'package:dart_flutter/src/presentation/feed/view/survey_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:intl/intl.dart';

class SurveyComponent extends StatelessWidget {
  late Survey survey;
  Color mainColor = const Color(0xffFE6059);
  Color commentColor = const Color(0xffFFFAF9);
  double marginHorizontal = SizeConfig.defaultSize * 2.3;

  SurveyComponent({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedSurveyDate = DateFormat('MM월 dd일').format(survey.createdAt);
    String formattedNowDate = DateFormat('MM월 dd일').format(now);
    double optionFirstPercent = survey.options.first.headCount / (survey.options.first.headCount + survey.options.last.headCount);
    double optionSecondPercent = survey.options.last.headCount / (survey.options.first.headCount + survey.options.last.headCount);

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
            child: Column(
              children: [
                  SizedBox(height: SizeConfig.defaultSize * 2,),
                Column(
                  children: [
                    Row(
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
                      SizedBox(height: SizeConfig.defaultSize * 1.5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(' ${survey.question}', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                      ],
                    ),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                    OptionComponent(option: survey.options.first, percent: optionFirstPercent, isMost: optionFirstPercent>optionSecondPercent,),
                      SizedBox(height: SizeConfig.defaultSize),
                    OptionComponent(option: survey.options.last, percent: optionSecondPercent, isMost: optionFirstPercent<optionSecondPercent,)
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SurveyDetailView()));
            },
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.defaultSize * 6.5,
              color: commentColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('실시간 댓글', style: TextStyle(color: mainColor, fontSize: SizeConfig.defaultSize * 1.3),),
                        Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.defaultSize * 1.3, color: mainColor,)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5),
                      child: Text(survey.latestComment, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3), overflow: TextOverflow.ellipsis,),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

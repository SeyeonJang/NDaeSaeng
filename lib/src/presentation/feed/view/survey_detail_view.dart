import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/comment_component.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/option_component.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/survey_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SurveyDetailView extends StatelessWidget {
  late SurveyDetail surveyDetail;
  late Comment comment;


  SurveyDetailView({super.key, required this.surveyDetail});

  double marginHorizontal = SizeConfig.defaultSize * 2.5;
  Color mainColor = const Color(0xffFE6059);
  Color backgroundColor = const Color(0xffFFFAF9);


  @override
  Widget build(BuildContext context) {DateTime now = DateTime.now();
    String formattedSurveyDate = DateFormat('MM월 dd일').format(surveyDetail.createdAt);
    String formattedNowDate = DateFormat('MM월 dd일').format(now);
    double optionFirstPercent = surveyDetail.options.first.headCount / (surveyDetail.options.first.headCount + surveyDetail.options.last.headCount);
    double optionSecondPercent = surveyDetail.options.last.headCount / (surveyDetail.options.first.headCount + surveyDetail.options.last.headCount);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("실시간 댓글", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600),),
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(
          color: mainColor
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container( // 오늘의질문
              color: backgroundColor,
              width: SizeConfig.screenWidth,
              height: SizeConfig.defaultSize * 24,
              child: Padding(
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
                            Text(' ${surveyDetail.question}', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                          ],
                        ),
                          SizedBox(height: SizeConfig.defaultSize * 2,),
                        OptionComponent(option: surveyDetail.options.first, percent: optionFirstPercent, isMost: optionFirstPercent>optionSecondPercent,),
                          SizedBox(height: SizeConfig.defaultSize),
                        OptionComponent(option: surveyDetail.options.last, percent: optionSecondPercent, isMost: optionFirstPercent<optionSecondPercent,)
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.defaultSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("댓글 ${surveyDetail.comments.length}개"),
                      ],
                    ),
                  ),
                  for (int i=0; i<surveyDetail.comments.length; i++)
                    CommentComponent(comment: surveyDetail.comments[i])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

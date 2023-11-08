import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/comment_component.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/option_component.dart';
import 'package:dart_flutter/src/presentation/feed/viewmodel/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SurveyDetailView extends StatefulWidget {
  late SurveyDetail surveyDetail;
  late FeedCubit feedCubit;
  late int pickedOption;

  SurveyDetailView({super.key, required this.surveyDetail, required this.feedCubit}) {
   pickedOption = surveyDetail.pickedOption;
  }

  @override
  State<SurveyDetailView> createState() => _SurveyDetailViewState();
}

class _SurveyDetailViewState extends State<SurveyDetailView> {
  bool isLoading = false;
  late Comment comment;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double marginHorizontal = SizeConfig.defaultSize * 2.5;
  Color mainColor = const Color(0xffFE6059);
  Color backgroundColor = const Color(0xffFFFAF9);
  String myComment = '';
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    _refreshComments();
    setState(() {
    });
  }

  void _refreshComments() {
    isLoading = true;
    setState(() {
      comments = widget.feedCubit.state.surveyDetail.comments;
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsUtil.logEvent('피드_오늘의질문_상세보기_접속', properties: {
      '질문 id': widget.feedCubit.state.surveyDetail.id,
      '질문 내용': widget.feedCubit.state.surveyDetail.question
    });

    DateTime now = DateTime.now();
    String formattedSurveyDate = DateFormat('MM월 dd일').format(widget.surveyDetail.createdAt);
    String formattedNowDate = DateFormat('MM월 dd일').format(now);
    double optionFirstPercent = widget.surveyDetail.options.first.headCount / (widget.surveyDetail.options.first.headCount + widget.surveyDetail.options.last.headCount);
    double optionSecondPercent = widget.surveyDetail.options.last.headCount / (widget.surveyDetail.options.first.headCount + widget.surveyDetail.options.last.headCount);

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        body: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("실시간 댓글", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600),),
            surfaceTintColor: Colors.white,
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
                                Text(' ${widget.surveyDetail.question}', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                              ],
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 2,),
                            OptionComponent(isPicked: widget.pickedOption == widget.surveyDetail.options.first.id, option: widget.surveyDetail.options.first, percent: optionFirstPercent, isMost: optionFirstPercent>optionSecondPercent, isChanged: false),
                              SizedBox(height: SizeConfig.defaultSize),
                            OptionComponent(isPicked: widget.pickedOption == widget.surveyDetail.options.last.id, option: widget.surveyDetail.options.last, percent: optionSecondPercent, isMost: optionFirstPercent<optionSecondPercent, isChanged: false)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize, horizontal: marginHorizontal),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("댓글 ${comments.length}개"),
                        ],
                      ),
                    ),
                    for (int i=0; i<comments.length; i++)
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize, horizontal: marginHorizontal),
                            child: CommentComponent(surveyId: widget.surveyDetail.id, comment: comments[i], feedCubit: widget.feedCubit,),
                          ),
                          Divider(thickness: 1, height: 1, color: Colors.grey.shade100)
                        ],
                      )
                  ],
                )
              ],
            ),
          ),

          bottomNavigationBar: Container(
            color: Colors.white,
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 8.5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.5, horizontal: SizeConfig.defaultSize),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize),
                        child: TextField(
                          enabled: !isLoading,
                          focusNode: _focusNode,
                          controller: _controller,
                          cursorColor: mainColor,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '댓글로 내 생각을 표현해보세요!',
                          ),
                          maxLines: null,
                          onChanged: (String value) {
                            setState(() {
                              myComment = value;
                            });
                          },
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (isLoading) return;
                          if (myComment.isEmpty) {
                            ToastUtil.showMeetToast('댓글 작성하고 눌러주세요!', 1);
                            return;
                          }
                          FocusScope.of(context).unfocus();  // 댓글 작성 후 키보드 사라지게하기

                          isLoading = true;
                          _controller.clear();
                          await widget.feedCubit.postComment(widget.surveyDetail.id, myComment);
                          AnalyticsUtil.logEvent('피드_오늘의질문_댓글_추가', properties: {
                            '질문 id': widget.surveyDetail.id,
                            '질문 내용': widget.surveyDetail.question
                          });
                          _refreshComments();
                          isLoading = false;
                        },
                        icon: Icon(Icons.send_rounded, color: mainColor,)
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/survey_component.dart';
import 'package:dart_flutter/src/presentation/feed/viewmodel/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late FeedCubit feedCubit;
  late PagingController<int, Survey> pagingController;
  final Map<int, int> doneSurveyAnswers = {};
  final Map<int, int> firstSurveyHeadCount = {};
  final Map<int, int> secondSurveyHeadCount = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    feedCubit = context.read<FeedCubit>();
  }

  @override
  void initState() {
    super.initState();
    feedCubit = context.read<FeedCubit>();
    pagingController = feedCubit.pagingController;

    if (mounted) {
      pagingController.addPageRequestListener(onPageRequested);
      SchedulerBinding.instance.addPostFrameCallback((_) => feedCubit.initFeed());
    }
  }

  @override
  void dispose() {
    pagingController.removePageRequestListener(onPageRequested);
    super.dispose();
  }

  void onPageRequested(int pageKey) {
    if (mounted) {
      feedCubit.fetchPage(pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsUtil.logEvent('피드_접속');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("N대생", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        pagingController.refresh();
                      },
                      child: SizedBox(
                        height: SizeConfig.screenHeight * 0.82,
                        child: PagedListView<int, Survey>(
                            pagingController: pagingController,
                            builderDelegate: PagedChildBuilderDelegate<Survey>(itemBuilder: (_, survey, __) {
                              final int? cachedSurveyAnswer = doneSurveyAnswers[survey.id];
                              final int cachedFirstHeadCount = firstSurveyHeadCount[survey.id] ?? 1;
                              final int cachedSecondHeadCount = secondSurveyHeadCount[survey.id] ?? 1;
                              if (cachedSurveyAnswer != null) {
                                survey = survey.copyWith(
                                    picked: true,
                                    pickedOption: cachedSurveyAnswer,
                                    options: [Option(id: survey.options.first.id, name: survey.options.first.name, headCount: cachedFirstHeadCount), Option(id: survey.options.last.id, name: survey.options.last.name, headCount: cachedSecondHeadCount)]);
                              }

                              return Column(
                                children: [
                                  SurveyComponent(
                                      survey: survey,
                                      feedCubit: feedCubit,
                                      onSurveySelected: (answer) => doneSurveyAnswers[survey.id] = answer,
                                      firstPercentChange: (count) => firstSurveyHeadCount[survey.id] = count,
                                      secondPercentChange: (count) => secondSurveyHeadCount[survey.id] = count
                                  ),
                                  SizedBox(
                                    height: SizeConfig.defaultSize,
                                  ),
                                ],
                              );
                            })),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/feed/view/component/survey_component.dart';
import 'package:dart_flutter/src/presentation/feed/viewmodel/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Feed extends StatelessWidget {
  Feed({super.key});

  // late PagingController<int, Post> pagingController;

  @override
  Widget build(BuildContext context) {
    final feedCubit = context.watch<FeedCubit>();

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
                  Text("N대생", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.8,
                    fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            // TODO : pagination
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.defaultSize * 2, left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 2),
              child: SurveyComponent(survey: feedCubit.state.surveyDetail)
            ),
          ],
        ),
      ),
    );
  }
}

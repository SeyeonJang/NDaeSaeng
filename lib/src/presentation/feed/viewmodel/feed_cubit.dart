import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/feed_use_case.dart';
import 'package:dart_flutter/src/presentation/feed/viewmodel/state/feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedState.init());
  static final FeedUseCase _feedUseCase = FeedUseCase();
  static final UserUseCase _userUseCase = UserUseCase();

  // pagination
  static const int _numberOfPostsPerRequest = 10;
  // final PagingController<int, Post> pagingController = PagingController(firstPageKey: 0);

  void initFeed() async {
    state.setIsLoading(true);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    Survey survey = await _feedUseCase.getSurvey();
    state.setSurvey(survey);

    state.setIsLoading(false);
    emit(state.copy());
  }

  // // TODO : Future<void> & getPosts에 await
  // void fetchPage(int pageKey) async {
  //   try {
  //     final posts = (_feedUseCase.getPosts(page: pageKey, size: _numberOfPostsPerRequest).content ?? []);
  //     final isLastPage = posts.length < _numberOfPostsPerRequest;
  //     if (isLastPage) {
  //       pagingController.appendLastPage(posts);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       AnalyticsUtil.logEvent('피드_게시글 불러오기(페이지네이션)', properties: {
  //         '새로 불러온 페이지 인덱스': nextPageKey
  //       });
  //       pagingController.appendPage(posts, nextPageKey);
  //     }
  //   } catch (error) {
  //     print('[PAGINATION ERROR] $error');
  //     pagingController.error = error;
  //   }
  // }

  // TODO : Future<void> & async, await
  // void postOnePost(String title, String content) {
  //   Post newPost = Post(
  //       id: 0,
  //       title: title,
  //       content: content,
  //       writer: state.userResponse,
  //       comments: [],
  //       createdAt: DateTime.now(),
  //       likes: 0,
  //       liked: false
  //   );
  //   _feedUseCase.postOnePost(newPost);
  // }
}
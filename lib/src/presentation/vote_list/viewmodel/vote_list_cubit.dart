import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/vote_use_case.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class VoteListCubit extends HydratedCubit<VoteListState> {
  static final VoteUseCase _voteUseCase = VoteUseCase();
  static final UserUseCase _userUseCase = UserUseCase();
  final PagingController<int, VoteResponse> pagingController = PagingController(firstPageKey: 0);
  late int _numberOfPostsPerRequest;

  VoteListCubit() : super(VoteListState.init());

  void initVotes() async {
    state.setIsLoading(true);
    emit(state.copy());

    state.isDetailPage = false;
    Pagination<VoteResponse> paginationResponse = await _voteUseCase.getVotes(page: 0);
    _numberOfPostsPerRequest = paginationResponse.numberOfElements ?? 10;
    List<VoteResponse> votes = paginationResponse.content ?? [];
    state.setVotes(votes);
    User userResponse = await _userUseCase.myInfo();
    state.setUserMe(userResponse);

    state.setIsLoading(false);
    emit(state.copy());
  }

  void firstTime() {
    state.firstTime();
    emit(state.copy());
  }

  /// 투표 리스트에서 투표를 클릭하여 상세페이지를 확인
  void pressedVoteInList(int voteId) {
    state.setIsDetailPage(true).setVoteId(voteId).visitByVoteId(voteId);
    emit(state.copy());
  }

  /// 상세페이지에서 목록페이지로 돌아감
  void backToVoteList() {
    state.setIsDetailPage(false);
    emit(state.copy());
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newVotes = (await _voteUseCase.getVotes(page: pageKey)).content ?? [];
      final isLastPage = newVotes.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        pagingController.appendLastPage(newVotes);
      } else {
        final nextPageKey = pageKey + 1;
        AnalyticsUtil.logEvent('받은투표_불러오기(페이지네이션)', properties: {
          '새로 불러온 페이지 인덱스': nextPageKey
        });
        // await Future.delayed(Duration(seconds: 1));
        pagingController.appendPage(newVotes, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<VoteDetail> getVote(int voteId) async {
    return await _voteUseCase.getVote(voteId);
  }

  Future<void> getUserMe() async {
    User userResponse = await _userUseCase.myInfo();
    state.setUserMe(userResponse);
  }

  bool isVisited(int id) {
    return state.isVisited(id);
  }

  @override
  VoteListState fromJson(Map<String, dynamic> json) {
    return state.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(VoteListState state) {
    return state.toJson();
  }

  @override
  String toString() {
    return 'VoteListCubit{}';
  }
}

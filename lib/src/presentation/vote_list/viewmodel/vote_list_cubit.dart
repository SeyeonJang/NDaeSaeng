import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/use_case/vote_use_case.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class VoteListCubit extends HydratedCubit<VoteListState> {
  static final VoteUseCase _voteUseCase = VoteUseCase();

  VoteListCubit() : super(VoteListState.init());

  void initVotes() async {
    state.setIsLoading(true);
    emit(state.copy());

    List<VoteResponse> votes = await _voteUseCase.getVotes();
    state.setVotes(votes);

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
}

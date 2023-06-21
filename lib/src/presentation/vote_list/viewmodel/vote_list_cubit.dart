
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/repository/dart_vote_repository.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_mock.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class VoteListCubit extends HydratedCubit<VoteListState> {
  static final DartVoteRepository _dartVoteRepository = DartVoteRepository();

  VoteListCubit() : super(VoteListState.init());

  void initVotes() async {
     // List<VoteResponse> votes = await _dartVoteRepository.getVotes("TODO MY ACCESSTOKEN");
    List<VoteResponse> votes = VoteMock().getVotes();
    state.setVotes(votes);

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

  void requestHintById(int id, String typeOfHint) {
    // Point 확인

    // _dartVoteRepository.getHint("TODO MY ACCESSTOKEN", id, "typeOfHint");
    // API 나와야 감 좀 잡히것는데
    emit(state.copy());
  }

  @override
  VoteListState fromJson(Map<String, dynamic> json) => state.fromJson(json);

  @override
  Map<String, dynamic> toJson(VoteListState state) => state.toJson();
}

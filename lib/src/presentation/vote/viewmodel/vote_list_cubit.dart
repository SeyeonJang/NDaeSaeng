
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/repository/dart_vote_repository.dart';
import 'package:dart_flutter/src/presentation/vote/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote/viewmodel/state/vote_mock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteListCubit extends Cubit<VoteListState> {
  static final DartVoteRepository _dartVoteRepository = DartVoteRepository();

  VoteListCubit() : super(VoteListState.init());

  void initState() async {
     // List<VoteResponse> votes = await _dartVoteRepository.getVotes("TODO MY ACCESSTOKEN");
    List<VoteResponse> votes = VoteMock().getVotes();
    state.setVotes(votes);

     emit(state.copy());
  }

  VoteResponse getVoteById(int id) {
    VoteResponse vote = state.getVoteById(id);

    state.visitByVoteId(id);
    emit(state.copy());

    return vote;
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
}

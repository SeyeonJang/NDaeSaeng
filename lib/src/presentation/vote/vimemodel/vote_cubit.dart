import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_vote_repository.dart';
import 'package:dart_flutter/src/presentation/mypage/friends_mock.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_mock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteCubit extends Cubit<VoteState> {
  static final DartUserRepository _dartUserRepository = DartUserRepository();
  static final DartVoteRepository _dartVoteRepository = DartVoteRepository();

  VoteCubit() : super(VoteState.init());

  void initVotes() async {
    // 다음 투표 가능 시간을 기록
    // DateTime nextVoteTime = await _dartUserRepository.getMyNextVoteTime("TODO MY ACCESSTOKEN");
    DateTime nextVoteTime = DateTime.now();
    state.setNextVoteDateTime(nextVoteTime);

    // step 설정
    _setStepByNextVoteTime();

    emit(state.copy());
  }

  void refresh() {
    emit(state.copy());
  }

  void stepStart() async {
    // 투표 가능한지 확인
    _setStepByNextVoteTime();
   
    if (state.step.isStart) {
      // 친구 목록 설정
      // List<University> friends = await _dartUserRepository.getMyFriends("TODO MY ACCESSTOKEN");
      List<Friend> friends = FriendsMock().getFriends();
      state.setFriends(friends);

      // 새로 투표할 목록들을 가져오기
      // List<VoteResponse> myVotes = await _dartVoteRepository.getNewVotes("TODO MY ACCESSTOKEN");
      List<VoteResponse> myVotes = VoteMock().getVotes();
      for (var myVote in myVotes) {
        state.addVote(VoteRequest.fromVoteResponse(myVote));
      }

      // 투표 화면으로 전환
      state.setStep(VoteStep.process);
    }
    
    emit(state.copy());
  }

  void nextVote(int numberOfVote, int pickUserId) async {
    state.pickUserInVote(numberOfVote, pickUserId);
    state.nextVote();
    if (state.isVoteDone()) {
      // 투표한 내용을 서버에 전달
      // _dartVoteRepository.sendMyVotes("TODO MY ACCESSTOKEN", state.votes);

      // 투표 리스트 비우기 + 다음투표가능시간 갱신 + (포인트는 My page에서 값 받아오면 알아서 갱신되어있음)
      // DateTime myNextVoteTime = await _dartVoteRepository.getMyNextVoteTime("TODO MY ACCESS TOKEN");
      DateTime myNextVoteTime = DateTime.now().add(const Duration(minutes: 40));
      state.setNextVoteDateTime(myNextVoteTime);
    }

    // 상태 갱신
    emit(state.copy());
  }

  void stepDone() {
    state.setStep(VoteStep.wait);
    emit(state.copy());
  }

  void stepWait() {
    _setStepByNextVoteTime();
    emit(state.copy());
  }

  void inviteFriend() {
    bool isInvited = true;
    if (isInvited) {
      // 정상적으로 카톡 공유하기를 전송한 경우
      // _dartVoteRepository.updateMyNextVoteTime("TODO MY ACCESS TOKEN");
      state.setNextVoteDateTime(DateTime.now()).setStep(VoteStep.start);
    }

    emit(state.copy());
  }

  void _setStepByNextVoteTime() {
    if (state.isVoteTimeOver()) {
      state.setStep(VoteStep.start);
    } else {
      state.setStep(VoteStep.wait);
    }
  }
}

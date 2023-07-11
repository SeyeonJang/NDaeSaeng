import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/question.dart';
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/repository/dart_friend_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_vote_repository.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class VoteCubit extends HydratedCubit<VoteState> {
  static final DartUserRepository _dartUserRepository = DartUserRepository();
  static final DartFriendRepository _dartFriendRepository = DartFriendRepository();
  static final DartVoteRepository _dartVoteRepository = DartVoteRepository();

  // VoteCubit() : super(VoteState.init());
  VoteCubit() : super(VoteState(
      step: VoteStep.start,
      voteIterator: 0,
      votes: [],
      questions: [],
      nextVoteDateTime: DateTime.now(),
      friends: [],
  ));

  // void initVotes() async {
  //   // 다음 투표 가능 시간을 기록
  //   // DateTime nextVoteTime = await _dartUserRepository.getMyNextVoteTime("TODO MY ACCESSTOKEN");
  //   DateTime nextVoteTime = DateTime.now();
  //   state.setNextVoteDateTime(nextVoteTime);
  //
  //   // ㅇㄹㄴㅁㅇdfsadftep 설정
  //   _setStepByNextVoteTime();
  //
  //   emit(state.copy());
  // }

  void refresh() {
    emit(state.copy());
  }

  void stepStart() async {
    // 투표 가능한지 확인
    _setStepByNextVoteTime();

    if (state.step.isStart) {
      // 친구 목록 설정
      List<Friend> friends = await _dartFriendRepository.getMyFriends();
      state.setFriends(friends);

      // 새로 투표할 목록들을 가져오기
      List<Question> questions = await _dartVoteRepository.getNewQuestions();
      state.setQuestions(questions);

      // 투표 화면으로 전환
      state.setStep(VoteStep.process);
    }

    emit(state.copy());
  }

  void nextVote(VoteRequest voteRequest) async {
    state.pickUserInVote(voteRequest);
    state.nextVote();
    if (state.isVoteDone()) {
      // 투표한 내용을 서버에 전달
      // _dartVoteRepository.sendMyVotes(state.votes);  //TODO 서버에서 한번에 받도록 수정
      for (var vote in state.votes) {
        _dartVoteRepository.sendMyVote(vote);
      }

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

  @override
  VoteState fromJson(Map<String, dynamic> json) {
    return state.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(VoteState state) {
    return state.toJson();
  }
}

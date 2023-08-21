import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/vote_use_case.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class VoteCubit extends HydratedCubit<VoteState> {
  static final FriendUseCase _friendUseCase = FriendUseCase();
  static final VoteUseCase _voteUseCase = VoteUseCase();

  // VoteCubit() : super(VoteState.init());
  VoteCubit() : super(VoteState(
      isLoading: false,
      step: VoteStep.start,
      voteIterator: 0,
      votes: [],
      questions: [],
      nextVoteDateTime: DateTime.now(),
      friends: [],
  ));

  void initVotes() async {
    state.setIsLoading(true);
    emit(state.copy());

    // 친구 목록 설정
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setFriends(friends);

    // 투표중이지 않았던 경우, 다음 투표 가능 시간을 기록
    if (!state.step.isProcess) {
      // 다음 스텝 지정
      await getNextVoteTime();
      _setStepByNextVoteTime();
    }

    state.setIsLoading(false);
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
      List<User> friends = await _friendUseCase.getMyFriends();
      state.setFriends(friends);

      // 새로 투표할 목록들을 가져오기
      List<Question> questions = await _voteUseCase.getNewQuestions();
      state.setQuestions(questions);

      // 투표 화면으로 전환
      state.setStep(VoteStep.process);
    }

    emit(state.copy());
  }

  void nextVote(VoteRequest voteRequest) async {
    print(voteRequest.toString());

    state.setIsLoading(true);
    emit(state.copy());
    print(state.toString());

    // await Future.delayed(Duration(seconds: 3));

    state.pickUserInVote(voteRequest);
    _voteUseCase.sendMyVote(voteRequest);  // 투표한 내용을 서버로 전달
    state.nextVote();
    if (state.isVoteDone()) {
      // 투표 리스트 비우기 + 다음투표가능시간 갱신 + (포인트는 My page에서 값 받아오면 알아서 갱신되어있음)
      DateTime myNextVoteTime = await _voteUseCase.setNextVoteTime();
      state.setNextVoteDateTime(myNextVoteTime);
    }

    state.setIsLoading(false);
    emit(state.copy());
    print(state.toString());
  }

  void stepDone() {
    state.setStep(VoteStep.wait);
    emit(state.copy());
  }

  void stepWait() {
    getNextVoteTime();
    _setStepByNextVoteTime();

    print(state.toString());
    emit(state.copy());
  }

  Future<DateTime> getNextVoteTime() async {
    DateTime myNextVoteTime = await _voteUseCase.getNextVoteTime();
    state.setNextVoteDateTime(myNextVoteTime);
    return myNextVoteTime;
  }

  void inviteFriend() {
    bool isInvited = true;
    if (isInvited) {
      // 정상적으로 카톡 공유하기를 전송한 경우
      state.setNextVoteDateTime(DateTime.now()).setStep(VoteStep.start);
    }

    emit(state.copy());
  }

  void _setStepByNextVoteTime() {
    if (isVoteTimeOver()) {
      state.setStep(VoteStep.start);
    } else {
      state.setStep(VoteStep.wait);
    }
  }

  bool isVoteTimeOver() {
    return state.isVoteTimeOver();
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

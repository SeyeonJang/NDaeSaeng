import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/model/question_dto.dart';
import 'package:dart_flutter/src/data/model/vote_request_dto.dart';
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
    List<FriendDto> friends = await _dartFriendRepository.getMyFriends();
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
      List<FriendDto> friends = await _dartFriendRepository.getMyFriends();
      state.setFriends(friends);

      // 새로 투표할 목록들을 가져오기
      List<QuestionDto> questions = await _dartVoteRepository.getNewQuestions();
      state.setQuestions(questions);

      // 투표 화면으로 전환
      state.setStep(VoteStep.process);
    }

    emit(state.copy());
  }

  void nextVote(VoteRequestDto voteRequest) async {
    state.setIsLoading(true);
    emit(state.copy());
    print(state.toString());

    // await Future.delayed(Duration(seconds: 3));

    state.pickUserInVote(voteRequest);
    _dartVoteRepository.sendMyVote(voteRequest);  // 투표한 내용을 서버로 전달
    state.nextVote();
    if (state.isVoteDone()) {
      // 투표 리스트 비우기 + 다음투표가능시간 갱신 + (포인트는 My page에서 값 받아오면 알아서 갱신되어있음)
      DateTime myNextVoteTime = await _dartVoteRepository.postNextVoteTime();
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
    DateTime myNextVoteTime = await _dartVoteRepository.getNextVoteTime();
    state.setNextVoteDateTime(myNextVoteTime);
    return myNextVoteTime;
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

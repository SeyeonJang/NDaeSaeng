import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';

class MeetCubit extends Cubit<MeetState> {
  MeetCubit() : super(MeetState.init());
  static final UserUseCase _userUseCase = UserUseCase();
  static final FriendUseCase _friendUseCase = FriendUseCase();
  bool _initialized = false;

  void initState() async {
    print(_initialized);
    if (_initialized) return;
    _initialized = true;

    print(state);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    emit(state.copy());
    print("meet init 끝");
    // state.meetPageState = MeetStateEnum.landing;
  }

  // Meet - CreateTeam

  // 친구를 팀 멤버로 추가했을 때
  void pressedMemberAddButton(User friend) { // TODO : User friend 파라미터로 친구 정보 받아와서 teamMembers 친구 목록에 넣기
    state.isMemberOneAdded
        ? state.setIsMemberTwoAdded(true)
        : state.setIsMemberOneAdded(true);
    state.addTeamMember(friend);
    emit(state.copy());
  }

  // **************************************************************

  void stepMeetLanding() {
    state.meetPageState = MeetStateEnum.landing;
    emit(state.copy());
    print(state.toString());
  }

  void stepTwoPeople() {
    state.meetPageState = MeetStateEnum.twoPeople;
    emit(state.copy());
    print(state.toString());
  }

  void stepThreePeople() {
    state.meetPageState = MeetStateEnum.threePeople;
    emit(state.copy());
    print(state.toString());
  }

  void stepTwoPeopleDone() {
    state.meetPageState = MeetStateEnum.twoPeopleDone;
    emit(state.copy());
    print(state.toString());
  }

  void stepThreePeopleDone() {
    state.meetPageState = MeetStateEnum.threePeopleDone;
    emit(state.copy());
    print(state.toString());
  }
}
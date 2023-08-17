import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/use_case/meet_use_case.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';

class MeetCubit extends Cubit<MeetState> {
  MeetCubit() : super(MeetState.init());
  static final UserUseCase _userUseCase = UserUseCase();
  static final FriendUseCase _friendUseCase = FriendUseCase();
  static final MeetUseCase _meetUseCase = MeetUseCase();
  bool _initialized = false;

  void initState() async {
    print(_initialized);
    if (_initialized) return;
    _initialized = true;

    state.setIsLoading(true);
    emit(state.copy());
    print(state);

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    getMyTeams();

    state.setIsLoading(false);
    emit(state.copy());
    print("meet init 끝");
    // state.meetPageState = MeetStateEnum.landing;
  }

  // Meet - CreateTeam

  void pressedMemberAddButton(User friend) { // TODO : User friend 파라미터로 친구 정보 받아와서 teamMembers 친구 목록에 넣기
    state.isMemberOneAdded
        ? state.setIsMemberTwoAdded(true)
        : state.setIsMemberOneAdded(true);
    state.addTeamMember(friend);
    emit(state.copy());
  }

  void pressedCitiesAddButton(List<Location> cities) {
    state.setCities(cities.toList());
    emit(state.copy());
  }

  void createNewTeam(MeetTeam meetTeam) {
    _meetUseCase.createNewTeam(meetTeam);
    print("cubit - 팀 추가 완료");
  }

  Future<MeetTeam> getTeam(String teamId) async {
    return await _meetUseCase.getTeam(teamId);
  }

  Future<void> getMyTeams() async {
    List<MeetTeam> myTeams = await _meetUseCase.getMyTeams();
    state.setMyTeams(myTeams);
    print("팀 목록 ${state.myTeams}");
  }

  void removeTeam(String teamId) {
    _meetUseCase.removeTeam(teamId);
    print("cubit - 팀 삭제 완료");
  }

  void updateMyTeam(MeetTeam meetTeam) {
    _meetUseCase.updateMyTeam(meetTeam);
  }

  void refreshMeetPage() async {
    await getMyTeams();
    print("refreshing");
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
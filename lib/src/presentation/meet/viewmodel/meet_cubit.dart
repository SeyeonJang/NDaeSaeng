import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/use_case/meet_use_case.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../common/pagination/pagination.dart';
import '../../../common/util/analytics_util.dart';

class MeetCubit extends Cubit<MeetState> {
  MeetCubit() : super(MeetState.init());
  static final UserUseCase _userUseCase = UserUseCase();
  static final FriendUseCase _friendUseCase = FriendUseCase();
  static final MeetUseCase _meetUseCase = MeetUseCase();
  bool _initialized = false;

  // pagination
  late int _numberOfPostsPerRequest;
  final PagingController<int, BlindDateTeam> pagingController = PagingController(firstPageKey: 0);

  void initMeet() async {
    state.setIsLoading(true);
    emit(state.copy());

    state.setIsLoading(false);
    emit(state.copy());
    state.setIsLoading(true);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    List<Location> locations = await _meetUseCase.getLocations();
    state.setServerLocations(locations);

    Pagination<BlindDateTeam> paginationBlindTeams = await _meetUseCase.getBlindDateTeams(page:0, targetLocationId: 0);
    _numberOfPostsPerRequest = paginationBlindTeams.numberOfElements ?? 10;
    List<BlindDateTeam> blindDateTeams = paginationBlindTeams.content ?? [];
    state.setBlindDateTeams(blindDateTeams);

    print("=========================");
    print(state.blindDateTeams.toString());

    await getMyTeams(put: false);

    state.setIsLoading(false);
    emit(state.copy());
  }

  void initCreateTeam() async {
    state.setIsLoading(true);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    List<Location> locations = await _meetUseCase.getLocations();
    state.setServerLocations(locations);

    state.setIsLoading(false);
    emit(state.copy());
  }

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
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    await getMyTeams(put: false);
    await fetchTeamCount(put: false);
    print("팀수: ${state.teamCount}");

    state.setIsMemberOneAdded(false);
    state.setIsMemberTwoAdded(false);
    print("${state.isMemberOneAdded} 랑 ${state.isMemberTwoAdded}");

    List<Location> locations = await _meetUseCase.getLocations();
    print(locations.toString());
    state.setServerLocations(locations);

    state.setIsLoading(false);
    emit(state.copy());
    print("meet init 끝");
    // state.meetPageState = MeetStateEnum.landing;
  }

  void initFrom(MeetState meetState) {
    state.setAll(meetState);
    emit(state.copy());
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newVotes = (await _meetUseCase.getBlindDateTeams(page: pageKey)).content ?? [];
      final isLastPage = newVotes.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        pagingController.appendLastPage(newVotes);
      } else {
        final nextPageKey = pageKey + 1;
        AnalyticsUtil.logEvent('과팅_목록_이성 팀 불러오기(페이지네이션)', properties: {
          '새로 불러온 페이지 인덱스': nextPageKey
        });
        // await Future.delayed(Duration(seconds: 1));
        pagingController.appendPage(newVotes, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  // =================================================================

  void pressedMemberAddButton(User friend) { // TODO : User friend 파라미터로 친구 정보 받아와서 teamMembers 친구 목록에 넣기
    state.setIsLoading(true);
    emit(state.copy());

    state.isMemberOneAdded
        ? state.setIsMemberTwoAdded(true)
        : state.setIsMemberOneAdded(true);

    state.addTeamMember(friend);

    state.setIsLoading(false);
    emit(state.copy());
  }

  void pressedMemberDeleteButton(User friend) {
    state.setIsLoading(true);
    emit(state.copy());

    if (state.isMemberOneAdded) {
      state.setIsMemberOneAdded(false);
      state.setIsMemberTwoAdded(false);
    }
    else if (state.isMemberTwoAdded) {
      state.setIsMemberOneAdded(true);
      state.setIsMemberTwoAdded(false);
    }
    state.deleteTeamMember(friend);
    print("cubit - friend 삭제 {$friend}");
    state.setIsLoading(false);
    emit(state.copy());
  }

  void pressedCitiesAddButton(List<Location> cities) {
    state.setCities(cities.toList());
    emit(state.copy());
  }

  Future<void> createNewTeam(MeetTeam meetTeam) async {
    var myTeam = await _meetUseCase.createNewTeam(meetTeam);
    state.addMyTeam(myTeam);
    emit(state.copy());
    print("============================== 팀 추가 완료");
    print(state.toString());
  }

  Future<MeetTeam> setTeam(String teamId) async {
    MeetTeam newMeetTeam = await _meetUseCase.getTeam(teamId);
    state.setMyTeam(newMeetTeam);
    return newMeetTeam;
  }

  Future<void> getMyTeams({bool put = true}) async {
    List<MeetTeam> myTeams = await _meetUseCase.getMyTeams();
    state.setMyTeams(myTeams);
    if (put) emit(state.copy());
    print("팀 목록 ${state.myTeams}");
  }

  Future<void> removeTeam(String teamId) async {
    await _meetUseCase.removeTeam(teamId);
    state.removeMyTeamById(teamId);
    print("cubit - 팀 삭제 완료");
  }

  void updateMyTeam(MeetTeam meetTeam) {
    _meetUseCase.updateMyTeam(meetTeam);
  }

  void refreshMeetPage() async { // TODO : refresh 수정
    state.setIsLoading(true);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    await getMyTeams();
    await fetchTeamCount();

    state.setIsLoading(false);
    emit(state.copy());
  }

  void setMyFilteredFriends(List<User> filteredFriends) {
    state.setMyFilteredFriends(filteredFriends);
    emit(state.copy());
    print("cubit - set Filtered Friends 끝 ${filteredFriends}");
  }

  Future<int> fetchTeamCount({bool put = true}) async {
    int teamCount = await _meetUseCase.getTeamCount();
    state.setTeamCount(teamCount);
    if (put) emit(state.copy());
    return state.teamCount;
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

  Future<void> pressedFriendCodeAddButton(String inviteCode) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      User friend = await _friendUseCase.addFriendBy(inviteCode);
      state.addFriend(friend);
      state.setRecommendedFriends(await _friendUseCase.getRecommendedFriends(put: true));
    } catch (e, trace) {
      print("친구추가 실패! $e $trace");
      throw Error();
    } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }

  Future<void> pressedFriendAddButton(User friend) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      await _friendUseCase.addFriend(friend);
      state.addFriend(friend);
      state.setRecommendedFriends(await _friendUseCase.getRecommendedFriends(put: true));
    } catch (e, trace) {
      print("친구추가 실패! $e $trace");
      throw Error();
    } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }
}
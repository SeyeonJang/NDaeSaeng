import 'dart:io';

import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/data/model/proposal_request_dto.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/use_case/meet_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/university_use_case.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../common/util/analytics_util.dart';
import '../../../domain/entity/blind_date_team_detail.dart';
import '../../../domain/entity/university.dart';

class MeetCubit extends Cubit<MeetState> {

  MeetCubit() : super(MeetState.init());
  static final UserUseCase _userUseCase = UserUseCase();
  static final FriendUseCase _friendUseCase = FriendUseCase();
  static final MeetUseCase _meetUseCase = MeetUseCase();
  static final UniversityUseCase _universityUseCase = UniversityUseCase();
  bool _initialized = false;

  // pagination
  static const int NUMBER_OF_POSTS_PER_REQUEST = 10;
  final PagingController<int, BlindDateTeam> pagingController = PagingController(firstPageKey: 0);

  void initMeet({MeetTeam? initPickedTeam}) async {
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

    // Pagination<BlindDateTeam> paginationBlindTeams = await _meetUseCase.getBlindDateTeams(page:0, targetLocationId: 0);
    // _numberOfPostsPerRequest = paginationBlindTeams.numberOfElements ?? 10;

    // List<BlindDateTeam> blindDateTeams = paginationBlindTeams.content ?? [];
    // state.setBlindDateTeams(blindDateTeams);

    await getMyTeams(put: false);
    if (!state.pickedTeam && state.myTeams.isNotEmpty) {
      state.setMyTeam(state.myTeams[0]);
    }
    if (initPickedTeam != null) setPickedTeam(initPickedTeam);

    state.setIsLoading(false);
    emit(state.copy());
    print("test: ${state.getMyTeam()}");
  }

  void initMeetIntro() async {
    state.setIsLoading(true);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    // TODO : Location, University 지우고 create init할 때 진행시키기
    List<Location> locations = await _meetUseCase.getLocations();
    state.setServerLocations(locations);
    List<University> universities = await _universityUseCase.getUniversities();
    state.universities = universities;

    await getMyTeams(put: false);
    if (!state.pickedTeam && state.myTeams.isNotEmpty) {
      state.setMyTeam(state.myTeams[0]);
    }

    state.setIsLoading(false);
    emit(state.copy());
  }

  void getUniversitiesList() async {
    state.setIsLoading(true);
    emit(state.copy());
    print("0909090909");
    print(state.isLoading);

    List<University> universities = await _universityUseCase.getUniversities();
    state.universities = universities;

    state.setIsLoading(false);
    print("0909090909");
    print(state.isLoading);
    emit(state.copy());
  }

  List<University> get getUniversities => state.universities;

  void initCreateTeam() async {
    state.setIsLoading(true);
    emit(state.copy());

    // User userResponse = await _userUseCase.myInfo();
    // state.setMyInfo(userResponse);
    // List<User> friends = await _friendUseCase.getMyFriends();
    // state.setMyFriends(friends);
    // List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    // state.setRecommendedFriends(newFriends);
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
      final newTeams = (await _meetUseCase.getBlindDateTeams(page: pageKey, size: NUMBER_OF_POSTS_PER_REQUEST)).content ?? [];
      final isLastPage = newTeams.length < NUMBER_OF_POSTS_PER_REQUEST;
      if (isLastPage) {
        pagingController.appendLastPage(newTeams);
      } else {
        final nextPageKey = pageKey + 1;
        AnalyticsUtil.logEvent('과팅_목록_이성 팀 불러오기(페이지네이션)', properties: {
          '새로 불러온 페이지 인덱스': nextPageKey
        });
        // await Future.delayed(Duration(seconds: 1));
        pagingController.appendPage(newTeams, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<BlindDateTeamDetail> getBlindDateTeam(int id) async {
    return await _meetUseCase.getBlindDateTeam(id);
  }

  void pressedOneTeam(int teamId) {
    state.setTeamId(teamId);
    emit(state.copy());
  }

  void setMyTeam(MeetTeam myTeam) {
    state.setMyTeam(myTeam);
    emit(state.copy());
  }

  void setPickedTeam(MeetTeam myTeam) {
    state.setPickedTeam(true);
    setMyTeam(myTeam);
  }

  void postProposal(int requestingTeamId, int requestedTeamId) async {
    ProposalRequestDto newProposal = ProposalRequestDto(requestingTeamId: requestingTeamId, requestedTeamId: requestedTeamId);
    _meetUseCase.postProposal(newProposal);
    state.setProposalStatus(false);
    emit(state.copy());
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
    // state.setMyTeam(myTeams[0]);
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

    // Pagination<BlindDateTeam> paginationBlindTeams = await _meetUseCase.getBlindDateTeams(page:0, size: NUMBER_OF_POSTS_PER_REQUEST, targetLocationId: 0);
    // _numberOfPostsPerRequest = paginationBlindTeams.numberOfElements ?? 10;
    // List<BlindDateTeam> blindDateTeams = paginationBlindTeams.content ?? [];
    // state.setBlindDateTeams(blindDateTeams);

    await getMyTeams();
    if (!state.pickedTeam && state.myTeams.length > 0)
      state.setMyTeam(state.myTeams[0]);
    // await fetchTeamCount();

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

  // 이미지 업로드 (CreateTeam w/ NoVote)
  void uploadProfileImage(File file, User userResponse) async {
    try {
      ToastUtil.showToast('내 사진을 업로드하고 있어요!');
      // await _userUseCase.uploadProfileImage(file, userResponse); // TODO : 이미지 업로드 useCase
      ToastUtil.showToast('내 사진 업로드가 완료됐어요!');
    } catch (e) {
      ToastUtil.showToast('사진 업로드 중 오류가 발생했습니다.');
      print('사진 업로드 중 오류: $e');
    }
  }

  void setProfileImage(File file) {
    state.profileImageFile = file;
    emit(state.copy());
  }
}
import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

@JsonSerializable()
class MeetState {
  late MeetStateEnum meetPageState;
  // meet - standby
  late User userResponse;
  // meet - createTeam
  late bool isLoading;
  late bool isMemberOneAdded;
  late bool isMemberTwoAdded;
  late Set<User> friends;
  late List<User> filteredFriends;
  late Set<User> teamMembers;
  late Set<Location> cities;
  late List<MeetTeam> myTeams;
  late MeetTeam newTeam;
  late String teamName;
  late bool isChecked;

  MeetState ({
    required this.meetPageState,
    required this.userResponse,
    required this.isLoading,
    required this.isMemberOneAdded,
    required this.isMemberTwoAdded,
    required this.friends,
    required this.filteredFriends,
    required this.teamMembers,
    required this.cities,
    required this.myTeams,
    required this.teamName,
    required this.isChecked
  });

  MeetState.init() { // 초기값 설정
    meetPageState = MeetStateEnum.landing;
    userResponse = User(
      personalInfo: null,
      university: null,
    );
    isLoading = false;
    isMemberOneAdded = false;
    isMemberTwoAdded = false;
    friends = {};
    filteredFriends = [];
    teamMembers = {};
    cities = {};
    myTeams = [];
    teamName = '';
    isChecked = false;
  }

  MeetState copy() => MeetState(
    meetPageState: meetPageState,
    userResponse: userResponse,
    isLoading: isLoading,
    isMemberOneAdded: isMemberOneAdded,
    isMemberTwoAdded: isMemberTwoAdded,
    friends: friends,
    filteredFriends: filteredFriends,
    teamMembers: teamMembers,
    cities: cities,
    myTeams: myTeams,
    teamName: teamName,
    isChecked: isChecked
  );

  void setAll(MeetState state) {
      meetPageState = state.meetPageState;
      userResponse = state.userResponse;
      isLoading = state.isLoading;
      isMemberOneAdded = state.isMemberOneAdded;
      isMemberTwoAdded = state.isMemberTwoAdded;
      friends = state.friends;
      filteredFriends = state.filteredFriends;
      teamMembers = state.teamMembers;
      cities = state.cities;
      myTeams = state.myTeams;
      teamName = state.teamName;
      isChecked = state.isChecked;
  }

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setIsChecked(bool isChecked) {
    this.isChecked = isChecked;
  }

  // 추가된 친구가 한 명인지 판단
  void setIsMemberOneAdded(bool isMemberOneAdded) {
    this.isMemberOneAdded = isMemberOneAdded;
  }

  // 추가된 친구가 두 명인지 판단
  void setIsMemberTwoAdded(bool isMemberTwoAdded) {
    this.isMemberTwoAdded = isMemberTwoAdded;
  }

  MeetState setMyInfo(User userResponse) {
    this.userResponse = userResponse;
    return this;
  }

  MeetState setMyFriends(List<User> friends) {
    this.friends = friends.toSet();
    return this;
  }

  MeetState setMyFilteredFriends(List<User> filteredFriends) {
    this.filteredFriends = filteredFriends;
    return this;
  }

  MeetState addMyTeam(MeetTeam team) {
    this.myTeams.add(team);
    return this;
  }

  MeetState removeMyTeamById(String teamId) {
    myTeams.removeWhere((element) => element.id == teamId);
    return this;
  }

  MeetState setMyTeam(MeetTeam team) {
    this.newTeam = team;
    return this;
  }

  MeetState setTeamMembers(List<User> filteredFriends) {
    teamMembers = filteredFriends.toSet();
    return this;
  }

  List<MeetTeam> setMyTeams(List<MeetTeam> myTeams) {
    this.myTeams = myTeams;
    return this.myTeams;
  }

  List<Location> getCities() {
    List<Location> newCities = cities.toList();
    return newCities;
  }

  MeetState setCities(List<Location> cities) {
    this.cities = cities.toSet();
    return this;
  }

  void addTeamMember(User friend) {
    teamMembers.add(friend);
    // int friendIndex = filteredFriends.indexWhere((f) => f == friend);
    //     if (friendIndex != -1) {
    //   filteredFriends.removeAt(friendIndex);
    // }

    print("state - friend 추가 {$friend}");
    print("state - 팀 멤버에는 친구 추가 ${teamMembers}");
    print("state - 필터링 친구에는 친구 삭제 ${filteredFriends}");
  }

  void deleteTeamMember(User friend) {
    // filteredFriends.add(friend);
    teamMembers.remove(friend);
    print("state - friend 삭제 {$friend}");
    print("state - 필터링 친구에는 친구 추가 ${filteredFriends}");
    print("state - 팀 멤버에는 친구 삭제 ${teamMembers}");
  }

  @override
  String toString() {
    // return 'MeetState{meetPageState: $meetPageState, userResponse: $userResponse, isLoading: $isLoading, isMemberOneAdded: $isMemberOneAdded, isMemberTwoAdded: $isMemberTwoAdded, friends: $friends, filteredFriends: $filteredFriends, teamMembers: $teamMembers, cities: $cities, myTeams: $myTeams, teamName: $teamName, isChecked: $isChecked}';
    return 'MyTeams: ${myTeams}';
  }
}

enum MeetStateEnum {
  landing,
  twoPeople,
  threePeople,
  twoPeopleDone,
  threePeopleDone;

  bool get isMeetLanding => this == MeetStateEnum.landing;
  bool get isTwoPeople => this == MeetStateEnum.twoPeople;
  bool get isThreePeople => this == MeetStateEnum.threePeople;
  bool get isTwoPeopleDone => this == MeetStateEnum.twoPeopleDone;
  bool get isThreePeopleDone => this == MeetStateEnum.threePeopleDone;
}
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
  late Set<User> teamMembers;
  late Set<Location> cities;
  late List<MeetTeam> myTeams;
  late MeetTeam newTeam;
  late String teamName;

  MeetState ({
    required this.meetPageState,
    required this.userResponse,
    required this.isLoading,
    required this.isMemberOneAdded,
    required this.isMemberTwoAdded,
    required this.friends,
    required this.teamMembers,
    required this.cities,
    required this.myTeams,
    required this.teamName
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
    teamMembers = {};
    cities = {};
    myTeams = [];
    teamName = '';
  }

  MeetState copy() => MeetState(
    meetPageState: meetPageState,
    userResponse: userResponse,
    isLoading: isLoading,
    isMemberOneAdded: isMemberOneAdded,
    isMemberTwoAdded: isMemberTwoAdded,
    friends: friends,
    teamMembers: teamMembers,
    cities: cities,
    myTeams: myTeams,
    teamName: teamName
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
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

  MeetState setTeamMembers(List<User> friends) {
    teamMembers = friends.toSet();
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
    friends.remove(friend);
  }

  void deleteTeamMember(User friend) {
    friends.add(friend);
    teamMembers.remove(friend);
  }

  @override
  String toString() {
    return 'MeetState{meetPageState: $meetPageState}';
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
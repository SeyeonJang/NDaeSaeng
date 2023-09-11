import 'package:dart_flutter/src/domain/entity/matched_teams.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

@JsonSerializable()
class ChatState {
  late User userResponse;
  late bool isLoading;
  late List<MatchedTeams> myMatchedTeams;
  late MatchedTeams oneMatchedTeams;

  ChatState ({
    required this.userResponse,
    required this.isLoading,
    required this.myMatchedTeams,
    required this.oneMatchedTeams
  });

  ChatState.init() {
    userResponse = User(
      personalInfo: null,
      university: null,
      titleVotes: []
    );
    isLoading = false;
    myMatchedTeams = [];
    oneMatchedTeams = MatchedTeams(
        id: 0,
        meetTeams: [],
        messages: []
    );
  }

  ChatState copy() => ChatState(
    userResponse: userResponse,
    isLoading: isLoading,
    myMatchedTeams: myMatchedTeams,
    oneMatchedTeams: oneMatchedTeams
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setMyMatchedTeams(List<MatchedTeams> myMatchedTeams) {
    this.myMatchedTeams = myMatchedTeams;
  }

  void setOneMatchedTeams(MatchedTeams oneMatchedTeams) {
    this.oneMatchedTeams = oneMatchedTeams;
  }

  void setMyInfo(User userResponse) {
    this.userResponse = userResponse;
  }
}
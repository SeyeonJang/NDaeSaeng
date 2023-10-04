import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

@JsonSerializable()
class ChatState {
  late User userResponse;
  late bool isLoading;
  late List<ChatRoom> myChatRooms;
  late List<Proposal> receivedList;
  late List<Proposal> requestedList;

  ChatState ({
    required this.userResponse,
    required this.isLoading,
    required this.myChatRooms,
    required this.receivedList,
    required this.requestedList
  });

  ChatState.init() {
    userResponse = User(
      personalInfo: null,
      university: null,
      titleVotes: []
    );
    isLoading = false;
    myChatRooms = [];
    receivedList = [];
    requestedList = [];
  }

  ChatState copy() => ChatState(
    userResponse: userResponse,
    isLoading: isLoading,
    myChatRooms: myChatRooms,
    receivedList: receivedList,
    requestedList: requestedList
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setChatRooms(List<ChatRoom> myChatRooms) {
    this.myChatRooms = myChatRooms;
  }

  void setMyInfo(User userResponse) {
    this.userResponse = userResponse;
  }

  void setReceivedList(List<Proposal> receivedList) {
    this.receivedList = receivedList;
  }

  void setRequestedList(List<Proposal> requestedList) {
    this.requestedList = requestedList;
  }
}
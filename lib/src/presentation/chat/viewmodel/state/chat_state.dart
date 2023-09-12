import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

@JsonSerializable()
class ChatState {
  late User userResponse;
  late bool isLoading;
  late List<ChatRoom> myChatRooms;
  late ChatRoom chatRoom;

  ChatState ({
    required this.userResponse,
    required this.isLoading,
    required this.myChatRooms,
    required this.chatRoom
  });

  ChatState.init() {
    userResponse = User(
      personalInfo: null,
      university: null,
      titleVotes: []
    );
    isLoading = false;
    myChatRooms = [];
    chatRoom = ChatRoom(
        id: 0,
        myTeam: BlindDateTeam(id: 0, name: '', averageBirthYear: 0, regions: [], universityName: '', isCertifiedTeam: false, teamUsers: []),
        otherTeam: BlindDateTeam(id: 0, name: '', averageBirthYear: 0, regions: [], universityName: '', isCertifiedTeam: false, teamUsers: []),
        message: ChatMessage(userId: 0, message: '', sendTime: DateTime.now())
    );
  }

  ChatState copy() => ChatState(
    userResponse: userResponse,
    isLoading: isLoading,
    myChatRooms: myChatRooms,
    chatRoom: chatRoom
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setChatRooms(List<ChatRoom> myMatchedTeams) {
    this.myChatRooms = myMatchedTeams;
  }

  void setOneMatchedTeams(ChatRoom oneMatchedTeams) {
    this.chatRoom = oneMatchedTeams;
  }

  void setMyInfo(User userResponse) {
    this.userResponse = userResponse;
  }
}
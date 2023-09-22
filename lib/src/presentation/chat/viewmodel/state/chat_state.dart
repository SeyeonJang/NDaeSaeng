import 'package:dart_flutter/src/common/chat/chat_connection.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

@JsonSerializable()
class ChatState {
  late User userResponse;
  late bool isLoading;
  late List<ChatRoom> myChatRooms;
  late ChatRoom chatRoom; // 안쓰는중
  late ChatRoomDetail myChatRoom;
  late int chatRoomId;
  late List<Proposal> receivedList;
  late List<Proposal> requestedList;

  ChatState ({
    required this.userResponse,
    required this.isLoading,
    required this.myChatRooms,
    required this.chatRoom,
    required this.myChatRoom,
    required this.chatRoomId,
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
    chatRoom = ChatRoom(
        id: 0,
        myTeam: BlindDateTeam(id: 0, name: '', averageBirthYear: 0, regions: [], universityName: '', isCertifiedTeam: false, teamUsers: []),
        otherTeam: BlindDateTeam(id: 0, name: '', averageBirthYear: 0, regions: [], universityName: '', isCertifiedTeam: false, teamUsers: []),
        message: ChatMessage(userId: 0, message: '', sendTime: DateTime.now())
    );
    myChatRoom = ChatRoomDetail(
        id: 0,
        myTeam: BlindDateTeamDetail(id: 0, name: '', averageAge: 0, regions: [], universityName: '', isCertifiedTeam: false, teamUsers: [], proposalStatus: true),
        otherTeam: BlindDateTeamDetail(id: 0, name: '', averageAge: 0, regions: [], universityName: '', isCertifiedTeam: false, teamUsers: [], proposalStatus: true),
        messages: [],
        connection: ChatConnection('', 0)
    );
    chatRoomId = 0;
    receivedList = [];
    requestedList = [];
  }

  ChatState copy() => ChatState(
    userResponse: userResponse,
    isLoading: isLoading,
    myChatRooms: myChatRooms,
    chatRoom: chatRoom,
    myChatRoom: myChatRoom,
    chatRoomId: chatRoomId,
    receivedList: receivedList,
    requestedList: requestedList
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setChatRooms(List<ChatRoom> myChatRooms) {
    this.myChatRooms = myChatRooms;
  }

  void setChatRoom(ChatRoomDetail myChatRoom) {
    this.myChatRoom = myChatRoom;
  }

  void setMyInfo(User userResponse) {
    this.userResponse = userResponse;
  }

  void setChatRoomId(int chatRoomId) {
    this.chatRoomId = chatRoomId;
  }

  void setReceivedList(List<Proposal> receivedList) {
    this.receivedList = receivedList;
  }

  void setRequestedList(List<Proposal> requestedList) {
    this.requestedList = requestedList;
  }
}
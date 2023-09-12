import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';

class ChatRoomDetail {
  final int id;
  final BlindDateTeamDetail myTeam;
  final BlindDateTeamDetail otherTeam;
  final List<ChatMessage> messages;

  ChatRoomDetail({
    required this.id,
    required this.myTeam,
    required this.otherTeam,
    required this.messages
  });

  factory ChatRoomDetail.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    BlindDateTeamDetail parsedMyTeam = BlindDateTeamDetail.fromJson(json['myTeam']);
    BlindDateTeamDetail parsedOtherTeam = BlindDateTeamDetail.fromJson(json['otherTeam']);
    List<ChatMessage> parsedMessages = [];
    if (json['messages'] != null) {
      var messagesJsonList = json['messages'] as List<dynamic>;
      parsedMessages =
          messagesJsonList.map((v) => ChatMessage.fromJson(v)).toList();
    }


    return ChatRoomDetail(
      id: parsedId,
      myTeam: parsedMyTeam,
      otherTeam: parsedOtherTeam,
      messages: parsedMessages,
    );
  }

  @override
  String toString() {
    return 'MatchedTeams{id: $id, myTeam: $myTeam, otherTeam: $otherTeam, messages: $messages}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatRoomDetail &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          myTeam == other.myTeam &&
          otherTeam == other.otherTeam &&
          messages == other.messages;

  @override
  int get hashCode =>
      id.hashCode ^ myTeam.hashCode ^ otherTeam.hashCode ^ messages.hashCode;
}
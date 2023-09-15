import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';

class ChatRoom {
  final int id;
  final BlindDateTeam myTeam;
  final BlindDateTeam otherTeam;
  final ChatMessage message;

  ChatRoom({
    required this.id,
    required this.myTeam,
    required this.otherTeam,
    required this.message
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    BlindDateTeam parsedMyTeam = BlindDateTeam.fromJson(json['myTeam']);
    BlindDateTeam parsedOtherTeam = BlindDateTeam.fromJson(json['otherTeam']);
    ChatMessage parsedMessage = ChatMessage.fromJson(json['message']);


    return ChatRoom(
      id: parsedId,
      myTeam: parsedMyTeam,
      otherTeam: parsedOtherTeam,
      message: parsedMessage,
    );
  }

  @override
  String toString() {
    return 'MatchedTeams{id: $id, myTeam: $myTeam, otherTeam: $otherTeam, message: $message}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatRoom &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          myTeam == other.myTeam &&
          otherTeam == other.otherTeam &&
          message == other.message;

  @override
  int get hashCode =>
      id.hashCode ^ myTeam.hashCode ^ otherTeam.hashCode ^ message.hashCode;
}
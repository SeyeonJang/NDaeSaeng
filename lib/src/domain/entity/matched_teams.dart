import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';

class MatchedTeams {
  final int id;
  final List<BlindDateTeam> meetTeams;
  final List<ChatMessage> messages;

  MatchedTeams({
    required this.id,
    required this.meetTeams,
    required this.messages
  });

  factory MatchedTeams.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];

    List<BlindDateTeam> parsedMeetTeams = [];
    if (json['meetTeams'] != null) {
      var meetTeamsJsonList = json['meetTeams'] as List<dynamic>;
      parsedMeetTeams =
          meetTeamsJsonList.map((v) => BlindDateTeam.fromJson(v)).toList();
    }

    List<ChatMessage> parsedMessages = [];
    if (json['messages'] != null) {
      var messagesJsonList = json['messages'] as List<dynamic>;
      parsedMessages =
          messagesJsonList.map((v) => ChatMessage.fromJson(v)).toList();
    }


    return MatchedTeams(
      id: parsedId,
      meetTeams: parsedMeetTeams,
      messages: parsedMessages,
    );
  }

  @override
  String toString() {
    return 'MatchedTeams{id: $id, meetTeams: $meetTeams, messages: $messages}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchedTeams &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          meetTeams == other.meetTeams &&
          messages == other.messages;

  @override
  int get hashCode => id.hashCode ^ meetTeams.hashCode ^ messages.hashCode;
}
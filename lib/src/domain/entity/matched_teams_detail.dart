import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';

class MatchedTeamsDetail {
  final int id;
  final List<BlindDateTeamDetail> meetTeams;
  final List<ChatMessage> messages;

  MatchedTeamsDetail({
    required this.id,
    required this.meetTeams,
    required this.messages
  });

  factory MatchedTeamsDetail.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];

    List<BlindDateTeamDetail> parsedMeetTeams = [];
    if (json['meetTeams'] != null) {
      var meetTeamsJsonList = json['meetTeams'] as List<dynamic>;
      parsedMeetTeams =
          meetTeamsJsonList.map((v) => BlindDateTeamDetail.fromJson(v)).toList();
    }

    List<ChatMessage> parsedMessages = [];
    if (json['messages'] != null) {
      var messagesJsonList = json['messages'] as List<dynamic>;
      parsedMessages =
          messagesJsonList.map((v) => ChatMessage.fromJson(v)).toList();
    }


    return MatchedTeamsDetail(
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
          other is MatchedTeamsDetail &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              meetTeams == other.meetTeams &&
              messages == other.messages;

  @override
  int get hashCode => id.hashCode ^ meetTeams.hashCode ^ messages.hashCode;
}
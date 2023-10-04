import 'package:dart_flutter/src/domain/entity/user.dart';

class ChatMessage {
  final int userId;
  final String message;
  final DateTime sendTime;

  ChatMessage({
    required this.userId,
    required this.message,
    required this.sendTime
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final int parsedUserId = json['userId'];
    final String parsedMeesage = json['message'];
    final DateTime parsedSendTime = json['sendTime'];

    return ChatMessage(
      userId: parsedUserId,
      message: parsedMeesage,
      sendTime: parsedSendTime,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['message'] = message;
    data['sendTime'] = sendTime;
    return data;
  }

  @override
  String toString() {
    return 'ChatMessage{userId: $userId, message: $message, sendTime: $sendTime}';
  }
}
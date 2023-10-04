import 'package:dart_flutter/src/common/chat/type/chat_message_type.dart';

class MessageSub {
  final int chatRoomId;
  final int chatMessageId;
  final int senderId;
  final ChatMessageType chatMessageType;
  final String content;
  final DateTime createdTime;

  MessageSub({
    required this.chatRoomId,
    required this.chatMessageId,
    required this.senderId,
    required this.chatMessageType,
    required this.content,
    required this.createdTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = chatRoomId;
    data['chatMessageId'] = chatMessageId;
    data['senderId'] = senderId;
    data['chatMessageType'] = chatMessageType;
    data['content'] = content;
    data['createdTime'] = createdTime;
    return data;
  }

  static MessageSub fromJson(Map<String, dynamic> json) {
    return MessageSub(
      chatRoomId: json['chatRoomId'],
      chatMessageId: json['chatMessageId'],
      chatMessageType: ChatMessageType.fromString(json['chatMessageType']),
      senderId: json['senderId'],
      content: json['content'],
      createdTime: DateTime.parse(json['createdTime']),
    );
  }
}

import 'package:dart_flutter/src/common/chat/type/message_type.dart';
import 'package:meta/meta.dart';

@immutable
class MessagePub {
  final int chatRoomId;
  final int senderId;
  final MessageType chatMessageType;
  final String content;

  const MessagePub({
    required this.chatRoomId,
    required this.senderId,
    required this.chatMessageType,
    required this.content
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = chatRoomId;
    data['senderId'] = senderId;
    data['chatMessageType'] = chatMessageType.name;
    data['content'] = content;
    return data;
  }
}

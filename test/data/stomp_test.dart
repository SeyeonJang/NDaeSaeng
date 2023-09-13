import 'dart:convert';

import 'package:dart_flutter/src/common/chat/chat_connection.dart';
import 'package:dart_flutter/src/common/chat/message_pub.dart';
import 'package:dart_flutter/src/common/chat/type/message_type.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void onConnectCallback(StompFrame connectFrame) {
  print(connectFrame.body ?? "");
}

void main() async {
  ChatConnection chatConn = ChatConnection("dart-server-dev-aiasblaoxa-du.a.run.app", 1);
  await chatConn.activate();

  chatConn.subscribe((frame) {
    print("받은거 ${frame.body}" ?? "[EMPTY MSG]");
  });

  MessagePub msg = const MessagePub(
    chatRoomId: 1,
    senderId: 2450,
    chatMessageType: MessageType.TALK,
    content: "안녕하세요"
  );
  chatConn.send(jsonEncode(msg));

  await Future.delayed(const Duration(seconds: 10000));
  await chatConn.deactivate();
}

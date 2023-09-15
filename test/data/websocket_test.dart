
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {

  final channel = WebSocketChannel.connect(
    // Uri.parse('wss://echo.websocket.events'),
    // Uri.parse('ws://localhost:10000'),
    Uri.parse('ws://dart-server-dev-aiasblaoxa-du.a.run.app/ws'),
  );

  channel.sink.add("HELLO!");
  channel.sink.add('''
  {
    "chatMessageType": "ENTER",
    "chatRoomId": 1,
    "senderId": 3407,
    "content": "안녕하세요"
  }
  ''');

  await Future.delayed(Duration(seconds: 1));
  channel.sink.close();

  print("it is done");
}

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatConnection {
  static const String subscribeUri = '/topic/chat/rooms';
  static const String publishUri = '/app/chat/rooms';

  late StompClient _client;
  late String _subDestination;
  late String _pubDestination;

  ChatConnection(final String baseUrl, final int chatroomId) {
    _client = StompClient(
      config: StompConfig(
        url: 'ws://$baseUrl/ws',
        onConnect: onConnectCallback,
      )
    );
    _subDestination = '$subscribeUri/$chatroomId';
    _pubDestination = '$publishUri/$chatroomId';
  }

  void onConnectCallback(StompFrame connectFrame) {
    print("[chat_connection.dart][chat stomp status]: ${connectFrame.command}");
  }

  Future<void> activate() async {
    _client.activate();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deactivate() async {
    await Future.delayed(const Duration(seconds: 1));
    _client.deactivate();
  }

  void subscribe(Function(StompFrame) callback) {
    _client.subscribe(
        destination: _subDestination,
        callback: callback,
    );
  }

  void send(final String message) {
    print("내가보낸거 $message");
    _client.send(destination: _pubDestination, body: message, headers: {});
  }
}

import 'package:dart_flutter/src/common/exception/stomp_authroization_exception.dart';
import 'package:dart_flutter/src/common/exception/stomp_connection_exception.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatConnection {
  static const String subscribeUri = '/topic/chat/rooms';
  static const String publishUri = '/app/chat/rooms';

  late StompClient _client;
  late String _subDestination;
  late String _pubDestination;
  static late String _authorizationToken;

  ChatConnection(final String baseUrl, final int chatroomId) {
    try {
      _setStompClientInfromation(baseUrl);
    } catch (e) {
      throw StompAuthorizationException("STOMP 인증 토큰 정보가 없습니다.");
    }
    _subDestination = '$subscribeUri/$chatroomId';
    _pubDestination = '$publishUri/$chatroomId';

  }

  void _setStompClientInfromation(String baseUrl) {
    _client = StompClient(
        config: StompConfig(
            url: 'ws://$baseUrl/v1/ws',
            onConnect: onConnectCallback,
            stompConnectHeaders: {
              "Authorization": "Bearer $_authorizationToken"
            }
        )
    );
  }

  void onConnectCallback(StompFrame connectFrame) {
    print("[chat_connection.dart][chat stomp status]: ${connectFrame.command}");
  }

  Future<void> activate() async {
    try {
      _client.activate();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw StompConnectionException("STOMP 연결에 실패했습니다.");
    }
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
    _client.send(destination: _pubDestination, body: message, headers: {});
  }

  static set accessToken(String value) {
    _authorizationToken = value;
  }

  @override
  String toString() {
    return 'ChatConnection{_client: $_client, _subDestination: $_subDestination, _pubDestination: $_pubDestination}';
  }
}

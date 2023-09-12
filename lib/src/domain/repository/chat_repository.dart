import 'package:dart_flutter/src/domain/entity/chat_room.dart';

abstract class ChatRepository {
  Future<ChatRoom> getChatRoomDetail(int teamId);
  Future<List<ChatRoom>> getChatRooms();
}
import 'package:dart_flutter/src/domain/entity/chat_room.dart';

import '../entity/chat_room_detail.dart';

abstract class ChatRepository {
  Future<ChatRoomDetail> getChatRoomDetail(int teamId);
  Future<List<ChatRoom>> getChatRooms();
}
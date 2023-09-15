import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';

abstract class ChatRepository {
  Future<ChatRoomDetail> getChatRoomDetail(int chatRoomId);
  Future<List<ChatRoom>> getChatRooms();
  Future<Pagination<ChatMessage>> getChatMessages(int chatRoomId, {int page = 0});
}
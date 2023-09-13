import 'package:dart_flutter/src/data/repository/dart_chat_repository.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

class ChatUseCase {
  final ChatRepository _chatRepository = DartChatRepository();

  Future<ChatRoomDetail> getChatRoomDetail(int teamId) async {
    return _chatRepository.getChatRoomDetail(teamId);
  }

  Future<List<ChatRoom>> getChatRooms() async {
    return _chatRepository.getChatRooms();
  }
}
import 'package:dart_flutter/src/data/repository/mock_chat_repository.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

class ChatUseCase {
  final ChatRepository _chatRepository = MockChatRepository();

  Future<ChatRoom> getChatRoomDetail(int chatroomId) async {
    return _chatRepository.getChatRoomDetail(chatroomId);
  }

  Future<List<ChatRoom>> getChatRooms() async {
    return _chatRepository.getChatRooms();
  }
}
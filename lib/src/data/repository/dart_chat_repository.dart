import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/chatroom_detail_dto.dart';
import 'package:dart_flutter/src/data/model/chatroom_dto.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

import '../../domain/entity/chat_room_detail.dart';

class DartChatRepository implements ChatRepository {
  DartUserRepositoryImpl _userRepository = DartUserRepositoryImpl();

  @override
  Future<ChatRoomDetail> getChatRoomDetail(int chatroomId) async {
    ChatroomDetailDto chatroomDetail = await DartApiRemoteDataSource.getChatroomDetail(chatroomId);
    int userId = (await _userRepository.myInfo()).personalInfo?.id ?? 0;
    return chatroomDetail.newChatRoomDetail(userId);
  }

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    List<ChatroomDto> list = await DartApiRemoteDataSource.getChatroomList();
    int userId = (await _userRepository.myInfo()).personalInfo?.id ?? 0;
    return list.map((chatroom) => chatroom.newChatRoom(userId)).toList();
  }
}

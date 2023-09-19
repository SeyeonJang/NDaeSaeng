import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/chat/message_sub.dart';
import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/chatroom_detail_dto.dart';
import 'package:dart_flutter/src/data/model/chatroom_dto.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

import '../../domain/entity/chat_room_detail.dart';

class DartChatRepository implements ChatRepository {
  DartUserRepositoryImpl _userRepository = DartUserRepositoryImpl();

  @override
  Future<ChatRoomDetail> getChatRoomDetail(int chatroomId) async {
    ChatroomDetailDto chatroomDetail = await DartApiRemoteDataSource.getChatroomDetail(chatroomId);
    int userId = (await _userRepository.myInfo()).personalInfo?.id ?? 0;
    Pagination<MessageSub> messages = await DartApiRemoteDataSource.getChatMessageList(chatroomId, page: 0);

    String baseUrl = _getDomainFromUrl(AppEnvironment.getEnv.getApiBaseUrl());
    return chatroomDetail.newChatRoomDetail(baseUrl, userId, messages);
  }

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    List<ChatroomDto> list = await DartApiRemoteDataSource.getChatroomList();
    int userId = (await _userRepository.myInfo()).personalInfo?.id ?? 0;
    return list.map((chatroom) => chatroom.newChatRoom(userId)).toList();
  }

  @override
  Future<Pagination<ChatMessage>> getChatMessages(int chatRoomId, {int page = 0}) async {
    Pagination<MessageSub> messages = await DartApiRemoteDataSource.getChatMessageList(chatRoomId, page: page);
    List<ChatMessage> chatMessages = messages.content?.map((msg) => ChatMessage(
      userId: msg.senderId,
      message: msg.content,
      sendTime: msg.createdTime
    )).toList() ?? [];

    return messages.newContent(chatMessages);
  }

  static String _getDomainFromUrl(String url) {
    RegExp regExp = RegExp(r'https?://([^/]+)');
    RegExpMatch? match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? "";
    }
    return '';
  }

  @override
  Future<void> createChatRoom(int proposalId) async {
    await DartApiRemoteDataSource.postChatRoom(proposalId);  // 정상적으로 수락한 경우 채팅방 생성
  }


}

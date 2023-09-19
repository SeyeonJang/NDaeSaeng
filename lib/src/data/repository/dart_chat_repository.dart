import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/chat/message_sub.dart';
import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/chatroom_detail_dto.dart';
import 'package:dart_flutter/src/data/model/chatroom_dto.dart';
import 'package:dart_flutter/src/data/model/proposal_request_dto.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

import '../../domain/entity/chat_room_detail.dart';

class DartChatRepository implements ChatRepository {
  static const String PROPOSAL_ACCEPT = "PROPOSAL_SUCCESS";
  static const String PROPOSAL_REJECT = "PROPOSAL_FAILED";

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

  @override
  Future<void> requestChat(int myTeamId, int targetTeamId) async {
    ProposalRequestDto proposalRequestDto = ProposalRequestDto(
      requestedTeamId: myTeamId,
      requestingTeamId: targetTeamId
    );
    await DartApiRemoteDataSource.postProposal(proposalRequestDto);
  }

  /// 제안 수락이후 채팅방 생성에 대한 책임이 Client에 있으므로 반드시 this.createChatRoom 을 연계할 것
  @override
  Future<Proposal> acceptChatProposal(int proposalId) async {
     return (await DartApiRemoteDataSource.patchProposal(proposalId, PROPOSAL_ACCEPT)).newProposal();
  }

  @override
  Future<Proposal> rejectChatProposal(int proposalId) async {
    return (await DartApiRemoteDataSource.patchProposal(proposalId, PROPOSAL_REJECT)).newProposal();
  }

  @override
  Future<List<Proposal>> getMyReceivedProposals() async {
    var list = await DartApiRemoteDataSource.getProposalList(true);
    return list.map((proposal) => proposal.newProposal()).toList();
  }

  @override
  Future<List<Proposal>> getMyRequestedProposals() async {
    var list = await DartApiRemoteDataSource.getProposalList(false);
    return list.map((proposal) => proposal.newProposal()).toList();
  }
}

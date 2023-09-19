import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/data/repository/dart_chat_repository.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

class ChatUseCase {
  final ChatRepository _chatRepository = DartChatRepository();

  Future<ChatRoomDetail> getChatRoomDetail(int teamId) async {
    return _chatRepository.getChatRoomDetail(teamId);
  }

  Future<List<ChatRoom>> getChatRooms() async {
    return _chatRepository.getChatRooms();
  }

  Future<Pagination<ChatMessage>> getChatMessages(int chatRoomId, {int page = 0}) {
    return _chatRepository.getChatMessages(chatRoomId, page: page);
  }

  // Future<void> createChatRoom(int proposalId) {
  //   return _chatRepository.createChatRoom(proposalId);
  // }

  Future<void> requestChat(int myTeamId, int targetTeamId) async {
    await _chatRepository.requestChat(myTeamId, targetTeamId);
  }

  Future<Proposal> acceptChatProposal(int proposalId) async {
    var proposal = await _chatRepository.acceptChatProposal(proposalId);
    await _chatRepository.createChatRoom(proposalId);
    return proposal;
  }

  Future<Proposal> rejectChatProposal(int proposalId) async {
    return await _chatRepository.rejectChatProposal(proposalId);
  }

  Future<List<Proposal>> getMyRequestedProposals() async {
    return await getMyRequestedProposals();
  }

  Future<List<Proposal>> getMyReceivedProposals() async {
    return await getMyReceivedProposals();
  }
}

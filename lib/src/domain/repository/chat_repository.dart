import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/chat_message.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';

abstract class ChatRepository {
  Future<ChatRoomDetail> getChatRoomDetail(int chatRoomId);
  Future<List<ChatRoom>> getChatRooms();
  Future<Pagination<ChatMessage>> getChatMessages(int chatRoomId, {int page = 0});
  Future<void> createChatRoom(int proposalId);

  Future<void> requestChat(int myTeamId, int targetTeamId);
  Future<Proposal> acceptChatProposal(int proposalId);
  Future<Proposal> rejectChatProposal(int proposalId);
  Future<List<Proposal>> getMyRequestedProposals();
  Future<List<Proposal>> getMyReceivedProposals();
}

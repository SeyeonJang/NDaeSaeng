import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/chat_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/meet_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.init());
  static final UserUseCase _userUseCase = UserUseCase();
  static final ChatUseCase _chatUseCase = ChatUseCase();
  static final MeetUseCase _meetUseCase = MeetUseCase();

  void initChat() async {
    state.setIsLoading(true);
    emit(state.copy());

    User userResponse = await _userUseCase.myInfo();
    state.setMyInfo(userResponse);
    List<ChatRoom> myChatRooms = await _chatUseCase.getChatRooms();
    state.setChatRooms(myChatRooms);

    state.setIsLoading(false);
    emit(state.copy());
  }

  void initResponseGet() async {
    state.setIsLoading(true);
    emit(state.copy());

    List<Proposal> receivedList = await _chatUseCase.getMyReceivedProposals();
    state.setReceivedList(receivedList);

    state.setIsLoading(false);
    emit(state.copy());
  }

  void initResponseSend() async {
    state.setIsLoading(true);
    emit(state.copy());

    List<Proposal> requestedList = await _chatUseCase.getMyRequestedProposals();
    state.setRequestedList(requestedList);

    state.setIsLoading(false);
    emit(state.copy());
  }

  Future<ChatRoomDetail> getChatRoomDetail(int teamId) async {
    ChatRoomDetail myMatchedTeams = await _chatUseCase.getChatRoomDetail(teamId);
    return myMatchedTeams;
  }

  Future<BlindDateTeamDetail> getBlindDateTeam(int id) async {
    return await _meetUseCase.getBlindDateTeam(id);
  }

  Future<void> acceptChatProposal(int proposalId) async {
    await _chatUseCase.acceptChatProposal(proposalId);
  }

  Future<void> rejectChatProposal(int proposalId) async {
    await _chatUseCase.rejectChatProposal(proposalId);
  }
}
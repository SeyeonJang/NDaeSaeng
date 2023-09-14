import 'package:chatview/chatview.dart';
import 'package:dart_flutter/src/domain/use_case/chat_use_case.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChattingCubit extends Cubit<ChatState> {
  ChattingCubit() : super(ChatState.init());
  static final ChatUseCase _chatUseCase = ChatUseCase();

  Future<List<Message>> fetchMoreMessages(int chatRoomId, int pageKey) async {
    final newMessages = (await _chatUseCase.getChatMessages(chatRoomId, page: pageKey)).content?.toList() ?? [];
    print('chatRoomId: ${state.chatRoomId}');
    List<Message> msg = [];
    for (int i=0; i<newMessages.length; i++) {
      msg.add(
        Message(
          sendBy: newMessages[i].userId.toString(),
          createdAt: newMessages[i].sendTime,
          message: newMessages[i].message
        )
      );
    }
    return msg;
  }
}
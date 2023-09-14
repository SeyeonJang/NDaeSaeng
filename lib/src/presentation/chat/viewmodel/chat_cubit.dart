import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/chat_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.init());
  static final UserUseCase _userUseCase = UserUseCase();
  static final ChatUseCase _chatUseCase = ChatUseCase();

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

  Future<ChatRoomDetail> getChatRoomDetail(int teamId) async {
    ChatRoomDetail myMatchedTeams = await _chatUseCase.getChatRoomDetail(teamId);
    // print("getChatRoomDetail한 결과");
    // print(myMatchedTeams.connection);
    // state.setChatRoom(myMatchedTeams);
    return myMatchedTeams;
  }
}
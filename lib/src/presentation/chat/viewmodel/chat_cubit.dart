import 'package:dart_flutter/src/domain/entity/matched_teams.dart';
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
    List<MatchedTeams> myMatchedTeams = await _chatUseCase.getMatchedTeams();
    state.setMyMatchedTeams(myMatchedTeams);

    state.setIsLoading(false);
    emit(state.copy());
  }

  Future<void> getOneMatchedTeams(int teamId) async {
    MatchedTeams myMatchedTeams = await _chatUseCase.getMatchedTeam(teamId);
    state.setOneMatchedTeams(myMatchedTeams);
  }
}
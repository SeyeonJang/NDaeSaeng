import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.init());
}
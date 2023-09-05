import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

@JsonSerializable()
class ChatState {
  late User userResponse;

  ChatState ({
    required this.userResponse
});

  ChatState.init() {
    userResponse = User(
      personalInfo: null,
      university: null,
      titleVotes: []
    );
  }

  ChatState copy() => ChatState(
    userResponse: userResponse
  );
}
enum ChatMessageType {
  TALK, ENTER, QUIT;

  static ChatMessageType fromString(String type) {
    switch (type) {
      case "TALK":
        return ChatMessageType.TALK;
      case "ENTER":
        return ChatMessageType.ENTER;
      case "QUIT":
        return ChatMessageType.QUIT;
      default:
        return ChatMessageType.TALK;
    }
  }
}

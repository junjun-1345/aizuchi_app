enum MessageType {
  user,
  assistant,
  emotion,
  datetime,
}

extension MessageTypeExtension on MessageType {
  static final values = {
    MessageType.user: "user",
    MessageType.assistant: "assistant",
    MessageType.emotion: "emotion",
    MessageType.datetime: "datetime",
  };

  String? get value => values[this];

  static MessageType from(String rawValue) {
    return MessageType.values.firstWhere(
      (e) {
        return e.value == rawValue;
      },
      orElse: (() {
        return MessageType.user;
      }),
    );
  }
}

import 'package:aizuchi_app/domain/entity/enums/message.dart';

enum ClaudeRole {
  user,
  assistant,
}

extension ClaudeRoleExtension on ClaudeRole {
  static final roleValues = {
    ClaudeRole.user: "user",
    ClaudeRole.assistant: "assistant",
  };

  String? get roleValue => roleValues[this];

  static ClaudeRole from(String rawValue) {
    return ClaudeRole.values.firstWhere(
      (e) {
        return e.roleValue == rawValue;
      },
    );
  }
}

ClaudeRole convertToClaudeRole(MessageType messageType) {
  switch (messageType) {
    case MessageType.user:
      return ClaudeRole.user;
    case MessageType.assistant:
      return ClaudeRole.assistant;
    default:
      return ClaudeRole.user;
  }
}

import 'package:aizuchi_app/domain/entity/enums/message.dart';

enum GptRole {
  user,
  system,
  assistant,
}

extension GptRoleExtension on GptRole {
  static final roleValues = {
    GptRole.user: "user",
    GptRole.system: "system",
    GptRole.assistant: "assistant",
  };

  String? get roleValue => roleValues[this];

  static GptRole from(String rawValue) {
    return GptRole.values.firstWhere(
      (e) {
        return e.roleValue == rawValue;
      },
    );
  }
}

GptRole convertToGptRole(MessageType messageType) {
  switch (messageType) {
    case MessageType.user:
      return GptRole.user;
    case MessageType.assistant:
      return GptRole.assistant;
    default:
      return GptRole.system;
  }
}

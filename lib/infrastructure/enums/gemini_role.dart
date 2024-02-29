import 'package:aizuchi_app/domain/entity/enums/message.dart';

enum GeminiRole {
  user,
  model,
  unknown,
}

extension GeminiRoleExtension on GeminiRole {
  static final roleValues = {
    GeminiRole.user: "user",
    GeminiRole.model: "model",
    GeminiRole.unknown: "",
  };

  String? get roleValue => roleValues[this];

  static GeminiRole from(String rawValue) {
    return GeminiRole.values.firstWhere(
      (e) {
        return e.roleValue == rawValue;
      },
      orElse: (() {
        return GeminiRole.unknown;
      }),
    );
  }
}

GeminiRole convertToGeminiRole(MessageType messageType) {
  switch (messageType) {
    case MessageType.user:
      return GeminiRole.user;
    case MessageType.emotion:
      return GeminiRole.user;
    default:
      return GeminiRole.model;
  }
}

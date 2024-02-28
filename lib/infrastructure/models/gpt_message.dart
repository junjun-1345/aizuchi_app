import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/infrastructure/enums/gpt_role.dart';

class GptMessage {
  final GptRole role;
  final String content;

  GptMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'role': GptRoleExtension.roleValues[role],
      'content': content,
    };
  }

  factory GptMessage.fromJson(Map<String, dynamic> json) {
    return GptMessage(
      role: json['role'],
      content: json['content'],
    );
  }

  static GptMessage fromEntity(MessageEntity entity) {
    return GptMessage(
      role: convertToGptRole(entity.type),
      content: entity.content,
    );
  }
}

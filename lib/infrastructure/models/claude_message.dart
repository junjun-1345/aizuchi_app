import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/infrastructure/enums/claude_role.dart';

class ClaudeMessage {
  final ClaudeRole role;
  final String content;

  ClaudeMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'role': ClaudeRoleExtension.roleValues[role],
      'content': content,
    };
  }

  factory ClaudeMessage.fromJson(Map<String, dynamic> json) {
    return ClaudeMessage(
      role: json['role'],
      content: json['content'],
    );
  }

  static ClaudeMessage fromEntity(MessageEntity entity) {
    return ClaudeMessage(
      role: convertToClaudeRole(entity.type),
      content: entity.content,
    );
  }
}

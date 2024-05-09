import 'package:aizuchi_app/infrastructure/enums/claude_model.dart';
import 'package:aizuchi_app/infrastructure/models/claude_message.dart';

class ClaudeContent {
  final ClaudeModel claudeModel;
  final int maxTokens;
  final List<ClaudeMessage> messages;

  ClaudeContent({
    required this.claudeModel,
    required this.maxTokens,
    required this.messages,
  });

  Map<String, dynamic> toJson() => {
        'model': ClaudeModdelExtension.modelValues[claudeModel],
        'max_tokens': maxTokens,
        'messages': messages.map((e) => e.toJson()).toList(),
      };

  factory ClaudeContent.fromJson(Map<String, dynamic> json) => ClaudeContent(
        claudeModel: ClaudeModdelExtension.from(json['claudeModel']),
        maxTokens: json['maxTokens'],
        messages: List<ClaudeMessage>.from(
            json['messages'].map((x) => ClaudeMessage.fromJson(x))),
      );
}

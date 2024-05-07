import 'dart:convert';

import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/repositories/claude_repository.dart';
import 'package:aizuchi_app/env/env.dart';
import 'package:aizuchi_app/infrastructure/enums/claude_model.dart';
import 'package:aizuchi_app/infrastructure/enums/claude_prompt.dart';
import 'package:aizuchi_app/infrastructure/enums/claude_role.dart';
import 'package:aizuchi_app/infrastructure/models/claude_message.dart';
import 'package:aizuchi_app/infrastructure/models/claude_model.dart';
import 'package:http/http.dart' as http;

class ClaudeRepositoryImpl implements ClaudeRepository {
  static const String _url = 'https://api.anthropic.com/v1/messages';
  static final _key = Env.claudeDevApiKey;

  @override
  Future<String> createSummary(
    List<MessageEntity> messagesEntity,
  ) async {
    final ClaudeMessage promptUser = ClaudeMessage(
        role: ClaudeRole.user, content: ClaudePrompt.summary.promptValue ?? "");

    final ClaudeMessage promptAssistant = ClaudeMessage(
        role: ClaudeRole.assistant, content: "わかったよ！今日の日記をまとめてみるね！");

    final List<ClaudeMessage> messages =
        messagesEntity.map((e) => ClaudeMessage.fromEntity(e)).toList();

    final data = ClaudeContent(
      claudeModel: ClaudeModel.sonnet,
      maxTokens: 1024,
      messages: [promptUser, promptAssistant] + messages,
    );

    final map = data.toJson();
    final json = jsonEncode(map);

    var response = await http.post(
      Uri.parse(_url),
      headers: {
        "x-api-key": _key,
        "anthropic-version": "2023-06-01",
        'Content-Type': 'application/json',
      },
      body: json,
    );

    final replyJsonMap = jsonDecode(response.body);
    final replyContent = replyJsonMap["content"][0]["text"];
    // 文字化け対策（utf8）変換
    final reply = utf8.decode(replyContent.runes.toList()).toString();

    return reply;
  }

  @override
  Future<String> reply(
    List<MessageEntity> messagesEntity,
    EmotionType emotion,
  ) async {
    final ClaudeMessage promptUser = ClaudeMessage(
        role: ClaudeRole.user,
        content: ClaudePromptExtension
            .promptValues[convertToClaudePrompt(emotion)]!);

    final ClaudeMessage promptAssistant =
        ClaudeMessage(role: ClaudeRole.assistant, content: "今日はどんな一日だったの??");

    final List<ClaudeMessage> messages =
        messagesEntity.map((e) => ClaudeMessage.fromEntity(e)).toList();

    final data = ClaudeContent(
      claudeModel: ClaudeModel.sonnet,
      maxTokens: 1024,
      messages: [promptUser, promptAssistant] + messages,
    );

    print("object: ${data.toJson()}");

    final map = data.toJson();
    final json = jsonEncode(map);

    var response = await http.post(
      Uri.parse(_url),
      headers: {
        "x-api-key": _key,
        "anthropic-version": "2023-06-01",
        'Content-Type': 'application/json',
      },
      body: json,
    );

    print("object: ${response.body}");

    final replyJsonMap = jsonDecode(response.body);
    final replyContent = replyJsonMap["content"][0]["text"];
    // 文字化け対策（utf8）変換
    final reply = utf8.decode(replyContent.runes.toList()).toString();

    return reply;
  }
}

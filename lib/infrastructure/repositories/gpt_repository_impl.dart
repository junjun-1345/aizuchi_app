import 'dart:convert';

import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/repositories/gpt_repository.dart';
import 'package:aizuchi_app/env/env.dart';
import 'package:aizuchi_app/infrastructure/enums/gpt_model.dart';
import 'package:aizuchi_app/infrastructure/enums/gpt_prompt.dart';
import 'package:aizuchi_app/infrastructure/enums/gpt_role.dart';
import 'package:aizuchi_app/infrastructure/models/gpt_message.dart';
import 'package:aizuchi_app/infrastructure/models/gpt_model.dart';
import 'package:http/http.dart' as http;

class GptRepositoryImpl implements GptRepository {
  static const String _url = 'https://api.openai.com/v1/chat/completions';
  static final _key = Env.gptKey;

  @override
  Future<String> createSummary(
    List<MessageEntity> messagesEntity,
  ) async {
    final GptMessage prompt = GptMessage(
        role: GptRole.system, content: GptPrompt.summary.promptValue ?? "");

    final List<GptMessage> messages =
        messagesEntity.map((e) => GptMessage.fromEntity(e)).toList();

    final data = GptContent(
      gptModel: GptModel.gpt4o,
      messages: [prompt] + messages,
    );

    final map = data.toJson();
    final json = jsonEncode(map);

    var response = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_key',
      },
      body: json,
    );

    final replyJsonMap = jsonDecode(response.body);
    final replyContent = replyJsonMap["choices"][0]["message"]["content"];
    // 文字化け対策（utf8）変換
    final reply = utf8.decode(replyContent.runes.toList()).toString();

    return reply;
  }

  @override
  Future<String> reply(
    List<MessageEntity> messagesEntity,
    EmotionType emotion,
  ) async {
    final GptMessage prompt = GptMessage(
        role: GptRole.system,
        content: GptPromptExtension.promptValues[convertToGptPrompt(emotion)]!);

    final List<GptMessage> messages =
        messagesEntity.map((e) => GptMessage.fromEntity(e)).toList();

    final data = GptContent(
      gptModel: GptModel.gpt4o,
      messages: [prompt] + messages,
    );

    final map = data.toJson();
    final json = jsonEncode(map);

    var response = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_key',
      },
      body: json,
    );

    final replyJsonMap = jsonDecode(response.body);
    final replyContent = replyJsonMap["choices"][0]["message"]["content"];

    // 文字化け対策（utf8）変換
    final reply = utf8.decode(replyContent.runes.toList()).toString();

    return reply;
  }
}

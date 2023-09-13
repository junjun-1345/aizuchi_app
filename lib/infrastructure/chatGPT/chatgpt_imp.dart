import 'dart:convert';
import 'package:aizuchi_app/application/interface/chatGPT/chatgpt.dart';
import 'package:aizuchi_app/domain/models/chatgpt.dart';
import 'package:aizuchi_app/domain/models/chatgptmessage.dart';

import 'package:http/http.dart' as http;

import '../../application/config/env/env.dart';

class ChatGPTService implements ChatGPTInterface {
  @override
  Future<String> sendMessage(List<ChatGPTMessage> value) async {
    String url = 'https://api.openai.com/v1/chat/completions';
    String key = Env.key1;
    final data = Chatgpt(model: 'gpt-3.5-turbo', messages: value);
    // JsonMap <--- データ
    final map = data.toJson();
    // JSON <--- JsonMap
    final json = jsonEncode(map);

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $key',
      },
      body: json,
    );

    // JsonMap <--- JSON
    final replyJsonMap = jsonDecode(response.body);

    // contentを抽出
    final replyContent = replyJsonMap["choices"][0]["message"]["content"];
    // 文字化け対策（utf8）変換
    final reply = utf8.decode(replyContent.runes.toList()).toString();

    return reply;
  }
}

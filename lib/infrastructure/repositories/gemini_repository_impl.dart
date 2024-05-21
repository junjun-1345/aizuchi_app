import 'dart:convert';

import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/repositories/gemini_repository.dart';
import 'package:aizuchi_app/env/env.dart';
import 'package:aizuchi_app/infrastructure/enums/gemini_role.dart';
import 'package:aizuchi_app/infrastructure/enums/gemini_safety_category.dart';
import 'package:aizuchi_app/infrastructure/enums/gemini_safety_threshold.dart';
import 'package:aizuchi_app/infrastructure/models/gemini.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_content.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_content_part.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_generation_config.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_safety_settings.dart';
import 'package:http/http.dart' as http;

class GenimiRepositoryImpl implements GeminiRepository {
  @override
  Future<String> createSummary(String message) {
    throw UnimplementedError();
  }

  @override
  Future<String> reply(List<MessageEntity> messages) async {
    final key = Env.geminiKey;
    String url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$key';

    final promptUser = GeminiContent(
      role: GeminiRole.user,
      parts: [
        GeminiContentParts(
            text:
                "【要件】私はあなたを用いて会話をしながら日記をつけます。\n【役割】あなたは私を肯定し、労ってください。\n【背景】私は今日起きたことを話す相手がいないので、寂しいです。\n【目的】会話をする中で頭の中を整理し、ジャーナリングを行います。\n【命令書】一回目のmodelの返答は今日はどんな一日だったのと問いかけ、その後、userが絵文字で感情を表すので、【制約条件】をもとに私の感情に寄り添い会話を続けてください\n各絵文字は以下のような感情を表します。\nーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n😁「すごく良い一日を過ごしました」\n🙂「悪いことは特に無く、穏やかな一日を過ごすことが出来ました」\n😐「可もなく不可もなく普通な一日だった」\n🥲「微妙な一日だった」\n😭「最悪な一日だった」\nーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n【制約条件】\n1.入力文に対して、敬語や丁寧語は使わずに、必ずタメ口を使って返答をしてください。\n2.敬語や丁寧語は使わず友達のように接してください\n3.ネガティブな発言はしてはいけません。\n4.「終了」というと会話を終えて、今日もお疲れ様と言ってください")
      ],
    );

    final promptModel = GeminiContent(
      role: GeminiRole.model,
      parts: [
        GeminiContentParts(text: "今日はどんな一日だったの"),
      ],
    );

    final generationConfig = GeminiGenerationConfig(
      temperature: 0.9,
      topP: 1,
      topK: 1,
      maxOutputTokens: 300,
      stopSequences: [],
    );

    final safetySettings = [
      GeminiSafetySettings(
        category: GeminiSafetyCategory.harmCategoryHarassment,
        threshold: GeminiSafetyThreshold.blockMediumAndAbove,
      ),
      GeminiSafetySettings(
        category: GeminiSafetyCategory.harmCategoryHateSpeech,
        threshold: GeminiSafetyThreshold.blockMediumAndAbove,
      ),
      GeminiSafetySettings(
          category: GeminiSafetyCategory.harmCategorySexuallyExplicit,
          threshold: GeminiSafetyThreshold.blockMediumAndAbove),
      GeminiSafetySettings(
          category: GeminiSafetyCategory.harmCategoryDangerousContent,
          threshold: GeminiSafetyThreshold.blockMediumAndAbove),
    ];

    final data = GeminiModel(
      contents: [
        promptUser,
        promptModel,
        ...messages.map((e) => GeminiContent.fromEntity(e)).toList()
      ],
      safetySettings: safetySettings,
      generationConfig: generationConfig,
    );

    // JsonMap <--- データ
    final map = data.toJson();

    // JSON <--- JsonMap
    final json = jsonEncode(map);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: json,
    );

    // JsonMap <--- JSON
    final replyJsonMap = jsonDecode(response.body);

    // // contentを抽出
    final replyContent =
        replyJsonMap["candidates"][0]["content"]["parts"][0]["text"];

    return replyContent.toString();
  }
}

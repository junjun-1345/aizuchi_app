import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';

class DailyMock {
  static final monthly = [
    DailyEntity(
        createdAt: DateTime(2024, 3, 1),
        summary: "家族と楽しい夕食を過ごした。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 2),
        summary: "朝起きられず、何もできなかった。",
        emotion: EmotionType.discontent),
    DailyEntity(
        createdAt: DateTime(2024, 3, 3),
        summary: "何もしないでのんびりした。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 4),
        summary: "みんなでランチに行ったよ！",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 5),
        summary: "お出かけをしたよ",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 6),
        summary: "いえからでられない日だった。明日はがんばろう。",
        emotion: EmotionType.sad),
    DailyEntity(
        createdAt: DateTime(2024, 3, 7),
        summary: "雨だった。家でゆっくり過ごした。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 8),
        summary: "友達と遊んだ。楽しかった。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 9),
        summary: "仕事が忙しかった。疲れた。",
        emotion: EmotionType.discontent),
    DailyEntity(
        createdAt: DateTime(2024, 3, 10),
        summary: "家族と過ごした。楽しかった。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 11),
        summary: "おいしいディナーを食べた。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 12),
        summary: "仕事で生産的な一日を過ごし、大きなプロジェクトを終えた。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 13),
        summary: "一日中雨が降っていたが、美術館を訪れてベストを尽くした。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 14),
        summary: "天気が悪かったので、屋外の予定をキャンセルせざるを得なかった。",
        emotion: EmotionType.discontent),
    DailyEntity(
        createdAt: DateTime(2024, 3, 15),
        summary: "ビーチで一日過ごした。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 16),
        summary: "新しい街を探索し、素晴らしいスポットを発見した。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 17),
        summary: "何もしないでのんびりした。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 18),
        summary: "長いハイキングに出かけ、山の上から夕日を楽しんだ。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 19),
        summary: "ストレスと締め切りに押しつぶされそうだった。",
        emotion: EmotionType.discontent),
    DailyEntity(
        createdAt: DateTime(2024, 3, 20),
        summary: "今日は孤独感と闘った。",
        emotion: EmotionType.sad),
    DailyEntity(
        createdAt: DateTime(2024, 3, 21),
        summary: "ずっと読んでいた本を読み終えた。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 22),
        summary: "大好きなバンドのコンサートに行った！",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 23),
        summary: "友人と意見が合わず、腹が立った。",
        emotion: EmotionType.sad),
    DailyEntity(
        createdAt: DateTime(2024, 3, 24),
        summary: "映画館で新しい映画を観た！",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 25),
        summary: "少し体調が悪く、ベッドで休んだ。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 26),
        summary: "一日中少し頭痛がしたが、なんとかなった。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 27),
        emotion: EmotionType.sad,
        summary: "勉強疲れた"),
    DailyEntity(
        createdAt: DateTime(2024, 3, 28),
        summary: "友達とクッキー作りを楽しんだ。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 29),
        summary: "大切なものをなくしてしまい、一日中探していた。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 30),
        summary: "公園で静かに本を読んだ。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 31),
        emotion: EmotionType.discontent,
        summary: "グループディスカッションで無視され、がっかりした。"),
  ];

  static final monthlyRandom = [
    DailyEntity(
        createdAt: DateTime(2024, 3, 1),
        summary: "家族と楽しい夕食を過ごした。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 2),
        summary: "朝起きられず、何もできなかった。",
        emotion: EmotionType.discontent),
    DailyEntity(
        createdAt: DateTime(2024, 3, 4),
        summary: "みんなでランチに行ったよ！",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 5),
        summary: "お出かけをしたよ",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 10),
        summary: "家族と過ごした。楽しかった。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 11),
        summary: "おいしいディナーを食べた。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 12),
        summary: "仕事で生産的な一日を過ごし、大きなプロジェクトを終えた。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 15),
        summary: "ビーチで一日過ごした。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 16),
        summary: "新しい街を探索し、素晴らしいスポットを発見した。",
        emotion: EmotionType.content),
    DailyEntity(
        createdAt: DateTime(2024, 3, 17),
        summary: "何もしないでのんびりした。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 19),
        summary: "ストレスと締め切りに押しつぶされそうだった。",
        emotion: EmotionType.discontent),
    DailyEntity(
        createdAt: DateTime(2024, 3, 20),
        summary: "今日は孤独感と闘った。",
        emotion: EmotionType.sad),
    DailyEntity(
        createdAt: DateTime(2024, 3, 23),
        summary: "友人と意見が合わず、腹が立った。",
        emotion: EmotionType.sad),
    DailyEntity(
        createdAt: DateTime(2024, 3, 24),
        summary: "映画館で新しい映画を観た！",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 26),
        summary: "一日中少し頭痛がしたが、なんとかなった。",
        emotion: EmotionType.neutral),
    DailyEntity(
        createdAt: DateTime(2024, 3, 27),
        emotion: EmotionType.sad,
        summary: "勉強疲れた"),
    DailyEntity(
        createdAt: DateTime(2024, 3, 29),
        summary: "大切なものをなくしてしまい、一日中探していた。",
        emotion: EmotionType.joyful),
    DailyEntity(
        createdAt: DateTime(2024, 3, 31),
        emotion: EmotionType.discontent,
        summary: "グループディスカッションで無視され、がっかりした。"),
  ];
}

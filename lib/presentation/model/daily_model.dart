import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';

class DailyModel {
  final DateTime createdAt;
  final EmotionType emotion;
  final String summary;

  DailyModel({
    required this.createdAt,
    required this.emotion,
    required this.summary,
  });

  static DailyModel fromEntity(DailyEntity dailyEntity) => DailyModel(
        createdAt: dailyEntity.createdAt,
        emotion: dailyEntity.emotion,
        summary: dailyEntity.summary,
      );

  DailyEntity toEntity() => DailyEntity(
        createdAt: createdAt,
        emotion: emotion,
        summary: summary,
      );

  DailyModel copyWith(
      {DateTime? createdAt, EmotionType? emotion, String? summary}) {
    return DailyModel(
      createdAt: this.createdAt, // IDは変更しない
      emotion: this.emotion, // 更新するフィールドのみ新しい値を使う
      summary: summary ?? this.summary, // 他のフィールドも同様に
    );
  }
}

import 'package:aizuchi_app/domain/entity/models/daily.dart';

class SummaryModel {
  final DateTime createdAt;
  final String content;

  SummaryModel({
    required this.createdAt,
    required this.content,
  });

  static SummaryModel fromEntity(DailyEntity dailyEntity) => SummaryModel(
        createdAt: dailyEntity.createdAt,
        content: dailyEntity.summary,
      );
}

import 'package:aizuchi_app/domain/entity/enums/emotion.dart';

class DailyEntity {
  final DateTime createdAt;
  final EmotionType emotion;
  final String summary;

  DailyEntity({
    required this.createdAt,
    required this.emotion,
    required this.summary,
  });
}

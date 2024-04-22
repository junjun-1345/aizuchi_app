import 'package:aizuchi_app/domain/entity/enums/emotion.dart';

class CalendarEntity {
  final DateTime date;
  final EmotionType? emotion;

  CalendarEntity({
    required this.date,
    required this.emotion,
  });
}

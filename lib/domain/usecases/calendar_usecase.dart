import 'package:aizuchi_app/domain/entity/models/calendar.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';

abstract class CalendarUsecase {
  Future<List<List<CalendarEntity>>> createCalendar(
    int year,
    int month,
    bool isWeekStartMonday,
    List<DailyEntity> monthlyEmotions,
  );
  DateTime calculatedDate(int index);
}

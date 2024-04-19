import 'package:aizuchi_app/domain/entity/models/calendar.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';

abstract class CalendarUsecases {
  Future<List<List<CalendarEntity>>> createCalendar(
    int yaer,
    int month,
    bool isWeekStartMonday,
    List<DailyEntity> monthlyEmotions,
  );
}

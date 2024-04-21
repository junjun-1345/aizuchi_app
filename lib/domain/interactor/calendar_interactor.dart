import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/calendar.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/usecases/calendar_usecase.dart';

class CalendarInteractor implements CalendarUsecases {
  @override
  Future<List<List<CalendarEntity>>> createCalendar(int year, int month,
      bool isWeekStartMonday, List<DailyEntity> monthlyEmotions) async {
    final List<List<CalendarEntity>> calendar = List.generate(6, (_) => []);
    final DateTime monthFirstDay = DateTime(year, month, 1);
    final int monthFirstWeekDayInt =
        (monthFirstDay.weekday - (isWeekStartMonday ? 1 : 0)) % 7;
    final DateTime calendarFirstDay =
        monthFirstDay.subtract(Duration(days: monthFirstWeekDayInt));
    final DateTime lastDay = calendarFirstDay.add(const Duration(days: 42));

    var currentDate = calendarFirstDay;
    int currentWeek = 0;
    Map<DateTime, EmotionType> emotionMap = {
      for (var d in monthlyEmotions) d.createdAt: d.emotion
    };

    while (currentDate.isBefore(lastDay)) {
      if (calendar[currentWeek].length < 7) {
        calendar[currentWeek].add(CalendarEntity(
          date: currentDate,
          emotion: emotionMap[currentDate],
        ));
        currentDate = currentDate.add(const Duration(days: 1));
      } else {
        currentWeek++;
      }
    }

    return calendar;
  }

  @override
  DateTime calculatedDate(int index) {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month - index);
  }
}

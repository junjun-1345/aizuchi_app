import 'package:aizuchi_app/domain/models/weekday_model.dart';

class CustomDateTime {
  final _now = DateTime.now();

  String nowDate() {
    return DateTime(_now.year, _now.month, _now.day).toString();
  }

  DateTime nowDateDateTime() {
    return DateTime(_now.year, _now.month, _now.day);
  }

  DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }

  List<String> nowWeekDays() {
    final List<String> _list = [];
    for (int i = 0; i < 7; i++) {
      // EnumとのIndexの差１を引く
      final weekdayIndex = (DateTime.now().weekday + i - 1) % 7;
      _list.add(Weekday.values[weekdayIndex].name);
    }
    return _list;
  }

  List<String> thisWeekDatesStr() {
    final List<String> _list = [];
    for (int i = 0; i < 7; i++) {
      _list.add(nowDateDateTime().subtract(Duration(days: i)).toString());
    }
    return _list;
  }

  List<DateTime> thisWeekDatesDat() {
    final List<DateTime> _list = [];
    for (int i = 0; i < 7; i++) {
      _list.add(nowDateDateTime().subtract(Duration(days: i)));
    }
    return _list;
  }

  // 日曜日始まりは７、月曜日始まりは１
  List<List<DateTime?>> selectedMonthInDaysDat(
      int year, int month, int fisrtWeekDay) {
    var firstDay = DateTime(year, month, 1);
    var lastDay = DateTime(year, month + 1, 0);

    List<DateTime?> days = [];
    List<List<DateTime?>> weeks = [];

    var day = firstDay;

    while (day.month == month) {
      // 日付追加
      days.add(day);

      // 次の日に移動
      day = day.add(Duration(days: 1));

      //土曜日ならweeksのリストに追加に新しいリストを作成
      if (day.weekday == fisrtWeekDay) {
        weeks.add(days);
        days = [];
      }

      // TODO:調整　最終週を追加
      // if (day == lastDay) {
      //   weeks.add(days);
      // }
    }

    // 最初の週の空白のデータを埋める
    while (weeks.first.length < 7) {
      weeks.first.insert(0, null);
    }

    // 最後の週の空白のデータを埋める
    while (weeks.last.length < 7) {
      weeks.last.add(null);
    }

    return weeks;
  }
}

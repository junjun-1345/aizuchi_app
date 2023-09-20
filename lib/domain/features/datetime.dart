import 'package:aizuchi_app/domain/models/weekday_model.dart';

class CustomDateTime {
  final _now = DateTime.now();

  String nowDate() {
    return DateTime(_now.year, _now.month, _now.day).toString();
  }

  DateTime nowDateDateTime() {
    return DateTime(_now.year, _now.month, _now.day);
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

  List<DateTime> thisWeekDatesDTi() {
    final List<DateTime> _list = [];
    for (int i = 0; i < 7; i++) {
      _list.add(nowDateDateTime().subtract(Duration(days: i)));
    }
    return _list;
  }
}

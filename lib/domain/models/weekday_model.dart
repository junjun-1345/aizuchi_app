enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;
}

extension WeekdayNameExtension on Weekday {
  String get name {
    return switch (this) {
      Weekday.monday => "月曜日",
      Weekday.tuesday => "火曜日",
      Weekday.wednesday => "水曜日",
      Weekday.thursday => "木曜日",
      Weekday.friday => "金曜日",
      Weekday.saturday => "土曜日",
      Weekday.sunday => "日曜日",
    };
  }
}

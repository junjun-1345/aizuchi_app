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
      Weekday.monday => "月",
      Weekday.tuesday => "火",
      Weekday.wednesday => "水",
      Weekday.thursday => "木",
      Weekday.friday => "金",
      Weekday.saturday => "土",
      Weekday.sunday => "日",
    };
  }
}

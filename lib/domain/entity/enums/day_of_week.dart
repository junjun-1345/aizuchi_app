enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension DayOfWeekExtension on DayOfWeek {
  static final Map<DayOfWeek, Map<String, String>> names = {
    DayOfWeek.monday: {'en': 'Mon', 'jp': '月'},
    DayOfWeek.tuesday: {'en': 'Tue', 'jp': '火'},
    DayOfWeek.wednesday: {'en': 'Wed', 'jp': '水'},
    DayOfWeek.thursday: {'en': 'Thu', 'jp': '木'},
    DayOfWeek.friday: {'en': 'Fri', 'jp': '金'},
    DayOfWeek.saturday: {'en': 'Sat', 'jp': '土'},
    DayOfWeek.sunday: {'en': 'Sun', 'jp': '日'},
  };

  String name(String languageCode) {
    return names[this]?[languageCode] ?? '';
  }

  static DayOfWeek fromDateTime(DateTime dateTime) {
    return DayOfWeek.values[dateTime.weekday - 1];
  }

  static List<DayOfWeek> getWeekDays(bool startMonday) {
    if (startMonday) {
      return [
        DayOfWeek.monday,
        DayOfWeek.tuesday,
        DayOfWeek.wednesday,
        DayOfWeek.thursday,
        DayOfWeek.friday,
        DayOfWeek.saturday,
        DayOfWeek.sunday,
      ];
    } else {
      return [
        DayOfWeek.sunday,
        DayOfWeek.monday,
        DayOfWeek.tuesday,
        DayOfWeek.wednesday,
        DayOfWeek.thursday,
        DayOfWeek.friday,
        DayOfWeek.saturday,
      ];
    }
  }
}

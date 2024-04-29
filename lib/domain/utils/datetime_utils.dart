extension DateTimeExtensions on DateTime {
  DateTime get mondayThisWeek {
    return DateTime(year, month, day - weekday + 1);
  }

  DateTime get sundayThisWeek {
    return DateTime(year, month, day + (7 - weekday));
  }

  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }

  DateTime addWeeks(int weeks) {
    return add(Duration(days: 7 * weeks));
  }

  DateTime subtractWeeks(int weeks) {
    return subtract(Duration(days: 7 * weeks));
  }

  DateTime addMonths(int months) {
    int newMonth = month + months;
    int newYear = year;
    while (newMonth > 12) {
      newMonth -= 12;
      newYear += 1;
    }
    while (newMonth < 1) {
      newMonth += 12;
      newYear -= 1;
    }

    int day = this.day;
    int maxDay = DateTime(newYear, newMonth + 1, 0).day;
    if (day > maxDay) {
      day = maxDay;
    }
    return DateTime(newYear, newMonth, day);
  }

  DateTime subtractMonths(int months) {
    return addMonths(-months);
  }
}

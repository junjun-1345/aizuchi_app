class CustomDateTime {
  final _now = DateTime.now();

  nowDate() {
    return DateTime(_now.year, _now.month, _now.day).toString();
  }
}

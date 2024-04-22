import 'package:aizuchi_app/domain/entity/models/daily.dart';

abstract class DailyUsecases {
  Future<void> create(DailyEntity daily);
  Future<void> update(DailyEntity daily);
  Future<List<DailyEntity>> readMonthly({DateTime? endDate});
  Future<List<DailyEntity>> readMonth(int year, int month);
  Future<List<DailyEntity>> readWeek({DateTime? endDate});
  DateTime parseDate(String dateString);
}

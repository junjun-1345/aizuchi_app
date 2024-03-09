import 'package:aizuchi_app/domain/entity/models/daily.dart';

abstract class DailyUsecases {
  Future<void> create(DailyEntity daily);
  Future<void> update(DailyEntity daily);
  Future<List<DailyEntity>> readMonth();
  Future<List<DailyEntity>> readWeek();
  DateTime parseDate(String dateString);
}

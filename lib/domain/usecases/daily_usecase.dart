import 'package:aizuchi_app/domain/entity/models/daily.dart';

abstract class DailyUsecases {
  Future<void> create(DailyEntity daily);
  Future<void> update(DailyEntity daily);
  Future<List<DailyEntity>> readMonth({DateTime? endDate});
  Future<List<DailyEntity>> readWeek({DateTime? endDate});
  DateTime parseDate(String dateString);
}

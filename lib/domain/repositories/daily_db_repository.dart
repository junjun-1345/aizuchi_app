import 'package:aizuchi_app/domain/entity/models/daily.dart';

abstract class DailyDBRepository {
  Future<void> create(DailyEntity daily);
  Future<void> updateLatest(DailyEntity daily);
  Future<List<DailyEntity>> readAll();
  Future<List<DailyEntity>> read(DateTime startDate, DateTime endDate);
}

import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/mock/daily_mock.dart';

abstract class DailyDBRepository {
  Future<void> create(DailyEntity daily);
  Future<void> updateLatest(DailyEntity daily);
  //FIXME: モック
  Future<List<DailyEntity>> readAll() async {
    return Future.value(DailyMock.monthlyRandom);
  }
  // 本番用
  // Future<List<DailyEntity>> readAll();

  Future<List<DailyEntity>> read(DateTime startDay, DateTime endDay);
}

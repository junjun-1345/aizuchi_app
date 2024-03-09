import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/daily_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/daily_usecase.dart';

class DailyInteractor implements DailyUsecases {
  final DailyDBRepository dailyRepository;
  final UserDBRepository userRepository;

  DailyInteractor(this.dailyRepository, this.userRepository);

  @override
  Future<void> create(DailyEntity daily) {
    return dailyRepository.create(daily);
  }

  @override
  Future<List<DailyEntity>> readMonth() async {
    final UserEntity user = await userRepository.read();
    final DateTime startDay = parseDate(user.dailyKey);
    final DateTime endDay = DateTime(startDay.year, startDay.month + 1, 0);
    return dailyRepository.read(startDay, endDay);
  }

  @override
  Future<List<DailyEntity>> readWeek() async {
    final UserEntity user = await userRepository.read();
    final DateTime startDay = parseDate(user.dailyKey);
    final DateTime endDay = startDay.add(const Duration(days: -7));
    return dailyRepository.read(startDay, endDay);
  }

  @override
  Future<void> update(DailyEntity daily) {
    return dailyRepository.updateLatest(daily);
  }

  @override
  DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('_');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}

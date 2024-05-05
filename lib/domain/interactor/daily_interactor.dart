import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/daily_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/daily_usecase.dart';

class DailyInteractor implements DailyUsecase {
  final DailyDBRepository dailyRepository;
  final UserDBRepository userRepository;

  DailyInteractor(this.dailyRepository, this.userRepository);

  @override
  Future<void> create(DailyEntity daily) {
    return dailyRepository.create(daily);
  }

  @override
  Future<List<DailyEntity>> readHalfYearly(DateTime endDate) async {
    final DateTime endDay = endDate;
    final DateTime startDay =
        DateTime(endDay.year, endDay.month - 6, endDay.day);

    return dailyRepository.read(startDay, endDay);
  }

  @override
  Future<List<DailyEntity>> readMonthly(DateTime endDate) async {
    final DateTime endDay = endDate;
    final DateTime startDay =
        DateTime(endDay.year, endDay.month - 1, endDay.day);

    return dailyRepository.read(startDay, endDay);
  }

  @override
  Future<List<DailyEntity>> readMonth(int year, int month) async {
    final DateTime endDay = DateTime(year, month + 1, 0);
    final DateTime startDay = DateTime(year, month, 1);
    return dailyRepository.read(startDay, endDay);
  }

  @override
  Future<List<DailyEntity>> readWeek({DateTime? endDate}) async {
    final UserEntity user = await userRepository.read();
    final DateTime endDay = endDate ?? parseDate(user.dailyKey);
    final DateTime startDay = endDay.add(const Duration(days: -7));
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

  @override
  List<DailyEntity> filterDailiesByDateRange(
      List<DailyEntity> dailies, DateTime startDate, DateTime endDate) {
    return dailies.where((daily) {
      return daily.createdAt
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
          daily.createdAt.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }
}

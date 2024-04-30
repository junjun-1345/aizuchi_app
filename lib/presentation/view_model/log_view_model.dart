import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/usecases/daily_usecase.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final logViewModelProvider = Provider<LogViewModel>(
  (ref) => LogViewModel(
    ref,
    ref.read(dailyNotifierProvider.notifier),
    ref.read(dailyUsecaseProvider),
    ref.read(oldestUpdateDateProvider.notifier),
  ),
);

class LogViewModel {
  final Ref ref;
  final DailyNotifier dailyNotifier;
  final DailyUsecases dailyUsecases;
  final OldestUpdateDateNotifier oldestUpdateDateNotifier;

  LogViewModel(
    this.ref,
    this.dailyNotifier,
    this.dailyUsecases,
    this.oldestUpdateDateNotifier,
  );

  Future<void> addDailyState(
    DateTime endDate,
    DateTime startDate,
    DateTime oldestUpdateDate,
  ) async {
    // startDateがoldestUpdateDateよりも古い場合、値を更新
    if (startDate.isBefore(oldestUpdateDate)) {
      await dailyNotifier.addMonthlyDaily(endDate);
      oldestUpdateDateNotifier.updateOldestUpdateDate(startDate);
    }
    return;
  }

  List<DailyModel> filterDailiesByDateRange(
    List<DailyModel> dailyList,
    DateTime startDate,
    DateTime endDate,
  ) {
    List<DailyEntity> entityList = [];
    entityList = dailyList.map((entity) {
      return entity.toEntity();
    }).toList();
    return dailyUsecases
        .filterDailiesByDateRange(entityList, startDate, endDate)
        .map((entity) => DailyModel.fromEntity(entity))
        .toList();
  }
}

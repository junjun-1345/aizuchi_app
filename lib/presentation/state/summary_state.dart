// import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/usecases/daily_usecase.dart';
import 'package:aizuchi_app/mock/daily_mock.dart';
import 'package:aizuchi_app/presentation/model/summary_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final summaryNotifierProvider =
    StateNotifierProvider<SummaryNotifier, AsyncValue<List<SummaryModel>>>(
  (ref) {
    return SummaryNotifier(
      ref,
      // ref.watch(dailyUsecaseProvider),

      // Mock
      FakeDailyUsecases(),
    );
  },
);

class SummaryNotifier extends StateNotifier<AsyncValue<List<SummaryModel>>> {
  SummaryNotifier(this.ref, this._dailyUsecase)
      : super(const AsyncValue.loading()) {
    initialize();
  }

  final Ref ref;
  final DailyUsecases _dailyUsecase;

  void initialize() async {
    final List<DailyEntity> dailiesEntity = await _dailyUsecase.readWeek();
    final List<SummaryModel> summaries =
        dailiesEntity.map((daily) => SummaryModel.fromEntity(daily)).toList();
    state = AsyncValue.data(summaries);
  }

  Future<void> getWeeklySummary(DateTime endDate) async {
    final List<DailyEntity> dailiesEntity =
        await _dailyUsecase.readWeek(endDate: endDate);
    final List<SummaryModel> summaries =
        dailiesEntity.map((daily) => SummaryModel.fromEntity(daily)).toList();
    state = AsyncValue.data(summaries);
  }
}

import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/usecases/daily_usecase.dart';
import 'package:aizuchi_app/mock/daily_mock.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyNotifierProvider =
    StateNotifierProvider<DailyNotifier, AsyncValue<List<DailyModel>>>(
  (ref) {
    // 環境やフラグに基づいて FakeDailyUsecases か実際の dailyUsecaseProvider を選択
    // final usecase = ref.watch(dailyUsecaseProvider);
    // 開発やテストのために FakeDailyUsecases を使用
    final usecase = FakeDailyUsecases();

    return DailyNotifier(ref, usecase);
  },
);

class DailyNotifier extends StateNotifier<AsyncValue<List<DailyModel>>> {
  DailyNotifier(this.ref, this._dailyUsecase)
      : super(const AsyncValue.loading()) {
    initialize();
  }

  final Ref ref;
  final DailyUsecases _dailyUsecase;

  void initialize() async {
    final List<DailyEntity> dailiesEntity = await _dailyUsecase.readMonth();
    final List<DailyModel> dailies =
        dailiesEntity.map((daily) => DailyModel.fromEntity(daily)).toList();
    print("daily初期化");
    state = AsyncValue.data(dailies);
  }

  Future<void> saveEmotion() async {
    final EmotionType emotion = ref.read(emotionProvider);
    final String key = ref.read(usersNotifierProvider).asData!.value.dailyKey;
    final DailyModel newDaily = DailyModel(
      createdAt: _dailyUsecase.parseDate(key),
      emotion: emotion,
      summary: "",
    );
    await _dailyUsecase.create(newDaily.toEntity());
    state = AsyncValue.data([...?state.value, newDaily]);
  }

  Future<void> saveSummary(String summary) async {
    state.whenData((dailies) async {
      final latestDaily = dailies.last;
      final updatedDaily = latestDaily.copyWith(summary: summary);
      await _dailyUsecase.update(updatedDaily.toEntity());
      final newList = List<DailyModel>.from(dailies)
        ..removeLast()
        ..add(updatedDaily);
      // 更新されたリストで状態を更新
      state = AsyncValue.data(newList);
    });
  }
}

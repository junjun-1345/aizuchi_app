import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emotionProvider = StateProvider<EmotionType>((_) => EmotionType.neutral);

final errorProvider = StateProvider<String>((_) => "");

final passwordProvider = StateProvider<String>((_) => "");

final oldestUpdateDateProvider =
    StateNotifierProvider<OldestUpdateDateNotifier, DateTime>((ref) {
  return OldestUpdateDateNotifier();
});

final isWaitngProvider = StateNotifierProvider<IsWaitngNotifier, bool>((ref) {
  return IsWaitngNotifier();
});

class IsWaitngNotifier extends StateNotifier<bool> {
  IsWaitngNotifier() : super(false);

  void startWaiting() {
    state = true;
  }

  void stopWaiting() {
    state = false;
  }
}

class OldestUpdateDateNotifier extends StateNotifier<DateTime> {
  OldestUpdateDateNotifier()
      : super(DateTime(
            DateTime.now().year, DateTime.now().month - 6, DateTime.now().day));

  // 初期値をdaily initializeの日付に設定
  void updateOldestUpdateDate(DateTime date) {
    state = date;
  }
}

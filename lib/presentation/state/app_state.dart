import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emotionProvider = StateProvider<EmotionType>((_) => EmotionType.neutral);

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

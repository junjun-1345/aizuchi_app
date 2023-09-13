import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'waitng.g.dart';

@riverpod
class WaitngNotifier extends _$WaitngNotifier {
  @override
  bool build() {
    // 最初のデータ
    return false;
  }

  // データを変更する関数
  void falseState() {
    state = false;
  }

  void trueState() {
    state = true;
  }
}

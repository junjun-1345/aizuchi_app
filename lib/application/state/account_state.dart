import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_state.g.dart';

// アカウントのログイン状態を保持
// redirectの参照先
@riverpod
class AccountStateNotifier extends _$AccountStateNotifier {
  @override
  bool build() {
    return false;
  }

  void changeFalse() {
    state = false;
  }

  void changeTrue() {
    state = true;
  }
}

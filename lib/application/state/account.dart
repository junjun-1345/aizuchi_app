import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account.g.dart';

// アカウントのログイン状態を保持
// redirectの参照先
@riverpod
class AccountNotifier extends _$AccountNotifier {
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

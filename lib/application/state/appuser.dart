import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appuser.g.dart';

@riverpod
class AppUserNotifier extends _$AppUserNotifier {
  @override
  AppUser build() {
    // 最初のデータ
    return const AppUser(
        name: null,
        sex: null,
        birhtDay: null,
        id: null,
        billing: null,
        activeDay: null,
        registerDay: null,
        wordIndex: null,
        timer: null);
  }

  void update(AppUser appUser) {
    state = appUser;
  }
}

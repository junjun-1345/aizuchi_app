import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appuser.g.dart';

@Riverpod(keepAlive: true)
class AppUserNotifier extends _$AppUserNotifier {
  @override
  AppUser build() {
    // 最初のデータ
    return const AppUser();
  }

  void update(AppUser appUser) {
    state = appUser;
  }
}

import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userViewModelProvider = Provider<UserViewModel>(
  (ref) => UserViewModel(
    ref,
    ref.read(usersNotifierProvider.notifier),
  ),
);

class UserViewModel {
  final Ref ref;
  final UsersNotifier usersNotifier;

  UserViewModel(
    this.ref,
    this.usersNotifier,
  );

  Future<void> signUpWith({
    required PlatformType platform,
    required Function onSuccess,
  }) async {
    try {
      await usersNotifier.signUpWith(platform);
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      return;
    }
    onSuccess();
  }

  Future<void> signInWith({
    required PlatformType platform,
    required Function onSuccess,
  }) async {
    try {
      await usersNotifier.signInWith(platform);
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      return;
    }
    onSuccess();
  }

  Future<void> signOut() async {
    usersNotifier.signOut();
  }

  Future<void> register() async {
    usersNotifier.register();
  }
}

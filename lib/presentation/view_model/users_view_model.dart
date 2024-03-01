import 'package:aizuchi_app/domain/entity/enums/platform.dart';
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

  Future<bool> signUpWith(PlatformType platform) async {
    return usersNotifier.signUpWith(platform);
  }

  Future<bool> signInWith(PlatformType platform) async {
    return usersNotifier.signInWith(platform);
  }

  Future<void> signOut() async {
    usersNotifier.signOut();
  }

  Future<void> register() async {
    usersNotifier.register();
  }
}

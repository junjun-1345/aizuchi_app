import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/presentation/model/user_model.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ///
// /// Provider
final usersNotifierProvider =
    StateNotifierProvider.autoDispose<UsersNotifier, AsyncValue<UserModel>>(
  (ref) {
    return UsersNotifier(ref, ref.watch(usersUsecaseProvider));
  },
);

///
/// State
class UsersNotifier extends StateNotifier<AsyncValue<UserModel>> {
  UsersNotifier(this.ref, this._usersUseCase)
      : super(const AsyncValue.loading()) {
    initialize();
  }

  final Ref ref;
  final UsersUsecase _usersUseCase;

  void initialize() async {
    try {
      final UserEntity? entity = await _usersUseCase.read();
      if (entity == null) throw 'ログインしてください。';
      final UserModel user = UserModel.fromEntity(entity);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signUpWith(PlatformType platform) async {
    final UserModel form = ref.read(userProvider);
    final String password = ref.read(passwordProvider);
    await _usersUseCase.signUpWith(platform, password, form.toEntity());
  }

  Future<void> signInWith(PlatformType platform) async {
    final UserModel form = ref.read(userProvider);
    final String password = ref.read(passwordProvider);
    await _usersUseCase.signInWith(platform, password, form.toEntity());
  }

  void signOut() async {
    await _usersUseCase.signOut();
  }

  Future<void> register() async {
    final UserModel form = ref.read(userProvider);
    await _usersUseCase.register(form.toEntity());
  }

  Future<void> isConversationStart() async {
    final newDailyKey = await _usersUseCase.isConversationStart();
    state.whenData(
      (user) {
        final UserModel updatedUser =
            user.copyWith(isConversation: true, dailyKey: newDailyKey);
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  Future<void> isConversationEnd() async {
    await _usersUseCase.update(isConversation: false);
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isConversation: false);
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  Future<void> isMessageOverLimitReset() async {
    await _usersUseCase.update(isMessageOverLimit: false);
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isMessageOverLimit: false);
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  Future<void> messageOverLimit() async {
    await _usersUseCase.update(isMessageOverLimit: true);
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isMessageOverLimit: true);
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  Future<int> getMessageLimit() async {
    final int limit = await _usersUseCase.getMessageLimit();
    return limit;
  }

  // void isSubscriptionUpdate() {
  //   final isSubscription = ref.read(userIsSubscriptionProvider);
  //   state.whenData(
  //     (user) {
  //       final UserModel updatedUser =
  //           user.copyWith(isSubscription: isSubscription);
  //       _usersUseCase.update(isSubscription: isSubscription);

  //       state = AsyncValue.data(updatedUser);
  //     },
  //   );
  // }
}

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
    final UserEntity entity = await _usersUseCase.read();
    final UserModel user = UserModel.fromEntity(entity);
    state = AsyncValue.data(user);
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

  void register() async {
    final UserModel form = ref.read(userProvider);
    final UserEntity entity = await _usersUseCase.register(form.toEntity());
    final UserModel user = UserModel.fromEntity(entity);
    state = AsyncValue.data(user);
  }

  void createDailyKey() {
    final String newDailyKey = _usersUseCase.createKey();
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(dailyKey: newDailyKey);
        _usersUseCase.update(updatedUser.toEntity());
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  void isConversationStart() {
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isConversation: true);
        _usersUseCase.update(updatedUser.toEntity());
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  void isConversationEnd() {
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isConversation: false);
        _usersUseCase.update(updatedUser.toEntity());
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  void isMessageOverLimitReset() {
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isMessageOverLimit: false);
        _usersUseCase.update(updatedUser.toEntity());
        state = AsyncValue.data(updatedUser);
      },
    );
  }

  void messageOverLimit() {
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(isMessageOverLimit: true);
        _usersUseCase.update(updatedUser.toEntity());
        state = AsyncValue.data(updatedUser);
      },
    );
  }
}

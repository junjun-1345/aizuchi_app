import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/presentation/model/user_model.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ///
// /// Provider
final usersNotifierProvider =
    StateNotifierProvider<UsersNotifier, AsyncValue<UserModel>>(
  (ref) {
    return UsersNotifier(ref, ref.watch(usersUsecaseProvider))..initialize();
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
    print(state.asData?.value.dailyKey);
  }

  Future<bool> signUpWith(PlatformType platform) async {
    final UserModel form = ref.read(userProvider);
    final String password = ref.read(passwordProvider);
    final bool result =
        await _usersUseCase.signUpWith(platform, password, form.toEntity());
    return result;
  }

  Future<bool> signInWith(PlatformType platform) async {
    final UserModel form = ref.read(userProvider);
    final String password = ref.read(passwordProvider);
    final bool result =
        await _usersUseCase.signInWith(platform, password, form.toEntity());

    return result;
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
    print("キー作成");
    state.whenData(
      (user) {
        final UserModel updatedUser = user.copyWith(dailyKey: newDailyKey);
        _usersUseCase.update(updatedUser.toEntity());
        state = AsyncValue.data(updatedUser);
        print("キー作成完了");
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
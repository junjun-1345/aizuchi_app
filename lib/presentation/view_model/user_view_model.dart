import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enum/character.dart';
import 'package:aizuchi_app/domain/entity/enum/platform.dart';
import 'package:aizuchi_app/domain/entity/enum/sex.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/presentation/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userIdProvider = StateProvider<String>((_) => "");
final userNameProvider = StateProvider<String>((_) => "");
final userEmailProvider = StateProvider<String>((_) => "");
final userBirthdayProvider = StateProvider<DateTime>((_) => DateTime.now());
final userSexProvider = StateProvider<SexEnum>((_) => SexEnum.unknown);
final userBillingProvider = StateProvider<bool>((_) => false);
final userInitProvider = StateProvider<bool>((_) => false);
final userCreatedAtProvider = StateProvider<DateTime>((_) => DateTime.now());
final userActiveDayProvider = StateProvider<int>((_) => 0);
final userCharactorProvider =
    StateProvider<CharactorEnum>((_) => CharactorEnum.unknown);
final passwordProvider = StateProvider<String>((_) => "");
final errorProvider = StateProvider<String?>((_) => "");
final professionProvider = StateProvider<String>((_) => "");

final userProvider = StateProvider<UserModel>((ref) {
  final id = ref.watch(userIdProvider);
  final name = ref.watch(userNameProvider);
  final email = ref.watch(userEmailProvider);
  final birthday = ref.watch(userBirthdayProvider);
  final sex = ref.watch(userSexProvider);
  final billing = ref.watch(userBillingProvider);
  final init = ref.watch(userInitProvider);
  final createdAt = ref.watch(userCreatedAtProvider);
  final activeDay = ref.watch(userActiveDayProvider);
  final charactor = ref.watch(userCharactorProvider);
  final profession = ref.watch(professionProvider);

  return UserModel(
    id: id,
    name: name,
    email: email,
    birthday: birthday,
    sex: sex,
    billing: billing,
    init: init,
    createdAt: createdAt,
    activeDay: activeDay,
    charactor: charactor,
    profession: profession,
  );
});

// ///
// /// Provider
final usersNotifierProvider =
    StateNotifierProvider<UsersNotifier, AsyncValue<UserModel>>(
  (ref) {
    return UsersNotifier(ref, ref.watch(userUsecaseProvider));
  },
);

///
/// State
class UsersNotifier extends StateNotifier<AsyncValue<UserModel>> {
  UsersNotifier(this.ref, this._usersUseCase)
      : super(const AsyncValue<UserModel>.loading());

  final Ref ref;
  final UsersUseCase _usersUseCase;

  Future<void> initialize() async {
    final entity = await _usersUseCase.read();
    final users = UserModel.fromEntity(entity);
    state = AsyncValue.data(users);
  }

  Future<bool> signInWith(PlatformType platform) async {
    final form = ref.watch(userProvider);
    final password = ref.watch(passwordProvider);
    final result =
        await _usersUseCase.signInWith(platform, password, form.toEntity());

    return result ? true : false;
  }

  Future<bool> signUpWith(PlatformType platform) async {
    final form = ref.watch(userProvider);
    final password = ref.watch(passwordProvider);
    final result =
        await _usersUseCase.signUpWith(platform, password, form.toEntity());
    return result ? true : false;
  }

  Future<void> signOut() async {
    await _usersUseCase.signOut();
  }

  Future<void> register() async {
    final form = ref.watch(userProvider);
    final result = await _usersUseCase.register(form.toEntity());
    state = AsyncValue.data(UserModel.fromEntity(result));
  }
}

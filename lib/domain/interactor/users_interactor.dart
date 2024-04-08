import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:aizuchi_app/domain/repositories/local_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';

class UsersInteractor implements UsersUsecase {
  final AuthRepository authRepository;
  final UserDBRepository userDBRepository;
  final LocalDBRepository localDBRepository;

  UsersInteractor(
      this.userDBRepository, this.authRepository, this.localDBRepository);

  @override
  Future<void> signUpWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    // 既存はfalse 新規はtrue を返す。
    switch (platform) {
      case PlatformType.google:
        await authRepository.signUpWithGoogle();
        break;
      case PlatformType.email:
        await authRepository.signUpWithEmail(password, user);
        break;
      default:
        throw '不正なサインアップ方法です';
    }

    // ユーザーが存在をDBで確認し、存在する場合はサインアウトする。
    try {
      await userDBRepository.read();
    } catch (e) {
      localDBRepository.setIsSignUpTrue();
      return;
    }
    authRepository.signOut();
    throw 'ユーザーが存在します。';
  }

  @override
  Future<void> signInWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    switch (platform) {
      case PlatformType.google:
        await authRepository.signInWithGoogle();
        break;
      case PlatformType.email:
        await authRepository.signInWithEmail(password, user);
        break;
      default:
        throw '不正なログイン方法です';
    }

    // ユーザーが存在をDBで確認し、存在しない場合はサインアウトする。
    try {
      await userDBRepository.read();
    } catch (e) {
      authRepository.signOut();
      throw 'ユーザーが存在しません。';
    }
  }

  @override
  void update(UserEntity user) {
    userDBRepository.update(user);
  }

  @override
  Future<void> signOut() {
    localDBRepository.setIsSignUpFalse();
    return authRepository.signOut();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> read() {
    return userDBRepository.read();
  }

  @override
  Future<UserEntity> register(UserEntity form) async {
    final user = UserEntity(
      id: "",
      name: form.name,
      email: "",
      birthday: form.birthday,
      sex: form.sex,
      isSubscription: false,
      init: true,
      createdAt: DateTime.now(),
      activeDay: 0,
      charactor: CharactorEnum.mouhu,
      profession: form.profession,
      dailyKey: "",
      isConversation: false,
      isAssistant: true,
      isMessageOverLimit: false,
    );

    userDBRepository.create(user);
    localDBRepository.setIsSignUpFalse();
    return user;
  }

  @override
  String createKey() {
    final DateTime now = DateTime.now();
    final String key = "${now.year}_${now.month}_${now.day}";
    return key;
  }
}

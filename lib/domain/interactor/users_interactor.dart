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
  Future<bool> signUpWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    // 既存はfalse 新規はtrue を返す。
    if (platform == PlatformType.google) {
      if (await authRepository.signUpWithGoogle()) {
        localDBRepository.setIsSignUpTrue();
        return true;
      } else {
        authRepository.signOut();
        return false;
      }
    } else if (platform == PlatformType.email) {
      if (await authRepository.signUpWithEmail(password, user)) {
        localDBRepository.setIsSignUpTrue();
        return true;
      } else {
        authRepository.signOut();
        return false;
      }
    } else {
      throw Exception('不正なサインアップ方法です');
    }
  }

  // trueで次のフローへ
  @override
  Future<bool> signInWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    // 一度サインインしてIDをもらう
    if (platform == PlatformType.google) {
      await authRepository.signInWithGoogle();
    } else if (platform == PlatformType.email) {
      await authRepository.signInWithEmail(password, user);
    } else {
      throw Exception('不正なログイン方法です');
    }
    // ユーザー情報あるか確認
    try {
      await userDBRepository.read();
      return true;
    } catch (e) {
      //FIXME: print消す
      // print("ユーザー情報がありません");
      return false;
    }
  }

  @override
  void update(UserEntity user) {
    userDBRepository.update(user);
  }

  @override
  Future<void> signOut() {
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
      billing: false,
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

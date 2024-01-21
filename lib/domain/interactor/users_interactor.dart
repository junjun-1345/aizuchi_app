import 'package:aizuchi_app/domain/entity/enum/character.dart';
import 'package:aizuchi_app/domain/entity/enum/platform.dart';
import 'package:aizuchi_app/domain/entity/model/user.dart';
import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:aizuchi_app/domain/repositories/local_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';

class UsersInteractor implements UsersUseCase {
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
      print("ユーザー情報がありません");
      return false;
    }
  }

  @override
  Future<UserEntity> update(UserEntity user) {
    // TODO: implement update
    throw UnimplementedError();
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
    );

    userDBRepository.create(user);

    localDBRepository.setIsSignUpFalse();
    return user;
  }
}

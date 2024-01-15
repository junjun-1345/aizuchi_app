import 'package:aizuchi_app/domain/entity/enum/character.dart';
import 'package:aizuchi_app/domain/entity/enum/platform.dart';
import 'package:aizuchi_app/domain/entity/model/user.dart';
import 'package:aizuchi_app/domain/repositories/users_repository.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';

class UsersInteractor implements UsersUseCase {
  final UsersRepository repository;

  UsersInteractor(this.repository);

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> read() {
    return repository.read();
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
      await repository.signInWithGoogle();
    } else if (platform == PlatformType.email) {
      await repository.signInWithEmail(password, user);
    } else {
      throw Exception('不正なログイン方法です');
    }
    // ユーザー情報あるか確認
    try {
      await repository.read();
      return true;
    } catch (e) {
      print("ユーザー情報がありません");
      return false;
    }
  }

  // trueで次のフローへ
  @override
  Future<bool> signUpWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    // 一度サインインしてIDをもらう
    if (platform == PlatformType.google) {
      await repository.signUpWithGoogle();
    } else if (platform == PlatformType.email) {
      await repository.signUpWithEmail(password, user);
    } else {
      throw Exception('不正なサインアップ方法です');
    }
    // ユーザー情報あるか確認
    try {
      await repository.read();
      return false;
    } catch (e) {
      print("ユーザー情報がありません");
      return true;
    }
  }

  @override
  Future<UserEntity> update(UserEntity user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    return repository.signOut();
  }

  @override
  Future<UserEntity> register(UserEntity form) async {
    if (repository.readCurrentUser()[0] == "null") {
      throw Exception("id情報がありません");
    }
    if (repository.readCurrentUser()[1] == "null") {
      throw Exception("email情報がありません");
    }
    final user = UserEntity(
      id: repository.readCurrentUser()[0],
      name: form.name,
      email: repository.readCurrentUser()[1],
      birthday: form.birthday,
      sex: form.sex,
      billing: false,
      init: true,
      createdAt: DateTime.now(),
      activeDay: 0,
      charactor: CharactorEnum.mouhu,
      profession: form.profession,
    );

    repository.create(user);
    return user;
  }
}

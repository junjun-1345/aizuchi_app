import 'package:aizuchi_app/domain/entity/enum/platform.dart';
import 'package:aizuchi_app/domain/entity/model/user.dart';

abstract class UsersUseCase {
  Future<bool> signUpWith(
    PlatformType platform,
    String password,
    UserEntity user,
  );
  Future<bool> signInWith(
    PlatformType platform,
    String password,
    UserEntity user,
  );
  Future<void> signOut();
  Future<UserEntity> register(UserEntity user);
  Future<void> delete(String id);
  Future<UserEntity> read();
  Future<void> update(UserEntity user);
}

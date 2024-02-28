import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';

abstract class UsersUsecase {
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
  void update(UserEntity user);
  String createKey();
}

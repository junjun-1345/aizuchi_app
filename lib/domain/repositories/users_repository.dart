import 'package:aizuchi_app/domain/entity/model/user.dart';

abstract class UsersRepository {
  Future<String?> signInWithEmail(
    String password,
    UserEntity user,
  );
  Future<String?> signInWithGoogle();
  Future<String?> signUpWithEmail(
    String password,
    UserEntity user,
  );
  Future<String?> signUpWithGoogle();
  List<String> readCurrentUser();
  Future<void> signOut();

  Future<void> create(UserEntity form);
  Future<UserEntity> read();
  Future<void> delete();
  Future<void> update(UserEntity form);
}

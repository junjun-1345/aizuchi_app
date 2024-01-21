import 'package:aizuchi_app/domain/entity/model/user.dart';

abstract class AuthRepository {
  Future<bool> signUpWithEmail(
    String password,
    UserEntity user,
  );
  Future<bool> signUpWithGoogle();
  Future<bool> signInWithEmail(
    String password,
    UserEntity user,
  );
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  Future<void> accountDalete();
}

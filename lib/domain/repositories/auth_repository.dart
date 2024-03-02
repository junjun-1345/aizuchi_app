import 'package:aizuchi_app/domain/entity/models/user.dart';

abstract class AuthRepository {
  Future<void> signUpWithEmail(
    String password,
    UserEntity user,
  );
  Future<void> signUpWithGoogle();
  Future<void> signInWithEmail(
    String password,
    UserEntity user,
  );
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> accountDalete();
}

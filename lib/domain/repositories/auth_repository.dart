import 'package:aizuchi_app/domain/entity/models/user.dart';

abstract class AuthRepository {
  Future<void> signUpWithEmail(
    String password,
    UserEntity user,
  );
  Future<void> signUpWithGoogle();
  Future<void> signUpWithApple();
  Future<void> signInWithEmail(
    String password,
    UserEntity user,
  );
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signOut();
  Future<void> accountDalete();
  Future<String?> readEmail();
  Future<void> updateEmail(String email);
  Future<void> updatePassword(String email);
}

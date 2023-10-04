import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthInterface {
  Future<UserCredential> signInWithGoogle();

  Future<void> signUpWithPassword(String emailAddress, String password);

  Future<void> signInWithPassword(String emailAddress, String password);

  Future<void> signOut();
}

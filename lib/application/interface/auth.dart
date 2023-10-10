import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthInterface {
  Future<UserCredential> signInWithGoogle();

  Future<void> signOutWithGoogle();
}

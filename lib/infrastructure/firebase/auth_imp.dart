import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../application/interface/firebase/auth.dart';

class AuthService implements AuthInterface {
  /// サインイン
  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUer = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUer!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signUpWithPassword(String emailAddress, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }

  @override
  Future<void> signInWithPassword(String emailAddress, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
  }

  /// サインアウト
  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // サインインの情報をチェック
}

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

  /// サインアウト
  @override
  Future<void> signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
  }

  // サインインの情報をチェック
}

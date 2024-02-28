import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> signUpWithEmail(String password, UserEntity user) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      if (userCredential.additionalUserInfo!.isNewUser) {
        //新規ユーザーの場合の処理
        return true;
      } else {
        //既存ユーザーの場合の処理
        return false;
      }
      // ignore: empty_catches
    } on FirebaseException catch (e) {
      print(e);
    }

    throw Exception('不正なサインアップ方法です');
  }

  @override
  Future<bool> signUpWithGoogle() async {
    try {
      //Google認証フローを起動する
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //リクエストから認証情報を取得する
      final googleAuth = await googleUser?.authentication;
      //firebaseAuthで認証を行う為、credentialを作成
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      //作成したcredentialを元にfirebaseAuthで認証を行う
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        //新規ユーザーの場合の処理
        return true;
      } else {
        //既存ユーザーの場合の処理
        return false;
      }
      // ignore: empty_catches
    } on FirebaseException {}

    throw Exception('不正なサイン方法です');
  }

  @override
  Future<bool> signInWithEmail(String password, UserEntity user) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      if (userCredential.additionalUserInfo!.isNewUser) {
        //新規ユーザーの場合の処理
        return false;
      } else {
        //既存ユーザーの場合の処理
        return true;
      }
      // ignore: empty_catches
    } on FirebaseAuthException {}

    throw Exception('不正なサインイン方法です');
  }

  @override
  Future<bool> signInWithGoogle() async {
    try {
      //Google認証フローを起動する
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //リクエストから認証情報を取得する
      final googleAuth = await googleUser?.authentication;
      //firebaseAuthで認証を行う為、credentialを作成
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      //作成したcredentialを元にfirebaseAuthで認証を行う
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        //新規ユーザーの場合の処理
        return false;
      } else {
        //既存ユーザーの場合の処理
        return true;
      }
      // ignore: empty_catches
    } on FirebaseException {}

    throw Exception('不正なサインアップ方法です');
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> accountDalete() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }
}

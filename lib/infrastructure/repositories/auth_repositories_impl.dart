import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signUpWithEmail(String password, UserEntity user) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw '指定されたメールアドレスを持つアカウントが既に存在します。\n別のメールアドレスを使用してください。';
        case 'invalid-email':
          throw 'メールアドレスが有効でないため、処理を続行できません。\nメールアドレスを確認してください。';
        case 'operation-not-allowed':
          throw 'メール/パスワードアカウントが有効になっていません。\nFirebase コンソールの Auth タブでこの機能を有効にしてください。';
        case 'weak-password':
          throw 'パスワードが十分に強くありません。\nもっと複雑なパスワードを設定してください。';
        default:
          throw 'エラーが発生しました。もう一度お試しください。';
      }
    } on Exception {
      throw 'エラーが発生しました。もう一度お試しください。';
    }
  }

  @override
  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (!userCredential.additionalUserInfo!.isNewUser) {
        //既存ユーザーの場合の処理
        throw ('すでにユーザーが存在します。');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          throw 'このメールアドレスは既に別の認証方法で使用されています。\nログイン方法を選択してください。\nログイン後、現在の認証情報をアカウントにリンクすることができます。';
        case 'invalid-credential':
          throw '認証情報が無効か、期限切れです。\nもう一度試してみてください。';
        case 'operation-not-allowed':
          throw 'このタイプのアカウントは有効になっていません。\nサポートに連絡してください。';
        case 'user-disabled':
          throw 'このユーザーアカウントは無効にされています。\nサポートに連絡してください。';
        case 'user-not-found':
          throw '提供されたメールアドレスに対応するユーザーが見つかりませんでした。\nメールアドレスが正しいか確認してください。';
        case 'wrong-password':
          throw 'パスワードが間違っているか、\nこのメールアドレスにはパスワードが設定されていません。\nもう一度試してみてください。';
        case 'invalid-verification-code':
          throw '認証の確認コードが無効です。\nコードを確認して再入力してください。';
        case 'invalid-verification-id':
          throw '認証の確認IDが無効です。\nもう一度認証プロセスを開始してください。';
        default:
          throw 'エラーが発生しました。もう一度お試しください。';
      }
    } on Exception {
      throw 'エラーが発生しました。もう一度お試しください。';
    }
  }

  @override
  Future<void> signInWithEmail(String password, UserEntity user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'メールアドレスが無効です。\n正しいメールアドレスを入力してください。';
        case 'user-disabled':
          throw 'このメールアドレスに対応するユーザーは無効にされています。\nサポートに連絡してください。';
        case 'user-not-found':
          throw '提供されたメールアドレスに対応するユーザーが見つかりませんでした。\nメールアドレスが正しいか確認してください。';
        case 'wrong-password':
          throw 'パスワードが間違っています。もう一度試してみてください。';
        default:
          throw 'エラーが発生しました。もう一度お試しください。';
      }
    } on Exception {
      throw 'エラーが発生しました。もう一度お試しください。';
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.additionalUserInfo!.isNewUser) {
        //新規ユーザーの場合の処理
        throw 'ユーザーが存在しません。';
      }
      // ignore: empty_catches
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          throw 'このメールアドレスは既に別の認証方法で使用されています。\nログイン方法を選択してください。\nログイン後、現在の認証情報をアカウントにリンクすることができます。';
        case 'invalid-credential':
          throw '認証情報が無効か、期限切れです。\nもう一度試してみてください。';
        case 'operation-not-allowed':
          throw 'このタイプのアカウントは有効になっていません。\nサポートに連絡してください。';
        case 'user-disabled':
          throw 'このユーザーアカウントは無効にされています。\nサポートに連絡してください。';
        case 'user-not-found':
          throw '提供されたメールアドレスに対応するユーザーが見つかりませんでした。\nメールアドレスが正しいか確認してください。';
        case 'wrong-password':
          throw 'パスワードが間違っているか、\nこのメールアドレスにはパスワードが設定されていません。\nもう一度試してみてください。';
        case 'invalid-verification-code':
          throw '認証の確認コードが無効です。\nコードを確認して再入力してください。';
        case 'invalid-verification-id':
          throw '認証の確認IDが無効です。\nもう一度認証プロセスを開始してください。';
        default:
          throw 'エラーが発生しました。もう一度お試しください。';
      }
    } on Exception {
      throw 'エラーが発生しました。もう一度お試しください。';
    }
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

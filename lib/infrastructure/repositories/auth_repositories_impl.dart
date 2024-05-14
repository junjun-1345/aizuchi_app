import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:aizuchi_app/infrastructure/enums/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const googleClientId = String.fromEnvironment('googleClientId');
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: googleClientId,
      ).signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
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
  Future<void> signUpWithApple() async {
    print('signUp');

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: googleClientId,
      ).signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
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
  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
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

  @override
  Future<void> updateEmail(String email) async {
    if (email == FirebaseAuth.instance.currentUser?.email) {
      throw 'メールアドレスが変更されていません。';
    }
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      // ignore: empty_catches
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw 'このメールアドレスは既に別の認証方法で使用されています。\n他のメールアドレスを使用してください。';
        case 'requires-recent-login':
          throw 'セキュリティ上の理由から、再度ログインしてください。';
        default:
          throw 'エラーが発生しました。もう一度お試しください。';
      }
    } on Exception {
      throw 'エラーが発生しました。もう一度お試しください。';
    }
  }

  @override
  Future<String?> readEmail() async {
    return FirebaseAuth.instance.currentUser?.email;
  }

  @override
  Future<void> updatePassword(String email) {
    try {
      return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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
  Future<List<AuthProviderType>> getCurrentUserProvider() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final List<UserInfo> providerData = user.providerData;
      return providerData.map((userInfo) {
        return AuthProviderExtension.from((userInfo.providerId));
      }).toList();
    } else {
      return [];
    }
  }
}

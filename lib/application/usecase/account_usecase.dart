import 'package:aizuchi_app/application/interface/firebase/auth.dart';
import 'package:aizuchi_app/application/interface/firebase/firestore.dart';
import 'package:aizuchi_app/application/state/account.dart';
import 'package:aizuchi_app/application/state/appuser.dart';
import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:flutter/foundation.dart';

class AccountUsecase {
  AccountUsecase({
    required this.auth,
    required this.firestore,
    required this.googleAuth,
    required this.appUserState,
    required this.appUserNotifier,
    required this.accountState,
    required this.accountNotifier,
  });
  final AuthInterface auth;
  final FirestoreInterface firestore;
  final bool googleAuth;
  final AppUser appUserState;
  final AppUserNotifier appUserNotifier;
  final bool accountState;
  final AccountNotifier accountNotifier;

  // ダイアログを表示
  Future<void> init() async {
    // ログインしていたら
    if (googleAuth) {
      // DBの同期
      await firestore
          .userRead()
          .then((content) => appUserNotifier.update(content));
      // ユーザー状態をtrueに
      accountNotifier.changeTrue();
    } else {
      throw ("googleでログインされていません");
    }
  }

  void signUpValidation() {
    String? flag;
    // サインインさせる
    auth.signInWithGoogle();
    // DBユーザー情報をチェック
    firestore.userRead().then(
      (data) {
        flag = data.id;
        if (flag == null) {
          debugPrint("signUpValidation: サインアップ継続");
          // 登録へ
        } else {
          // サインアウトさせる
          auth.signOutWithGoogle();
          // ダイアログを表示
          // 元のページへ戻る
          debugPrint("signUpValidation: サインアップエラー");
        }
      },
    );
  }

  Future<void> createAccount() async {
    // 入力用ステートを取得
    // DBに登録
    print("ユースケースステート$appUserState");
    // ユーザー状態をtrueに
    accountNotifier.changeTrue();
    await firestore.userCreate(appUserState);
    // DBの同期
  }

  void deleteAccount() {
    // アカウントの削除
    firestore.userDelete();
    auth.signOutWithGoogle();
    accountNotifier.changeFalse();
  }

  void signInValidation() {
    String? flag;
    // サインインさせる
    auth.signInWithGoogle();
    // DBユーザー情報をチェック
    firestore.userRead().then(
      (data) {
        flag = data.id;
        if (flag != null) {
          // DBの同期
          firestore
              .userRead()
              .then((content) => appUserNotifier.update(content));
          // ユーザー状態をtrueに
          accountNotifier.changeTrue();
          debugPrint("signInValidation: サインイン完了");
        } else {
          // サインアウトさせる
          auth.signOutWithGoogle();
          // ダイアログを表示
          // 元のページへ戻る
          debugPrint("signInValidation: サインインエラー");
        }
      },
    );
  }

  void signOut() {
    // サインアウトさせる
    auth.signOutWithGoogle();
    // ユーザー状態をfalseに
    accountNotifier.changeFalse();
  }
}

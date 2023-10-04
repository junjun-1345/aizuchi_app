import 'package:aizuchi_app/application/interface/firebase/auth.dart';
import 'package:aizuchi_app/application/interface/firebase/firestore.dart';
import 'package:aizuchi_app/application/state/account_state.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountUsecase {
  AccountUsecase({
    required this.auth,
    required this.firestore,
    required this.googleAuth,
    required this.appUserState,
    required this.accountState,
    required this.accountStateNotifier,
  });
  final AuthInterface auth;
  final FirestoreInterface firestore;
  final bool googleAuth;
  final AppUser appUserState;
  final bool accountState;
  final AccountStateNotifier accountStateNotifier;

  Future<void> signUpEmailValidation({
    required String emailAddress,
    required String password,
    required void Function(String e) onError,
    required void Function() onSuccess,
  }) async {
    try {
      await auth.signUpWithPassword(emailAddress, password);
      return onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return onError("パスワードが弱すぎます");
      } else if (e.code == 'email-already-in-use') {
        return onError("既に登録されているメールアドレスです。");
      }
    } catch (e) {
      return onError(e.toString());
    }
  }

  Future<void> signUpGoogleValidation({
    required void Function(String e) onError,
    required void Function() onSuccess,
  }) async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      return onError(e.toString());
    }
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    print("ID:$id");
    final _flag = await firestore.userFind();
    print("FLAG:$_flag");
    if (!_flag) {
      return onSuccess();
    } else {
      auth.signOut();
      return onError("既に登録されています");
    }
  }

  Future<void> signInEmailValidation({
    required String emailAddress,
    required String password,
    required void Function(String e) onError,
    required void Function() onSuccess,
  }) async {
    try {
      await auth.signInWithPassword(emailAddress, password);
      return onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return onError("ユーザーが存在しません。");
      } else if (e.code == 'wrong-password') {
        return onError("パスワードが間違っています。");
      }
    } catch (e) {
      return onError(e.toString());
    }
  }

  Future<void> signInGoogleValidation({
    required void Function(String e) onError,
    required void Function() onSuccess,
  }) async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      return onError(e.toString());
    }
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    print("ID:$id");
    final _flag = await firestore.userFind();
    print("FLAG:$_flag");
    if (_flag) {
      return onSuccess();
    } else {
      auth.signOut();
      return onError("まだ登録がされていません");
    }
  }

  Future<void> createAccount(String name, int sex, String birthDay) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    final registerDay = CustomDateTime().nowDate();
    final newUser = AppUser(
      id: id,
      email: email,
      name: name,
      sex: sex,
      birhtDay: birthDay,
      registerDay: registerDay,
    );
    await firestore.userCreate(newUser);
    // DBの同期
  }

  void deleteAccount() {
    // アカウントの削除
    firestore.userDelete();
    // auth.signOutWithGoogle();
    accountStateNotifier.changeFalse();
  }

  void signInValidation({
    required void Function() errorDialog,
  }) {
    String? flag;
    // サインインさせる
    auth.signInWithGoogle();
    // DBユーザー情報をチェック
    firestore.userRead().then(
      (data) {
        flag = data.id;
        if (flag != null) {
          // ユーザー状態をtrueに
          accountStateNotifier.changeTrue();
          debugPrint("signInValidation: サインイン完了");
        } else {
          // サインアウトさせる
          // auth.signOutWithGoogle();
          // ダイアログを表示
          // 元のページへ戻る
          errorDialog();
          debugPrint("signInValidation: サインインエラー");
        }
      },
    );
  }

  void signOut() {
    // サインアウトさせる
    auth.signOut();
    // ユーザー状態をfalseに
    accountStateNotifier.changeFalse();
  }
}

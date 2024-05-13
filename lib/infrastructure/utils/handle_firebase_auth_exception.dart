import 'package:firebase_auth/firebase_auth.dart';

String handleFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'account-exists-with-different-credential':
      return 'このメールアドレスは既に別の認証方法で使用されています。ログイン方法を選択してください。ログイン後、現在の認証情報をアカウントにリンクすることができます。';
    case 'invalid-credential':
      return '認証情報が無効か、期限切れです。もう一度試してみてください。';
    case 'operation-not-allowed':
      return 'このタイプのアカウントは有効になっていません。サポートに連絡してください。';
    case 'user-disabled':
      return 'このユーザーアカウントは無効にされています。サポートに連絡してください。';
    case 'user-not-found':
      return '提供されたメールアドレスに対応するユーザーが見つかりませんでした。メールアドレスが正しいか確認してください。';
    case 'wrong-password':
      return 'パスワードが間違っています。もう一度試してみてください。';
    case 'invalid-verification-code':
      return '認証の確認コードが無効です。コードを確認して再入力してください。';
    case 'invalid-verification-id':
      return '認証の確認IDが無効です。もう一度認証プロセスを開始してください。';
    case 'email-already-in-use':
      return '指定されたメールアドレスを持つアカウントが既に存在します。別のメールアドレスを使用してください。';
    case 'invalid-email':
      return 'メールアドレスが有効でないため、処理を続行できません。メールアドレスを確認してください。';
    case 'weak-password':
      return 'パスワードが十分に強くありません。もっと複雑なパスワードを設定してください。';
    default:
      return 'エラーが発生しました。もう一度お試しください。';
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'googleauth_state.g.dart';

//
/// FirebaseのユーザーをAsyncValue型で管理するプロバイダー
///
@Riverpod(keepAlive: true)
Stream<User?> userChanges(UserChangesRef ref) {
  // Firebaseからユーザーの変化を教えてもらう
  return FirebaseAuth.instance.authStateChanges();
}

///
/// ユーザー
///
@Riverpod(keepAlive: true)
String? user(UserRef ref) {
  final userChanges = ref.watch(userChangesProvider);
  print("ユーザーチェンジ発火1${userChanges.asData?.value?.uid}");
  return userChanges.when(
    loading: () => null,
    error: (_, __) => null,
    data: (d) => d?.uid,
  );
}

@Riverpod(keepAlive: true)
bool signedIn(SignedInRef ref) {
  final user = ref.watch(userProvider);
  print("ユーザーチェンジ発火2${user}");
  return user != null;
}

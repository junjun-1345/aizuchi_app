import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'googleauth.g.dart';

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
User? user(UserRef ref) {
  final userChanges = ref.watch(userChangesProvider);
  return userChanges.when(
    loading: () => null,
    error: (_, __) => null,
    data: (d) => d,
  );
}

@Riverpod(keepAlive: true)
bool signedIn(SignedInRef ref) {
  final user = ref.watch(userProvider);
  return user != null;
}

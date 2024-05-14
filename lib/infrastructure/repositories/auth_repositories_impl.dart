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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );
  }

  @override
  Future<void> signUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      clientId: googleClientId,
    ).signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signUpWithApple() async {
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
  }

  @override
  Future<void> signInWithEmail(String password, UserEntity user) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.email,
      password: password,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
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
  }

  @override
  Future<void> signInWithApple() async {
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

    await FirebaseAuth.instance.currentUser?.updateEmail(email);
    // ignore: empty_catches
  }

  @override
  Future<String?> readEmail() async {
    return FirebaseAuth.instance.currentUser?.email;
  }

  @override
  Future<void> updatePassword(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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

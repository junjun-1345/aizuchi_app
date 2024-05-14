import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final isSignIn = FirebaseAuth.instance.currentUser != null;

    if (isSignIn) {
      resolver.next(true);
    } else {
      router.replace(const SignUpRoute());
    }
  }
}

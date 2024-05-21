import 'package:aizuchi_app/infrastructure/enums/shared_preferences_key.dart';
import 'package:aizuchi_app/infrastructure/repositories/shared_preferences_repository_impl.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';

class RegisterGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final sharedPreferencesRepositor = SharedPreferencesRepositorImpl();
    final isRegistering = await sharedPreferencesRepositor
        .fetch<bool>(SharedPreferencesKey.isRegistering);

    if (isRegistering == true) {
      router.replace(const SignUpFormNameRoute());
    } else {
      resolver.next(true);
    }
  }
}

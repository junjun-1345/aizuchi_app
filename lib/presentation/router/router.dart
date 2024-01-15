// import 'package:aizuchi_app/domain/util/logger.dart';
import 'package:aizuchi_app/presentation/view/pages/calendar_page.dart';
import 'package:aizuchi_app/presentation/view/pages/chat_page.dart';
import 'package:aizuchi_app/presentation/view/pages/log_page.dart';
import 'package:aizuchi_app/presentation/view/pages/root_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_birthdate_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_check_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_name_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_sex_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_survey_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_in_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'router.gr.dart';

final appRouterProvider = Provider((ref) => AppRouter(ref));

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter(this.ref);

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/SignIn',
          page: SignInRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/SignUp',
          page: SignUpRoute.page,
        ),
        AutoRoute(
          path: '/Name',
          page: SignUpFormNameRoute.page,
        ),
        AutoRoute(
          path: '/Sex',
          page: SignUpFormSexRoute.page,
        ),
        AutoRoute(
          path: '/BirthDate',
          page: SignUpFormBirthDateRoute.page,
        ),
        AutoRoute(
          path: '/Survey',
          page: SignUpFormSurveyRoute.page,
        ),
        AutoRoute(
          path: '/Check',
          page: SignUpFormCheckRoute.page,
        ),
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            AutoRoute(
              path: 'Start',
              page: StartRoute.page,
            ),
            AutoRoute(
              path: 'Chat',
              page: ChatRoute.page,
            ),
            AutoRoute(
              path: 'Log',
              page: LogRoute.page,
            ),
            AutoRoute(
              path: 'Calendar',
              page: CalenderRoute.page,
            )
          ],
        ),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final routeName = resolver.route.name;
    // logger.i('CALLED onNavigation(): $routeName');
    // ガード状態に応じて処理をわける
    // App()でガード状態が確定するまで待っているので、このタイミングでは確定している

    // TODO_authenticatedをstateで管理する
    // ex) final guardState = ref.read(guardStateProvider).requireValue;
    final authenticated = FirebaseAuth.instance.currentUser != null;
    if (!authenticated) {
      // 未サインイン

      if ([
        SignInRoute.name,
        SignUpRoute.name,
        SignUpFormNameRoute.name,
        SignUpFormBirthDateRoute.name,
        SignUpFormSexRoute.name,
        SignUpFormSurveyRoute.name,
        SignUpFormCheckRoute.name,
        // LoadingRoute.name,
        // ErrorRoute.name,
      ].contains(routeName)) {
        // logger.i('$routeName は未サインインでも表示する');
        return resolver.next();
      }

      // logger.i('未サインインなのでサインイン画面にリダイレクト');
      router.replace(const SignInRoute());
    } else {
      // サインイン済み

      if ([
        SignInRoute.name,
      ].contains(routeName)) {
        // logger.i('サインイン済みなのに $routeName を開こうとした場合トップ画面にリダイレクト');
        router.push(const RootRoute());
        return;
      }

      // logger.i('サインイン済みなので $routeName を表示する');
      resolver.next();
    }
  }
}

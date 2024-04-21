import 'package:aizuchi_app/presentation/view/pages/calender/calendar_page.dart';
import 'package:aizuchi_app/presentation/view/pages/message/limit_message_page.dart';
import 'package:aizuchi_app/presentation/view/pages/message/message_page.dart';
import 'package:aizuchi_app/presentation/view/pages/log/log_page.dart';
import 'package:aizuchi_app/presentation/view/pages/root_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/mail/mail_confirm_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/plan/plan_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/purchase_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_birthdate_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_check_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_name_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_sex_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_survey_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_in_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              path: 'Message',
              page: MessageRoute.page,
              initial: true,
            ),
            AutoRoute(
              path: 'Log',
              page: LogRoute.page,
            ),
            AutoRoute(
              path: 'Calendar',
              page: CalenderRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/Plan',
          page: PlanRoute.page,
        ),
        AutoRoute(
          path: '/Purchase',
          page: PurchaseRoute.page,
        ),
        AutoRoute(
          path: '/MailConfirm',
          page: MailConfrimRoute.page,
        ),
        AutoRoute(
          path: '/LimitMessage',
          page: LimitMessageRoute.page,
        ),
      ];

  //FIXME: サインイン途中にアプリが切られた場合の挙動を作成。未サインイン状態。

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final routeName = resolver.route.name;
    // logger.i('CALLED onNavigation(): $routeName');
    // ガード状態に応じて処理をわける
    // App()でガード状態が確定するまで待っているので、このタイミングでは確定している

    // TODO_authenticatedをstateで管理する
    // ex) final guardState = ref.read(guardStateProvider).requireValue;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isSignUp = prefs.getBool('is_sign_up') ?? false;

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
        print('$routeName は未サインインでも表示する');
        return resolver.next();
      }

      print('未サインインなのでサインイン画面にリダイレクト');

      if (isSignUp) {
        router.replace(const SignUpFormNameRoute());
      } else {
        router.replace(const SignInRoute());
      }
    } else {
      // サインイン済み

      if ([
        SignInRoute.name,
      ].contains(routeName)) {
        // print('サインイン済みなのに $routeName を開こうとした場合トップ画面にリダイレクト');
        router.push(const RootRoute());
      }

      // print('サインイン済みなので $routeName を表示する');
      // その他のケースでは、そのままアクセスを許可する。
      resolver.next();
    }
  }
}

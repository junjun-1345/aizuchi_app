import 'package:aizuchi_app/presentation/router/auth_guard.dart';
import 'package:aizuchi_app/presentation/router/register_guard.dart';
import 'package:aizuchi_app/presentation/view/components/web_view.dart';
import 'package:aizuchi_app/presentation/view/pages/calender/calendar_page.dart';
import 'package:aizuchi_app/presentation/view/pages/measurement/measurement_page.dart';
import 'package:aizuchi_app/presentation/view/pages/message/limit_message_page.dart';
import 'package:aizuchi_app/presentation/view/pages/message/message_page.dart';
import 'package:aizuchi_app/presentation/view/pages/log/log_page.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/current_profile_page.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/edit_profile_page.dart';
import 'package:aizuchi_app/presentation/view/pages/root_page.dart';
import 'package:aizuchi_app/presentation/view/pages/search/search.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/auth/authentication_cooperation_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/character/character_select_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/healthcare/healthcare_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/lock/lock_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/mail/mail_confirm_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/notification/notification_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/password/password_change_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/plan/plan_page.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/purchase_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/measurement_from_start_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/search_from_start_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_birthdate_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_check_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_name_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_sex_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_form_survey_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_up_page.dart';
import 'package:aizuchi_app/presentation/view/pages/start/sign_in_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'router.gr.dart';

final appRouterProvider = Provider((ref) => AppRouter(ref));

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  AppRouter(this.ref);

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/SignUp',
          page: SignUpRoute.page,
        ),
        AutoRoute(
          path: '/SignIn',
          page: SignInRoute.page,
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
          path: '/MeasurementFromStart',
          page: MeasurementFromStartRoute.page,
        ),
        AutoRoute(
          path: '/SearchFromStart',
          page: SearchFromStartRoute.page,
        ),
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          guards: [
            AuthGuard(),
            RegisterGuard(),
          ],
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
            AutoRoute(
              path: 'Measurement',
              page: MeasurementRoute.page,
            ),
            AutoRoute(
              path: 'Search',
              page: SearchRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/Plan',
          page: PlanRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/Purchase',
          page: PurchaseRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/CharacterSelect',
          page: CharacterSelectRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/AuthenticationCooperation',
          page: AuthenticationCooperationRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/MailConfirm',
          page: MailConfrimRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/PasswordChange',
          page: PasswordChangeRoute.page,
        ),
        AutoRoute(
          path: '/LimitMessage',
          page: LimitMessageRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/WebViewPage',
          page: WebViewRoute.page,
        ),
        AutoRoute(
          path: '/CurrentProfilePage',
          page: CurrentProfileRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/EditProfilePage',
          page: EditProfileRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/NotificationPage',
          page: NotificationRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/HealthcarePage',
          page: HealthcareRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/LockPage',
          page: LockRoute.page,
          guards: [AuthGuard()],
        ),
      ];
}

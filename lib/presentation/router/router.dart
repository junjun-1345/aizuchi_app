import 'package:aizuchi_app/application/state/googleauth_state.dart';
import 'package:aizuchi_app/presentation/animation/page_animation.dart';
import 'package:aizuchi_app/presentation/pages/calender_page.dart';
import 'package:aizuchi_app/presentation/pages/chat_page.dart';
import 'package:aizuchi_app/presentation/pages/loading_page.dart';
import 'package:aizuchi_app/presentation/pages/log_page.dart';
import 'package:aizuchi_app/presentation/pages/select_chat_page.dart';
import 'package:aizuchi_app/presentation/pages/settings/notification_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signin_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_info.dart';
import 'package:aizuchi_app/presentation/pages/start_page.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

class PagePath {
  static const loading = '/loading';
  static const start = '/start';
  static const chat = '/chat';
  static const selectChat = '/selectChat';
  static const log = '/log';
  static const calender = '/calender';
  static const signUp = '/signUp';
  static const signIn = '/signIn';
  static const signUpInfo = '/signUpInfo';
  static const notification = '/notification';
}

//
@riverpod
GoRouter router(RouterRef ref) {
  // パスと画面の組み合わせ
  final routes = [
    GoRoute(
      path: PagePath.loading,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const LoadingPage(),
      ),
    ),
    GoRoute(
      path: PagePath.start,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const StartPage(),
      ),
    ),
    GoRoute(
      path: PagePath.chat,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const ChatPage(),
      ),
    ),
    GoRoute(
      path: PagePath.selectChat,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SelectChatPage(),
      ),
    ),
    GoRoute(
      path: PagePath.log,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const LogPage(),
      ),
    ),
    GoRoute(
      path: PagePath.calender,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const CalenderPage(),
      ),
    ),
    GoRoute(
      path: PagePath.signUp,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpPage(),
      ),
    ),
    GoRoute(
      path: PagePath.signIn,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignInPage(),
      ),
    ),
    GoRoute(
      path: PagePath.signUpInfo,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpInfoPage(),
      ),
    ),
    GoRoute(
      path: PagePath.notification,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const NotificationPage(),
      ),
    ),
  ];

  // リダイレクト - 強制的に画面を変更する
  String? redirect(BuildContext context, GoRouterState state) {
    // 表示しようとしている画面
    final page = state.uri.toString();
    // サインインしているかどうか
    final signedIn = ref.read(signedInProvider);

    print("ページ$page サインイン$signedIn");

    if (signedIn && page == PagePath.start) {
      return PagePath.chat;
    } else {
      return null;
    }
  }

  final listenable = ValueNotifier<Object?>(null);
  ref.listen<Object?>(signedInProvider, (_, newState) {
    print("リフレッシュナブル発火");
    listenable.value = newState;
  });
  ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: PagePath.start,
    routes: routes,
    redirect: redirect,
    refreshListenable: listenable,
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: brandThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

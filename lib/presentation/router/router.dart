import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/application/state/account.dart';
import 'package:aizuchi_app/presentation/animation/page_animation.dart';
import 'package:aizuchi_app/presentation/pages/chat_page.dart';
import 'package:aizuchi_app/presentation/pages/log_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_birthday_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_check_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_name_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_sex_page.dart';
import 'package:aizuchi_app/presentation/pages/start_page.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

class PagePath {
  static const start = '/start';
  static const chat = '/chat';
  static const log = '/log';
  static const singupName = '/singupName';
  static const singupSex = '/singupSex';
  static const singupBirthDay = '/singupBirthDay';
  static const singupCheck = '/singupCheck';
}

//
@riverpod
GoRouter router(RouterRef ref) {
  // パスと画面の組み合わせ
  final routes = [
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
      path: PagePath.log,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const LogPage(),
      ),
    ),
    GoRoute(
      path: PagePath.singupName,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpNamePage(),
      ),
    ),
    GoRoute(
      path: PagePath.singupSex,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpSexPage(),
      ),
    ),
    GoRoute(
      path: PagePath.singupBirthDay,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpBirthdayPage(),
      ),
    ),
    GoRoute(
      path: PagePath.singupCheck,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpCheckPage(),
      ),
    ),
  ];

  // リダイレクト - 強制的に画面を変更する
  String? redirect(BuildContext context, GoRouterState state) {
    // 表示しようとしている画面
    final page = state.matchedLocation;

    debugPrint(page);

    // サインアップ・サインインしているかどうか
    final accountState = ref.read(accountNotifierProvider);

    debugPrint(accountState.toString());

    if (accountState && page == PagePath.chat) {
      // サインイン済み --> ホーム画面へ
      debugPrint("サインイン済みのためチャットページへリダイレクト");
      return null;
    } else if (!accountState && page == PagePath.chat) {
      debugPrint("未サインインのためリダイレクトしない");
      return PagePath.start;
    }
    debugPrint("条件外のためリダイレクトしない");
    return null;
  }

  // リフレッシュリスナブル - Riverpod と GoRouter を連動させるコード
  // サインイン状態が切り替わったときに GoRouter が反応する
  final listenable = ValueNotifier<Object?>(null);
  ref.listen<Object?>(accountNotifierProvider, (_, newState) {
    listenable.value = newState;
  });

  ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: PagePath.chat,
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
    final accountUsecase = ref.read(accountUsecaseProvider);

    useEffect(() {
      accountUsecase.init();
    }, const []);

    return MaterialApp.router(
      theme: brandThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

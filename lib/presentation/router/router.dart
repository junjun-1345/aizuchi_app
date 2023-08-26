import 'package:aizuchi_app/presentation/pages/chat_page.dart';
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
}

//
@riverpod
GoRouter router(RouterRef ref) {
  // パスと画面の組み合わせ
  final routes = [
    GoRoute(
      path: PagePath.start,
      builder: (_, __) => const StartPage(),
    ),
    GoRoute(
      path: PagePath.chat,
      builder: (_, __) => const ChatPage(),
    ),
  ];

  return GoRouter(
    initialLocation: PagePath.chat,
    routes: routes,
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    useEffect(() {
      debugPrint('初回起動');
      return null;
    }, const []);

    return MaterialApp.router(
      theme: brandThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

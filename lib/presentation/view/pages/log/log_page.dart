import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_carousel.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_summary_tile.dart';
import 'package:aizuchi_app/presentation/view_model/log_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LogPage extends ConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      context.router.replace(const SignInRoute());
      // final authenticated = FirebaseAuth.instance.currentUser != null;
      // print(authenticated);
    }

    final dailyState = ref.watch(dailyNotifierProvider);
    final userState = ref.watch(usersNotifierProvider);
    final logViewModel = ref.watch(logViewModelProvider);

    return Scaffold(
      body: userState.when(
        data: (user) {
          return dailyState.when(
            data: (data) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'ログ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  LogSummaryTile(
                    messageAmount: data.length,
                    activeDays: user.activeDay,
                    createdAt: user.createdAt,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  LogCarousel(
                    dailyList: data,
                    logStartDay: logViewModel.logStartDay,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (Object error, StackTrace stackTrace) {
              return const Text("エラーが発生しました");
            },
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (Object error, StackTrace stackTrace) {
          return const Text("ユーザー情報の取得中にエラーが発生しました");
        },
      ),
    );
  }
}

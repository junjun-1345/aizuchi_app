import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/summary_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_carousel.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_summary_tile.dart';
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

    final userState = ref.watch(usersNotifierProvider);

    final summaryState = ref.watch(summaryNotifierProvider);

    return Scaffold(
      body: Center(
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
            userState.when(
              data: (data) => LogSummaryTile(
                messageAmount: data.totalMessages,
                activeDays: data.activeDay,
                createdAt: data.createdAt,
              ),
              loading: () {
                return const CircularProgressIndicator();
              },
              error: (Object error, StackTrace stackTrace) {
                return const Text("エラーが発生しました");
              },
            ),
            const SizedBox(
              height: 24,
            ),
            summaryState.when(
              data: (data) => LogCarousel(
                dailyList: data,
              ),
              loading: () {
                return const CircularProgressIndicator();
              },
              error: (Object error, StackTrace stackTrace) {
                return const Text("エラーが発生しました");
              },
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

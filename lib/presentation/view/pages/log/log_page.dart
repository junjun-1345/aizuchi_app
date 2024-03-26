import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/state/summary_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_carousel.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_summary_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LogPage extends HookConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectDate = useState(DateTime(0));

    Future<void> get() async {
      ref
          .read(summaryNotifierProvider.notifier)
          .getWeeklySummary(selectDate.value);
    }

    final userState = ref.watch(usersNotifierProvider);
    final dailyState = ref.watch(dailyNotifierProvider);
    final summaryState = ref.watch(summaryNotifierProvider);
    print(dailyState);
    print(summaryState);

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
            dailyState.when(
              data: (data) {
                print('data$data');
                return LogCarousel(
                  dailyList: data,
                );
              },
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

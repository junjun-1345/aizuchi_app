import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/state/summary_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/carousel_tiles/days_carousel_tile.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/carousel_tiles/emotion_stock_tile.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_summary_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LogPage extends HookConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(usersNotifierProvider);
    final dailyState = ref.watch(dailyNotifierProvider);
    final summaryState = ref.watch(summaryNotifierProvider);

    return Scaffold(
      drawer: const HamburgerMenu(),
      drawerScrimColor: BrandColor.base,
      appBar: AppBar(
        title: const Text(
          "ログ",
          style: TextStyle(fontSize: 20, color: BrandColor.textBlack),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.54),
              items: [
                summaryState.when(
                  data: (data) => DaysCarouselTile(dailyList: data),
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return const Text("エラーが発生しました");
                  },
                ),
                dailyState.when(
                  data: (data) => EmotionStockTile(dailyList: data),
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return const Text("エラーが発生しました");
                  },
                ),
              ],
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

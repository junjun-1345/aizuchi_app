import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/biling_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class PlanPage extends ConsumerWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "加入プラン",
          style: TextStyle(color: BrandColor.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Text('MessagePage'),
              AppButton.medium(
                  onPressed: () {
                    _init(ref);
                  },
                  text: 'サブスク初期化'),
              const SizedBox(height: 40),
              AppButton.medium(
                  onPressed: () {
                    _purchase_a(ref);
                  },
                  text: 'サブスク購入 A'),
              const SizedBox(height: 20),
              AppButton.medium(
                  onPressed: () {
                    _purchase_b(ref);
                  },
                  text: 'サブスク購入 B'),
              // Expanded(
              //   child: ref.watch(dailyNotifierProvider).when(
              //         data: (dailies) => ListView.builder(
              //           // reverse: true,
              //           itemCount: dailies.length,
              //           itemBuilder: (context, index) {
              //             final daily = dailies[index];
              //             return Column(
              //               children: [
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text(daily.createdAt.toString()),
              //                     const SizedBox(width: 8),
              //                     Text(
              //                       daily.emotion.emotionValue ?? '',
              //                       style: const TextStyle(fontSize: 24),
              //                     ),
              //                   ],
              //                 ),
              //                 Text(daily.summary),
              //               ],
              //             );
              //           },
              //         ),
              //         loading: () =>
              //             const Center(child: CircularProgressIndicator()),
              //         error: (error, _) =>
              //             Center(child: Text('エラーが発生しました: $error')),
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _init(WidgetRef ref) async {
    ref.read(inAppPurchaseManager).initInAppPurchase();
  }

  void _purchase_a(WidgetRef ref) async {
    ref.read(inAppPurchaseManager).makePurchase("offering_test_a");
  }

  void _purchase_b(WidgetRef ref) async {
    ref.read(inAppPurchaseManager).makePurchaseAnuual("offering_test_b");
  }
}

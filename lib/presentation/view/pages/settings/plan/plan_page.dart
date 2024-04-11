import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/components/list_item.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/plan/components/promotion_bunner.dart';
import 'package:aizuchi_app/presentation/view_model/subscription_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class PlanPage extends ConsumerWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribedInfo =
        ref.read(subscriptionUsecaseProvider).checkSubscriptionStatus();
    final subscriptionViewModel = ref.read(subscriptionViewModelProvider);

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: subscribedInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('An error has occurred!');
              } else if (!snapshot.hasData) {
                return const Text('An error has occurred!');
              } else {
                final SubscriptionModel data = snapshot.data!;
                if (data.isActive == false) {
                  return Column(
                    children: [
                      const SizedBox(height: 48),
                      ListItem(
                        title: "加入プラン",
                        value: "未加入",
                        onTap: () {
                          null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ListItem(
                        title: "購入を復元する",
                        value: "",
                        onTap: () async {
                          await subscriptionViewModel.checkSubscriptionStatus();
                          await subscriptionViewModel.restorePurchase();
                          // await Purchases.restorePurchases();
                        },
                      ),
                      const SizedBox(height: 24),
                      const PromotionBunner()
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(height: 48),
                      ListItem(
                        title: "加入プラン",
                        value: data.planName ?? "未加入",
                        onTap: () {
                          null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ListItem(
                          title: "次回更新日",
                          value:
                              "${data.expirationDate!.year}年${data.expirationDate!.month}月${data.expirationDate!.day}日"),
                      const SizedBox(height: 24),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

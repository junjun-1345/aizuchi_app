import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/completed_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/components/annual_plan_content.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/components/monthly_plan_content.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/components/plan_button.dart';
import 'package:aizuchi_app/presentation/view_model/subscription_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlanListContents extends ConsumerStatefulWidget {
  const PlanListContents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanListContentsState();
}

class _PlanListContentsState extends ConsumerState<PlanListContents> {
  @override
  Widget build(BuildContext context) {
    final subscriptionViewModel = ref.read(subscriptionViewModelProvider);
    return FutureBuilder(
      future: subscriptionViewModel.getPackages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('An error has occurred!');
        } else if (!snapshot.hasData) {
          return const Text('An error has occurred!');
        } else {
          return Column(
            children: snapshot.data!.map(
              (element) {
                switch (element.planType) {
                  case PlanType.monthly:
                    return Column(
                      children: [
                        PlanButton(
                          MonthlyPlanContent(
                            price: element.price,
                          ),
                          () async {
                            try {
                              await subscriptionViewModel
                                  .purchasePackage(PlanType.monthly);
                              // コンテキストが有効な状態でダイアログを表示
                              if (mounted) {
                                // FIXME: ダイアログの見直し
                                showDialog(
                                  context: context,
                                  builder: (context) => CompletedDialog(
                                    title: '月間プランを購入しました',
                                    content: 'ホームへ戻ります。',
                                    onPressed: () {
                                      context.router
                                          .replace(const SignInRoute());
                                    },
                                  ), // 成功ダイアログ
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                // FIXME: ダイアログの見直し
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('エラー'),
                                    content: const Text('エラーが発生しました。'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              color: BrandColor.baseRed),
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  case PlanType.annual:
                    return Column(
                      children: [
                        PlanButton(
                          AnnualPlanContent(
                            price: element.price,
                          ),
                          () async {
                            try {
                              await subscriptionViewModel
                                  .purchasePackage(PlanType.annual);
                              // コンテキストが有効な状態でダイアログを表示
                              if (mounted) {
                                // FIXME: ダイアログの見直し
                                showDialog(
                                  context: context,
                                  builder: (context) => CompletedDialog(
                                    title: '年間プランを購入しました',
                                    content: 'ホームへ戻ります。',
                                    onPressed: () {
                                      context.router
                                          .replace(const SignInRoute());
                                    },
                                  ), // 成功ダイアログ
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                // FIXME: ダイアログの見直し
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('エラー'),
                                    content: const Text('エラーが発生しました。'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              color: BrandColor.baseRed),
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          isBorder: true,
                          height: 160,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  default:
                    return const Text("data");
                }
              },
            ).toList(),
          );
        }
      },
    );
  }
}

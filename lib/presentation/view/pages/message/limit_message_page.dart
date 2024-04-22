import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_contents.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LimitMessagePage extends HookConsumerWidget {
  const LimitMessagePage({super.key, required this.selectedDate});

  final DateTime selectedDate;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersNotifierProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
          drawer: const HamburgerMenu(),
          drawerScrimColor: BrandColor.base,
          appBar: AppBar(
            title: Text(
              "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}の会話",
              style: const TextStyle(fontSize: 20, color: BrandColor.textBlack),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: BrandColor.textBlack),
          ),
          body: usersState.when(
            data: (data) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // コンテント
                  MessageContents(
                    selectedDate: selectedDate,
                  ),
                  // フッター
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: const BoxDecoration(
                      color: BrandColor.white,
                      border: Border(
                        top: BorderSide(width: 0.25, color: Colors.black38),
                        bottom: BorderSide(width: 0.25, color: Colors.black38),
                      ),
                    ),
                    child: Column(
                      children: [
                        AppButton.base(
                            text: "カレンダーに戻る",
                            onPressed: () {
                              context.router.maybePop();
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            error: (Object error, StackTrace stackTrace) {
              return const Text("エラーが発生しました");
            },
          )),
    );
  }
}

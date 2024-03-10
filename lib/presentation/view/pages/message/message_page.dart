import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_contents.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_emotion_select_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_footer_contents.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_overlimit_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MessagePage extends HookConsumerWidget {
  const MessagePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersNotifierProvider);
    final datetimeNow = DateTime.now();
    final today = "${datetimeNow.year}_${datetimeNow.month}_${datetimeNow.day}";

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque, // これを追加！！！
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "もうふちゃん 会話",
              style: TextStyle(fontSize: 20, color: BrandColor.textBlack),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: usersState.when(
            data: (data) {
              if (data.isMessageOverLimit) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const MessageOverLimitDialog();
                      },
                    );
                  },
                );
              } else if (!data.isConversation && data.dailyKey != today) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const MessageEmotionSelectDailog();
                    },
                  );
                });
              }
              return const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // コンテント
                  MessageContents(),
                  // フッター
                  MessageFooterContents(),
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

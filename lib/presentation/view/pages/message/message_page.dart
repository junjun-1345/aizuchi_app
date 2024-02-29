import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/message_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_contents.dart';
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
    final messagesState = ref.watch(messagesNotifierProvider);
    final usersState = ref.watch(usersNotifierProvider);

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
              // 会話が上限に達した場合のダイアログ
              if (data.isMessageOverLimit) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const MessageOverLimitDialog();
                    },
                  );
                });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // コンテント
                  Expanded(
                    child: messagesState.when(
                      data: (messages) => ListView.builder(
                        // reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return MessageContents(
                            type: message.type,
                            message: message,
                          );
                        },
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, _) =>
                          Center(child: Text('エラーが発生しました: $error')),
                    ),
                  ),
                  // フッター
                  const MessageFooterContents(),
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

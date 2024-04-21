import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/messsage_providers.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/error_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_emotion_select_dialog.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageFooterContents extends ConsumerWidget {
  const MessageFooterContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datetimeNow = DateTime.now();
    final today = "${datetimeNow.year}_${datetimeNow.month}_${datetimeNow.day}";
    final userState = ref.watch(usersNotifierProvider);

    final isWaiting = ref.watch(isWaitngProvider);
    final messageViewModel = ref.read(messageViewModelProvider);
    final messageController = TextEditingController();

    void sendMessage() {
      if (messageController.text.isNotEmpty) {
        if (isWaiting) {
          showDialog(
              context: context,
              builder: (context) =>
                  const ErrorDialog(title: "送信中", content: "送信中は他の操作をできません"));
        }
        try {
          ref.read(messageProvider.notifier).state = messageController.text;
          messageViewModel.sendMessage();
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) =>
                const ErrorDialog(title: "エラー", content: "データの取得に失敗しました。"),
          );
        }
        messageController.clear();
      }
    }

    Widget inputField(bool isMessageOverLimit) {
      return Column(
        children: [
          if (isMessageOverLimit) const Text("会話が上限に達しました"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton.base(
                onPressed: () {
                  if (isWaiting) {
                    showDialog(
                      context: context,
                      builder: (context) => const ErrorDialog(
                        title: '送信中',
                        content: '送信中は他の操作をできません',
                      ),
                    );
                  } else {
                    ref.read(messageViewModelProvider).createSummary();
                  }
                },
                text: "終了",
              ),
              const SizedBox(width: 8),
              Expanded(
                child: isMessageOverLimit
                    ? AppButton.base(
                        onPressed: () {
                          context.router.push(const PurchaseRoute());
                        },
                        text: "Aizuchi Premium >",
                        textStyle: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    : TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        minLines: 1,
                        cursorColor: BrandColor.baseRed,
                        decoration: const InputDecoration(
                          hintText: "メッセージを入力",
                          filled: true,
                          //これがないと余白をとりすぎる
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                        ),
                        onSubmitted: (value) async {
                          sendMessage();
                        },
                        controller: messageController,
                        // autofocus: true,
                        onEditingComplete: () {},
                      ),
              ),
              if (!isWaiting)
                IconButton(
                    onPressed: () async {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send)),
              if (isWaiting) ...{
                const SizedBox(width: 8),
                const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    color: BrandColor.baseRed,
                  ),
                ),
              }
            ],
          ),
        ],
      );
    }

    Widget conversationStartButton(String dailyKey) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isWaiting
              ? const CircularProgressIndicator()
              : Expanded(
                  child: AppButton.base(
                    onPressed: dailyKey == today
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const MessageEmotionSelectDailog(),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const StadiumBorder(),
                        backgroundColor: BrandColor.baseRed),
                    text: ("日記を書く"),
                  ),
                ),
        ],
      );
    }

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: const BoxDecoration(
              color: BrandColor.white,
              border: Border(
                top: BorderSide(
                    width: 0.25, //枠線の太さ
                    color: Colors.black38),
                bottom: BorderSide(
                    width: 0.25, //枠線の太さ
                    color: Colors.black38),
              ),
            ),
            child: userState.when(
              data: (data) {
                return data.isConversation
                    ? inputField(data.isMessageOverLimit)
                    : conversationStartButton(data.dailyKey);
              },
              loading: () {
                return const CircularProgressIndicator();
              },
              error: (error, stackTrace) {
                return const Text("エラーが発生しました");
              },
            )),
      ],
    );
  }
}

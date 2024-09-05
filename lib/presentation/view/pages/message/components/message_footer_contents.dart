import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/messsage_providers.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/app_dialog.dart';
import 'package:aizuchi_app/presentation/view/components/app_loading.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_emotion_select_dialog.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
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

    final screenWidth = MediaQuery.of(context).size.width;

    void sendMessage() {
      if (messageController.text.isNotEmpty) {
        if (isWaiting) {
          AppDialog.showErrorDialog(
              context: context, title: "送信中", content: "送信中は他の操作をできません");
        }
        try {
          ref.read(messageProvider.notifier).state = messageController.text;
          messageViewModel.sendMessage();
        } catch (e) {
          AppDialog.showErrorDialog(
              context: context, title: "エラー", content: "データの取得に失敗しました。");
        }
        messageController.clear();
      }
    }

    Widget inputField(bool isMessageOverLimit) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton.small(
                width: 100,
                height: 40,
                onPressed: () {
                  if (isWaiting) {
                    AppDialog.showErrorDialog(
                        context: context,
                        title: "送信中",
                        content: "送信中は他の操作をできません");
                  } else {
                    ref.read(messageViewModelProvider).createSummary();
                  }
                },
                text: "おわる",
              ),
              const SizedBox(width: 8),

              isMessageOverLimit
                  // FIXME: 課金機能解除後にコメントアウトを外す
                  // ? Expanded(
                  //     child: AppButton.medium(
                  //       width: screenWidth * 0.8,
                  //       onPressed: () {
                  //         context.router.push(const PurchaseRoute());
                  //       },
                  //       text: "Aizuchi Premium >",
                  //       textStyle: const TextStyle(
                  //           fontSize: 24, fontWeight: FontWeight.bold),
                  //     ),
                  //   )
                  // FIXME: 課金機能解除後に以下一行削除
                  ? const Expanded(child: Text("会話が上限に達しました"))
                  : Expanded(
                      child: AppTextForm.messageField(
                        messageController,
                        onFieldSubmitted: (value) async {
                          sendMessage();
                        },
                        // autofocus: true,
                        onEditingComplete: () {},
                      ),
                    ),

              // TODO: 2024/05/17
              // 以下の条件分岐は課金実装後に切り替えてください
              if (!isWaiting && !isMessageOverLimit)
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
                  child: AppLoading(),
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
              ? const SizedBox(
                  height: 40,
                  child: AppLoading(),
                )
              : AppButton.medium(
                  width: screenWidth * 0.8,
                  onPressed: dailyKey != today
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                MessageEmotionSelectDailog(dailyKey: dailyKey),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const StadiumBorder(),
                      backgroundColor: BrandColor.baseRed),
                  text: ("お話しする"),
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
                return const AppLoading();
              },
              error: (error, stackTrace) {
                return const Text("エラーが発生しました");
              },
            )),
      ],
    );
  }
}

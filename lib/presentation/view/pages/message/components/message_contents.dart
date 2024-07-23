import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/message_model.dart';
import 'package:aizuchi_app/presentation/state/message_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageContents extends HookConsumerWidget {
  const MessageContents({super.key, this.selectedDate});

  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final messagesState = ref.watch(messagesNotifierProvider);
    final ScrollController scrollController = ScrollController();

    // スクロールを最下部に移動する関数
    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }

    // 初回描画後にスクロールを最下部に移動
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

    // ListViewが更新されるたびにスクロールする
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
      return scrollController.dispose; // コンポーネントが破棄されるときにコントローラを破棄
    }, const []);

    Widget userMessageContent(String content) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.8,
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: BrandColor.darkWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 16,
                ),
                child: Text(
                  content,
                  style: const TextStyle(
                    color: BrandColor.textBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget assistantMessageContent(String content) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/mofumofu_icon_1.png'),
              ),
              const SizedBox(
                width: 4,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.6,
                ),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: BrandColor.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      content,
                      style: const TextStyle(
                        color: BrandColor.textBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget emotionContent(String content) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                content,
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ),
        ),
      );
    }

    Widget dateContent(DateTime content) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.8,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: Colors.grey.shade200,
                  color: BrandColor.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: Text(
                  "${content.month}月${content.day}日",
                  style: const TextStyle(
                      fontSize: 12, color: BrandColor.textBlack),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildMessageContent(MessageModel message) {
      switch (message.type) {
        case MessageType.user:
          return userMessageContent(message.content);
        case MessageType.assistant:
          return assistantMessageContent(message.content);
        case MessageType.emotion:
          return emotionContent(message.content);
        case MessageType.datetime:
          final String rawDate = message.id;
          final List<String> dateParts = rawDate.split('_');
          final String formattedDate =
              "${dateParts[0]}-${dateParts[1].padLeft(2, '0')}-${dateParts[2].padLeft(2, '0')}";
          final DateTime messageDate = DateTime.parse(formattedDate);
          return dateContent(messageDate);
        default:
          return const SizedBox.shrink();
      }
    }

    return Expanded(
      child: messagesState.when(
        data: (messages) {
          final List<MessageModel> filteredMessages;
          if (selectedDate != null) {
            filteredMessages = messages.where((message) {
              return message.createdAt.year == selectedDate?.year &&
                  message.createdAt.month == selectedDate?.month &&
                  message.createdAt.day == selectedDate?.day;
            }).toList();
          } else {
            filteredMessages = messages;
          }

          if (filteredMessages.isEmpty) {
            return const Center(
              child: Text("メッセージが存在しません",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            );
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: filteredMessages.length,
            itemBuilder: (context, index) {
              final message = filteredMessages[index];

              return buildMessageContent(message);
            },
          );
        },
        loading: () => const Center(
          child: AppLoading(),
        ),
        error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }
}

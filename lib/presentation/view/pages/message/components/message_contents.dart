import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/message_model.dart';
import 'package:aizuchi_app/presentation/state/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageContents extends ConsumerWidget {
  const MessageContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final messagesState = ref.watch(messagesNotifierProvider);

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
          return dateContent(message.createdAt);
        default:
          return const SizedBox.shrink();
      }
    }

    return Expanded(
      child: messagesState.when(
        data: (messages) => ListView.builder(
          // reverse: true,  // コメントアウトを外してリストを逆順に表示したい場合
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return buildMessageContent(message);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }
}

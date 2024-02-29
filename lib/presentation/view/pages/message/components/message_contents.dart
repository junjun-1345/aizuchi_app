import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/message_model.dart';
import 'package:flutter/material.dart';

class MessageContents extends StatelessWidget {
  final MessageType type;
  final MessageModel message;

  const MessageContents({
    super.key,
    required this.type,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget userMessageContent() {
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
                  message.content,
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

    Widget assistantMessageContent() {
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
                      message.content,
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

    Widget emotionContent() {
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
                message.content,
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ),
        ),
      );
    }

    Widget dateContent() {
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
                  "${message.createdAt.month}月${message.createdAt.day}日",
                  style: const TextStyle(
                      fontSize: 12, color: BrandColor.textBlack),
                ),
              ),
            ),
          ),
        ),
      );
    }

    switch (type) {
      case MessageType.user:
        return userMessageContent();
      case MessageType.assistant:
        return assistantMessageContent();
      case MessageType.emotion:
        return emotionContent();
      case MessageType.datetime:
        return dateContent();
      default:
        return const SizedBox();
    }
  }
}

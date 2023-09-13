import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmotionDialogWidget extends ConsumerWidget {
  const EmotionDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usecase = ref.read(messageUsecaseProvider);

    Widget _button(int num, String text) {
      return SizedBox(
        height: 54,
        width: 54,
        child: TextButton(
          onPressed: () {
            usecase.sendEmotion(num, text);
            Navigator.pop(context);
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 32,
            ),
          ),
        ),
      );
    }

    return AlertDialog(
        title: Text('日記作成', textAlign: TextAlign.center),
        content: Text('今日の感情を選択してね！', textAlign: TextAlign.center),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _button(1, "😭"),
              _button(2, "🥲"),
              _button(3, "😐"),
              _button(4, "🙂"),
              _button(5, "😁"),
            ],
          )
        ]);
  }
}

void showEmotionDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) {
      return EmotionDialogWidget();
    },
  );
}

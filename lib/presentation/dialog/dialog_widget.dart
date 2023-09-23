import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmotionDialogWidget extends HookConsumerWidget {
  const EmotionDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usecase = ref.read(messageUsecaseProvider);

    final birthdayState = useState(DateTime.now());

    Widget _button(int num, String text) {
      return SizedBox(
        height: 54,
        width: 54,
        child: TextButton(
          onPressed: () {
            usecase.sendEmotion(
                "${DateTime(birthdayState.value.year, birthdayState.value.month, birthdayState.value.day).toString()}",
                num,
                text);
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

    final textButton = TextButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
        );
        birthdayState.value = selectedDate!;
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "${birthdayState.value.month}月${birthdayState.value.day}日",
              style: BrandText.textL.copyWith(color: Colors.blue),
            ),
            TextSpan(
              text: "の日記作成",
              style: BrandText.textL.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );

    return AlertDialog(
        title: textButton,
        content: Text('今日の感情を選択してね！', textAlign: TextAlign.center),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _button(0, "😭"),
              _button(1, "🥲"),
              _button(2, "😐"),
              _button(3, "🙂"),
              _button(4, "😁"),
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

class ErrorDialogWidget extends HookConsumerWidget {
  const ErrorDialogWidget({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = Text("注意");
    return AlertDialog(
      title: title,
      content: Text(content, textAlign: TextAlign.center),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('戻る'),
        ),
      ],
    );
  }
}

void showErrorDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return ErrorDialogWidget(content: content);
    },
  );
}

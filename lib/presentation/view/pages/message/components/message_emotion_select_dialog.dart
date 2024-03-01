import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageEmotionSelectDailog extends ConsumerWidget {
  const MessageEmotionSelectDailog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageViewModel = ref.read(messageViewModelProvider);

    Widget selectEmotionButton(EmotionType emotion) {
      return SizedBox(
        height: 54,
        width: 54,
        child: TextButton(
          onPressed: () async {
            ref.read(emotionProvider.notifier).state = emotion;
            messageViewModel.sendTodayFirstMessage();
            Navigator.of(context).pop();
          },
          child: Text(
            emotion.emotionValue ?? "",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 32,
            ),
          ),
        ),
      );
    }

    return AlertDialog(
      title: const Text(
        '日記を書く',
        textAlign: TextAlign.center,
      ),
      content: const Text('今日はどんな１日だったー？'),
      actions: <Widget>[
        Column(
          children: [
            Row(
              children: [
                selectEmotionButton(EmotionType.joyful),
                selectEmotionButton(EmotionType.content),
                selectEmotionButton(EmotionType.neutral),
                selectEmotionButton(EmotionType.discontent),
                selectEmotionButton(EmotionType.sad),
              ],
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'あとにする',
                style: TextStyle(color: BrandColor.baseRed),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
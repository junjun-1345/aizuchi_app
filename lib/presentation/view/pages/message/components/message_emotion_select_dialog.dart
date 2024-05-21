import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:aizuchi_app/presentation/view_model/subscription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageEmotionSelectDailog extends ConsumerWidget {
  const MessageEmotionSelectDailog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget selectEmotionButton(EmotionType emotion) {
      return GestureDetector(
        onTap: () {
          ref.read(subscriptionViewModelProvider).checkSubscriptionStatus();
          ref.read(emotionProvider.notifier).state = emotion;
          ref.read(messageViewModelProvider).sendTodayFirstMessage();

          Navigator.of(context).pop();
        },
        child: Text(
          emotion.emotionValue ?? "",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 32,
          ),
        ),
      );
    }

    return AlertDialog(
      content: const SizedBox(
        height: 48,
        child: Column(
          children: [
            Text(
              '今日はどんな１日だったー？',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: BrandColor.textBlack),
            ),
            Text(
              'お話聞かせて〜!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: BrandColor.textBlack),
            ),
          ],
        ),
      ),
      backgroundColor: BrandColor.white,
      surfaceTintColor: Colors.transparent,
      actions: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                spacing: 16,
                children: [
                  selectEmotionButton(EmotionType.joyful),
                  selectEmotionButton(EmotionType.content),
                  selectEmotionButton(EmotionType.neutral),
                  selectEmotionButton(EmotionType.discontent),
                  selectEmotionButton(EmotionType.sad),
                ],
              ),
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

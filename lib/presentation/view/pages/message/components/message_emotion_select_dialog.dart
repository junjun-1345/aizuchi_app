import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:aizuchi_app/presentation/view_model/subscription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MessageEmotionSelectDailog extends HookConsumerWidget {
  const MessageEmotionSelectDailog({required this.dailyKey, super.key});
  final String dailyKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateFormat dateFormatter = DateFormat('MM月dd日');
    final String today = dateFormatter.format(DateTime.now());
    final String yesterday =
        dateFormatter.format(DateTime.now().subtract(const Duration(days: 1)));
    final datetimeNow = DateTime.now();
    final datetimeYesterdayNow =
        DateTime.now().subtract(const Duration(days: 1));
    final todayKey =
        "${datetimeNow.year}_${datetimeNow.month}_${datetimeNow.day}";
    final yesterdayKey =
        "${datetimeYesterdayNow.year}_${datetimeYesterdayNow.month}_${datetimeYesterdayNow.day}";

    final selectDate = useState<String>(todayKey);

    Widget selectEmotionButton(EmotionType emotion) {
      return GestureDetector(
        onTap: () {
          ref.read(subscriptionViewModelProvider).checkSubscriptionStatus();
          ref.read(emotionProvider.notifier).state = emotion;
          ref.read(messageViewModelProvider).sendTodayFirstMessage();

          Navigator.pop(context, selectDate.value);
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
            if (dailyKey != yesterday && dailyKey != todayKey)
              DropdownButton<String>(
                items: [
                  DropdownMenuItem(
                    value: todayKey,
                    child: Text(today),
                  ),
                  DropdownMenuItem(
                    value: yesterdayKey,
                    child: Text(yesterday),
                  ),
                ],
                onChanged: (value) {
                  selectDate.value = value!;
                },
                value: selectDate.value,
              ),
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
              onPressed: () => Navigator.pop(context),
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

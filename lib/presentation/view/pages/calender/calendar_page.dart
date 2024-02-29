import 'package:aizuchi_app/presentation/state/message_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CalenderPage extends ConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('CalenderPage'),
          ElevatedButton(
            onPressed: () {
              ref.read(isConversationProvider.notifier).state = true;
            },
            child: const Text('isConversationProvider True'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(isConversationProvider.notifier).state = false;
            },
            child: const Text('isConversationProvider False'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(dailyKeyProvider.notifier).state = "";
            },
            child: const Text('daiky Key Reset'),
          ),
          ElevatedButton(
            onPressed: () {
              // print(ref.watch(datetimeKeyProvider).toString());

              ref.read(isConversationProvider.notifier).state = false;
              // ref.read(diaryKeyProvider.notifier).state = "";
              ref.read(messagesNotifierProvider.notifier).deleteAll();
            },
            child: const Text('reset'),
          ),
        ],
      ),
    );
  }
}

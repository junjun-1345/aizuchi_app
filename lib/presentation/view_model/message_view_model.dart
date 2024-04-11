import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/state/message_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageViewModelProvider = Provider<MessageViewModel>(
  (ref) => MessageViewModel(
    ref,
    ref.read(messagesNotifierProvider.notifier),
    ref.read(usersNotifierProvider.notifier),
    ref.read(dailyNotifierProvider.notifier),
    ref.read(isWaitngProvider.notifier),
  ),
);

class MessageViewModel {
  final Ref ref;
  final MessagesNotifier messagesNotifier;
  final UsersNotifier usersNotifier;
  final DailyNotifier dailyNotifier;
  final IsWaitngNotifier isWaitngNotifier;

  MessageViewModel(
    this.ref,
    this.messagesNotifier,
    this.usersNotifier,
    this.dailyNotifier,
    this.isWaitngNotifier,
  );

  Future<void> sendTodayFirstMessage() async {
    isWaitngNotifier.startWaiting();
    usersNotifier.isConversationStart();

    usersNotifier.createDailyKey();
    await messagesNotifier.createDateMessage();
    await messagesNotifier.createEmotionMessage();
    await dailyNotifier.saveEmotion();
    await messagesNotifier.createAssistantMessage();

    isWaitngNotifier.stopWaiting();
  }

  Future<void> sendMessage() async {
    final bool isBilling =
        ref.read(usersNotifierProvider).asData!.value.billing;
    final bool isAssistant =
        ref.read(usersNotifierProvider).asData!.value.isAssistant;
    final String dailyKey =
        ref.read(usersNotifierProvider).asData!.value.dailyKey;

    isWaitngNotifier.startWaiting();

    await messagesNotifier.createUserMessage();

    if (!isAssistant) {
      isWaitngNotifier.stopWaiting();
      return;
    }

    final bool isMessageOverLimit =
        messagesNotifier.canReplyLLMMessage(dailyKey);

    if (!isBilling) {
      if (isMessageOverLimit) {
        usersNotifier.messageOverLimit();
        isWaitngNotifier.stopWaiting();
        return;
      }
    }

    await messagesNotifier.createAssistantMessage();
    isWaitngNotifier.stopWaiting();
  }

  Future<void> createSummary() async {
    isWaitngNotifier.startWaiting();
    usersNotifier.isConversationEnd();
    usersNotifier.isMessageOverLimitReset();

    final String summary = await messagesNotifier.createSummary();
    await dailyNotifier.saveSummary(summary);

    usersNotifier.updateTotalMessages();

    isWaitngNotifier.stopWaiting();
  }
}

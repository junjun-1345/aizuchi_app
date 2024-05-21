import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
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
    ref.read(usersUsecaseProvider),
  ),
);

class MessageViewModel {
  final Ref ref;
  final MessagesNotifier messagesNotifier;
  final UsersNotifier usersNotifier;
  final DailyNotifier dailyNotifier;
  final IsWaitngNotifier isWaitngNotifier;
  final UsersUsecase usersUsecase;

  MessageViewModel(
    this.ref,
    this.messagesNotifier,
    this.usersNotifier,
    this.dailyNotifier,
    this.isWaitngNotifier,
    this.usersUsecase,
  );

  Future<void> sendTodayFirstMessage() async {
    isWaitngNotifier.startWaiting();
    print("sendTodayFirstMessage");
    await usersNotifier.isConversationStart();
    await messagesNotifier.createDateMessage();
    await messagesNotifier.createEmotionMessage();
    await dailyNotifier.saveEmotion();
    await messagesNotifier.createAssistantMessage();

    isWaitngNotifier.stopWaiting();
  }

  Future<void> sendMessage() async {
    // 課金機能
    // final bool isSubscription =
    // ref.read(usersNotifierProvider).asData!.value.isSubscription;
    final isLimit = await ref.read(usersUsecaseProvider).getIsMessageLimit();
    final bool isAssistant =
        ref.read(usersNotifierProvider).asData!.value.isAssistant;
    final String dailyKey =
        ref.read(usersNotifierProvider).asData!.value.dailyKey;
    final limit = await ref.read(usersUsecaseProvider).getMessageLimit();

    isWaitngNotifier.startWaiting();

    await messagesNotifier.createUserMessage();

    if (!isAssistant) {
      isWaitngNotifier.stopWaiting();
      return;
    }

    final isMessageOverLimit =
        messagesNotifier.canReplyLLMMessage(dailyKey, limit);

    if (isLimit) {
      if (isMessageOverLimit) {
        await usersNotifier.messageOverLimit();

        isWaitngNotifier.stopWaiting();
        return;
      }
    }

    await messagesNotifier.createAssistantMessage();
    isWaitngNotifier.stopWaiting();
  }

  Future<void> createSummary() async {
    isWaitngNotifier.startWaiting();
    await usersNotifier.isConversationEnd();
    await usersNotifier.isMessageOverLimitReset();

    final String summary = await messagesNotifier.createSummary();
    await dailyNotifier.saveSummary(summary);

    isWaitngNotifier.stopWaiting();
  }
}

import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/usecases/messages_usecase.dart';
import 'package:aizuchi_app/presentation/model/message_model.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/messsage_providers.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messagesNotifierProvider =
    StateNotifierProvider<MessagesNotifier, AsyncValue<List<MessageModel>>>(
        (ref) {
  return MessagesNotifier(
    ref,
    ref.watch(messagesUsecaseProvider),

  );

});

class MessagesNotifier extends StateNotifier<AsyncValue<List<MessageModel>>> {
  MessagesNotifier(this.ref, this._messageUsecase)
      : super(const AsyncValue.loading()) {
    initialize();
  }

  final Ref ref;
  final MessageUsecases _messageUsecase;

  void initialize() async {
    final List<MessageEntity> messageEntity = await _messageUsecase.readAll();
    final List<MessageModel> messages = messageEntity
        .map((message) => MessageModel.fromEntity(message))
        .toList();
    state = AsyncValue.data(messages);
  }

  Future<void> createDateMessage() async {
    final String key = ref.read(usersNotifierProvider).asData!.value.dailyKey;

    try {
      final MessageEntity datetimeMessageEntity =
          await _messageUsecase.saveMessage("", key, MessageType.datetime);
      final MessageModel datetimeMessage =
          MessageModel.fromEntity(datetimeMessageEntity);
      state = AsyncValue.data([...?state.value, datetimeMessage]);
    } catch (e) {
      throw Exception("日時メッセージの作成に失敗しました$e");
    }
  }

  Future<void> createEmotionMessage() async {
    final String key = ref.read(usersNotifierProvider).asData!.value.dailyKey;
    final EmotionType emotion = ref.read(emotionProvider);

    try {
      final MessageEntity emtionMessageEntity = await _messageUsecase
          .saveMessage(emotion.emotionValue ?? "", key, MessageType.emotion);
      final MessageModel emtionMessage =
          MessageModel.fromEntity(emtionMessageEntity);
      state = AsyncValue.data([...?state.value, emtionMessage]);
    } catch (e) {
      throw Exception("感情メッセージの作成に失敗しました$e");
    }
  }

  Future<void> createUserMessage() async {
    final String key = ref.read(usersNotifierProvider).asData!.value.dailyKey;
    final String messageContent = ref.read(messageProvider);

    try {
      final MessageEntity messageEntity = await _messageUsecase.saveMessage(
          messageContent, key, MessageType.user);
      final MessageModel newMessage = MessageModel.fromEntity(messageEntity);

      state = AsyncValue.data([...?state.value, newMessage]);
    } catch (e) {
      throw Exception("ユーザーメッセージの作成に失敗しました$e");
    }
  }

  Future<void> createAssistantMessage() async {
    final String key = ref.read(usersNotifierProvider).asData!.value.dailyKey;
    final EmotionType emotion = ref.read(emotionProvider);

    final List<MessageEntity> messagesEntity = state.asData!.value
        .map((messageModel) => messageModel.toEntity())
        .toList();
    final String newReply = await _messageUsecase.sendAndReceiveLLMMessage(
        messagesEntity, key, emotion);

    final MessageEntity messageEntity =
        await _messageUsecase.saveMessage(newReply, key, MessageType.assistant);
    final MessageModel message = MessageModel.fromEntity(messageEntity);
    state = AsyncValue.data([...?state.value, message]);
  }

  Future<String> createSummary() async {
    final String key = ref.read(usersNotifierProvider).asData!.value.dailyKey;

    final List<MessageEntity> messagesEntity = state.asData!.value
        .map((messageModel) => messageModel.toEntity())
        .toList();

    final String summary = await _messageUsecase.createSummary(messagesEntity);

    final MessageEntity messageEntity = await _messageUsecase.saveMessage(
        "お疲れ様でした😊", key, MessageType.assistant);

    final MessageModel message = MessageModel.fromEntity(messageEntity);
    state = AsyncValue.data([...?state.value, message]);

    return summary;
  }

  bool canReplyLLMMessage(String key) {
    final List<MessageEntity> messagesEntity = state.asData!.value
        .map((messageModel) => messageModel.toEntity())
        .toList();

    final bool isMessageOverLimit =
        _messageUsecase.canReplyLLMMessage(messagesEntity, key);

    return isMessageOverLimit;
  }

  Future<void> deleteAll() async {
    await _messageUsecase.deleteAll();
    state = const AsyncValue.loading();
  }
}

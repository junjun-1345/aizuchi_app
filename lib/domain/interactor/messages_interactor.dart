import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/repositories/gpt_repository.dart';
import 'package:aizuchi_app/domain/repositories/message_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/gemini_repository.dart';
import 'package:aizuchi_app/domain/usecases/messages_usecase.dart';
import 'package:uuid/uuid.dart';

class MessagesInteractor implements MessageUsecases {
  final MessageDBRepository messageDBRepository;
  final GeminiRepository geminiRepository;
  final GptRepository gptRepository;

  MessagesInteractor(
    this.messageDBRepository,
    this.geminiRepository,
    this.gptRepository,
  );

  @override
  Future<String> sendAndReceiveLLMMessage(
    List<MessageEntity> messages,
    String key,
    EmotionType emotion,
  ) async {
    int? todayLatestIndex =
        messages.indexWhere((messageEntity) => messageEntity.id == key);
    // 最新のチャットなし
    if (todayLatestIndex >= 0) {
      messages.removeRange(0, todayLatestIndex);
      messages.removeWhere((value) => value.type == MessageType.datetime);
      // messages.removeWhere((value) => value.type == MessageType.emotion);
    }

    final newReplyContent = await gptRepository.reply(
      messages,
      emotion,
    );

    return newReplyContent;
  }

  @override
  Future<MessageEntity> saveMessage(
      String message, String key, MessageType type) async {
    final String uuid = const Uuid().v4();
    final MessageEntity newMessage;

    if (type == MessageType.emotion) {
      newMessage = MessageEntity(
        id: "${key}_$uuid",
        createdAt: DateTime.now(),
        content: message,
        type: type,
      );
      //TODO: dailyにも保存
    } else if (type == MessageType.datetime) {
      newMessage = MessageEntity(
        id: key,
        createdAt: DateTime.now(),
        content: "",
        type: type,
      );
    } else {
      newMessage = MessageEntity(
          id: "${key}_$uuid",
          createdAt: DateTime.now(),
          content: message,
          type: type);
    }

    await messageDBRepository.create(newMessage);
    return newMessage;
  }

  @override
  Future<void> deleteAll() async {
    await messageDBRepository.deleteAll();
  }

  @override
  Future<String> createSummary(List<MessageEntity> messages) {
    return gptRepository.createSummary(messages);
  }

  @override
  bool canReplyLLMMessage(List<MessageEntity> messages, String key) {
    const int limit = 4;
    final List<MessageEntity> filteredList;
    int? index =
        messages.indexWhere((messageEntity) => messageEntity.id == key);
    // 最新のチャットなし
    if (index == -1) {
      return false;
    } else {
      messages.removeRange(0, index);
      filteredList = messages
          .where((messageEntity) => messageEntity.type == MessageType.assistant)
          .toList();
    }
    print("filteredList.length: ${filteredList.length}");
    if (filteredList.length >= limit) {
      print("制限超え");
      return true;
    } else {
      print("制限内");
      return false;
    }
  }

  @override
  Future<List<MessageEntity>> readAll() async {
    return messageDBRepository.readAll();
  }
}

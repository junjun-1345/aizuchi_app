import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/repositories/claude_repository.dart';
import 'package:aizuchi_app/domain/repositories/daily_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/gemini_repository.dart';
import 'package:aizuchi_app/domain/repositories/gpt_repository.dart';
import 'package:aizuchi_app/domain/repositories/message_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/messages_usecase.dart';

class MessagesInteractor implements MessageUsecase {
  final MessageDBRepository messageDBRepository;
  final DailyDBRepository dailyDBRepository;
  final UserDBRepository userDBRepository;
  final GeminiRepository geminiRepository;
  final GptRepository gptRepository;
  final ClaudeRepository claudeRepository;

  MessagesInteractor(
    this.messageDBRepository,
    this.dailyDBRepository,
    this.userDBRepository,
    this.geminiRepository,
    this.gptRepository,
    this.claudeRepository,
  );

  @override
  Future<String> sendAndReceiveLLMMessage(
    List<MessageEntity> messages,
    String key,
    EmotionType emotion,
  ) async {
    final filteredMessages = _filterMessages(messages, key);
    final newReplyContent = await claudeRepository.reply(
      filteredMessages,
      emotion,
    );
    return newReplyContent;
  }

  @override
  Future<MessageEntity> saveMessage(
      String message, String key, MessageType type) async {
    final content = type == MessageType.datetime ? "" : message;
    final newMessage = MessageEntity(
      id: key,
      createdAt: DateTime.now(),
      content: content,
      type: type,
    );
    await messageDBRepository.create(newMessage);
    return newMessage;
  }

  @override
  Future<void> deleteAll() async {
    await messageDBRepository.deleteAll();
  }

  @override
  Future<String> createSummary(
    List<MessageEntity> messages,
    String key,
  ) async {
    final filteredMessages = _filterMessages(messages, key);
    // TODO: messageDBから会話数を取得し、userDBのtotalMessageに加算する
    final messageCount = await messageDBRepository.getDocumentCount();
    final dailyCount = await dailyDBRepository.getDocumentCount();
    userDBRepository.update(
      activeDay: dailyCount,
      totalMessages: messageCount,
    );
    return claudeRepository.createSummary(filteredMessages);
  }

  @override
  bool canReplyLLMMessage(List<MessageEntity> messages, String key) {
    const int limit = 4;
    final filteredMessages = _filterMessages(messages, key)
        .where((messageEntity) => messageEntity.type == MessageType.assistant)
        .toList();
    return filteredMessages.length >= limit;
  }

  @override
  Future<List<MessageEntity>> readAll() async {
    return messageDBRepository.readAll();
  }

  // メッセージをフィルタリングする共通のプライベートメソッド
  List<MessageEntity> _filterMessages(
      List<MessageEntity> messages, String key) {
    int? index =
        messages.indexWhere((messageEntity) => messageEntity.id == key);
    if (index >= 0) {
      return messages.sublist(index + 1);
    }
    return messages;
  }
}

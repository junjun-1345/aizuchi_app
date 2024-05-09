import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';

abstract class MessageUsecase {
  Future<MessageEntity> saveMessage(
    String message,
    String key,
    MessageType type,
  );
  Future<String> sendAndReceiveLLMMessage(
    List<MessageEntity> messages,
    String key,
    EmotionType emotion,
  );
  Future<List<MessageEntity>> readAll();
  Future<String> createSummary(
    List<MessageEntity> messages,
    String key,
  );
  bool canReplyLLMMessage(
    List<MessageEntity> messages,
    String key,
  );
  Future<void> deleteAll();
}
